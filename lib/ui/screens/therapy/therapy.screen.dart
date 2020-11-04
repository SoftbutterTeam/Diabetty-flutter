import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Consumer<TherapyManager>(
          builder: (_, TherapyManager manager, __) => TherapyScreen._(
            isLoading: isLoading.value,
            manager: manager,
          ),
        ),
      ),
    );
  }
}

class TherapyScreen extends StatefulWidget {
  @override
  const TherapyScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final TherapyManager manager;
  final bool isLoading;

  @override
  _TherapyScreenState createState() => _TherapyScreenState(manager);
}

class _TherapyScreenState extends State<TherapyScreen> {
  TherapyManager manager;
  _TherapyScreenState(this.manager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      onPressed2: () {
        Navigator.pushNamed(context, appsettings);
      },
      onPressed: () {
        final actionsheet = addTherapyActionSheet(context);
        showCupertinoModalPopup(
            context: context, builder: (context) => actionsheet);
      },
      child: Container(
        width: size.width,
        child: _buildTherapiesList(context),
      ),
    );
  }

  _buildTherapiesList(BuildContext context) {
    return StreamBuilder(
        stream: manager.therapyStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0) {
            print(snapshot.data.toString());
            return Container(
              child: null,
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Column(
              children: [
                Center(
                  child: text('Error'),
                ),
              ],
            );
          }
          List<Therapy> therapiesData = snapshot.data;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: therapiesData.length,
                itemBuilder: (context, index) {
                  return TherapyCard(
                    therapyData: therapiesData[index],
                  );
                }),
          );
        });
  }

  CupertinoActionSheet addTherapyActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: text("Medication", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {
            final TherapyManager therapyManager =
                Provider.of<TherapyManager>(context, listen: false);
            therapyManager.resetForm();
            print('this far');
            Navigator.pushReplacementNamed(context, addmedication);
          },
        ),
        CupertinoActionSheetAction(
          child: text("Other Types", fontSize: 18.0, textColor: Colors.indigo),
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Container(color: Colors.white, child: Text('Cancel')),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

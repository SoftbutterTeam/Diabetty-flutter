import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_card.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile.screen.dart';
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

class _TherapyScreenState extends State<TherapyScreen>
    with AddTherapyModalsMixin {
  TherapyManager manager;
  _TherapyScreenState(this.manager);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          height: size.height,
          width: size.width,
          child: _buildTherapiesList(context),
        ),
      ],
    );
  }

  _buildTherapiesList(BuildContext context) {
    return StreamBuilder(
        stream: manager.therapyStream,
        initialData: manager.usersTherapies,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            //print(snapshot.data.toString());
            return Container(
              child: null,
            );
          }
          List<Therapy> therapies = snapshot.data;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: therapies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TherapyProfileScreen(
                                therapy: therapies[index], manager: manager)),
                      );
                    },
                    child: TherapyCard(
                      therapyData: therapies[index],
                    ),
                  );
                }),
          );
        });
  }
}

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/theraphy/add.medication.screen.dart';
import 'package:diabetty/ui/screens/theraphy/components/background.dart';
import 'package:diabetty/ui/screens/theraphy/components/medication_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<TherapyManager>(
          create: (_) =>
              TherapyManager(appContext: appContext, isLoading: isLoading),
          child: Consumer<TherapyManager>(
            builder: (_, TherapyManager manager, __) =>
                TherapyScreen._(isLoading: isLoading.value, manager: manager),
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
  _TherapyScreenState createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  void _showExpandedTherapy(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black12,
      transitionDuration: Duration(milliseconds: 0),
      context: context,
      pageBuilder: (_, __, ___) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.only(bottom: size.height / 1.4),
              height: size.height * 0.3,
              width: size.width,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Stack(children: <Widget>[
                    Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [Colors.orange[900], Colors.orange[600]]),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 25,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    
                  ]),
                  Positioned(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: size.height * 0.08),
                          // color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {},
                                child: subHeadingText("Add Medication", Colors.white),
                              ),
                              FlatButton(
                                onPressed: () {
                                  print('hihihi');
                                },
                                child: subHeadingText("Add Other", Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(color: Colors.transparent))),
          ],
        ),
      ),
    );
  }

  _buildTherapiesList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Therapy> therapyList;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder(
          stream: widget.manager.dataStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              therapyList = new List.filled(5, new Therapy());
              print("nothing here");
            } // to produce empty cards i.e. placeholders
            else {
              print("somethinf here");
              therapyList = snapshot.data;
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MedicationCard(
                    name: "Medication Name",
                    appearance: Icon(Icons.add_to_queue),
                  );
                });

            /// todo place the Card Widgets here using TherapyList(index)
            /// as a parameter.
          }),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      onPressed2: () {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddMedicationScreen()),
  );
      },
      onPressed: () {
        _showExpandedTherapy(context);
        print('hihihi');
      },
      child: Container(
        width: size.width,
        child: _buildTherapiesList(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        //...top circlular image part,
      ],
    );
  }
}

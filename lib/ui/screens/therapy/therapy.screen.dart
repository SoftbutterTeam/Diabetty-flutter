import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TherapyManager therapyManager = null;
    final isLoading = null;
    return TherapyScreen._(isLoading: true, manager: therapyManager);
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
  TherapyManager manager;

  _buildTherapiesList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Therapy> therapyList;
    return StreamBuilder(
        stream: manager.therapyStream,
        builder: (context, snapshot) {
          //List<TimeSlot> timeSlots = manager.getRemindersByTimeSlots();
          if (snapshot.hasData) {
            return LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else if (therapyList.length == 0) {
            return Column(
              children: [
                Center(
                  child: text('no reminders for today'),
                ),
              ],
            );
          }
        });

    // return Container(
    //   margin: EdgeInsets.symmetric(horizontal: 20),
    //   child: ListView.builder(
    //       scrollDirection: Axis.vertical,
    //       itemCount: 3,
    //       itemBuilder: (context, index) {
    //         return MedicationCard(
    //           name: "Medication Name",
    //           appearance: 'assets/icons/navigation/essentials/pills.svg',
    //         );
    //       }),
    // );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      onPressed2: () {},
      onPressed: () {
        // _showExpandedTherapy(context);
        final actionsheet = CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child:
                  text("Medication", fontSize: 18.0, textColor: Colors.indigo),
              onPressed: () {
                final TherapyManager therapyManager =
                    Provider.of<TherapyManager>(context, listen: false);
                therapyManager.resetForm();
                print('this far');
                Navigator.pushReplacementNamed(context, addmedication);
              },
            ),
            CupertinoActionSheetAction(
              child:
                  text("Other Types", fontSize: 18.0, textColor: Colors.indigo),
              onPressed: () {},
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel",
                style: TextStyle(color: CupertinoColors.destructiveRed)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
        showCupertinoModalPopup(
            context: context, builder: (context) => actionsheet);
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

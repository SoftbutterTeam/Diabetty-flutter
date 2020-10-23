import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/medication_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TherapyManager therapyManager = null;
    final isLoading = null;
    // return TherapyScreen._(isLoading: true, manager: therapyManager);
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
  // TherapyManager manager = TherapyManager();
  void _showExpandedTherapy(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -0.5);
        var end = Offset.zero;
        var curve = Curves.linear;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        if (offsetAnimation.status == AnimationStatus.reverse) {
          offsetAnimation.value.translate(0, -0.5);
          return SizedBox(
            height: size.height,
            width: size.width,
          );
        }
        return child; //* to remove animation, I slyly prefer no animation
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (_, __, ___) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            AddModal2(), //* AddModal or AddModal2
            Expanded(
                child: GestureDetector(
                    onPanStart: (value) {
                      Navigator.pop(context);
                    },
                    child: Container(color: Colors.transparent))),
          ],
        ),
      ),
    );
  }

  _buildTherapiesList(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<Therapy> therapyList;
    return StreamBuilder(
        stream: manager.therapyStream,
        builder: (context, snapshot) {
          //List<TimeSlot> timeSlots = manager.getRemindersByTimeSlots();
          if (snapshot.hasData) {
            print("has data");
            print(snapshot.data.toString());
            return Column(
              children: [
                Center(
                  child: text('has datta'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Column(
              children: [
                Center(
                  child: text(snapshot.error.toString()),
                ),
              ],
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MedicationCard(
                    name: "Medication Name",
                    appearance: 'assets/icons/navigation/essentials/pills.svg',
                  );
                }),
          );
        });
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      onPressed2: () {},
      onPressed: () {
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

/*
  I REMOVED THIS FROM THIS FILE BUT I DIDN'T KNOW IF YOU NEEDED IT SO HERE IT IS

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
@ -75,36 +142,7 @@ class _TherapyScreenState extends State<TherapyScreen> {
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
*/

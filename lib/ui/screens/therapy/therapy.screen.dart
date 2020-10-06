import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/screens/therapy/components/add_modal.v2.dart';
import 'package:diabetty/ui/screens/therapy/components/background.dart';
import 'package:diabetty/ui/screens/therapy/components/medication_card.dart';
import 'package:flutter/material.dart';

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
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      onPressed2: () {},
      onPressed: () {
        _showExpandedTherapy(context);
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

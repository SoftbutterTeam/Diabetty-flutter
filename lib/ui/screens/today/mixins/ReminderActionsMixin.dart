import 'dart:ui';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:intl/intl.dart';

@optionalTypeArgs
mixin ReminderActionsMixin<T extends Widget> {
  @protected
  Reminder get reminder;

  void showTakeModalPopup(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          //  title: const Text('When did you it?'),
          message: const Text('When did you take it?'),

          actions: <Widget>[
            CupertinoActionSheetAction(onPressed: () {}, child: Text('Now')),
            CupertinoActionSheetAction(
                onPressed: () {}, child: Text('On Time')),
            CupertinoActionSheetAction(
                onPressed: () {}, child: Text('Choose a Time')),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Container(color: Colors.white, child: Text('Cancel')),
          ),
        ),
      );

  void showReminderPopupModal(BuildContext context) => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black38, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            child: ReminderInfoModal(reminder: reminder)),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  _transitionBuilderStyle1() =>
      (BuildContext context, Animation<double> anim1, anim2, Widget child) {
        bool isReversed = anim1.status == AnimationStatus.reverse;
        double animValue = isReversed ? 0 : anim1.value;
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 8 * animValue, sigmaY: 8 * animValue),
          child: Container(
            alignment: Alignment.center,
            child: FadeTransition(
              child: child,
              opacity: anim1,
            ),
          ),
        );
      };
}

class ReminderInfoModal extends StatefulWidget {
  const ReminderInfoModal({
    this.reminder,
    Key key,
  }) : super(key: key);

  final Reminder reminder;

  @override
  _ReminderInfoModalState createState() => _ReminderInfoModalState();
}

class _ReminderInfoModalState extends State<ReminderInfoModal> {
  MaterialColor colorToFade;
  double opacity;

  @override
  void initState() {
    colorToFade = widget.reminder.isComplete ? Colors.green : Colors.grey;
    opacity = widget.reminder.isComplete ? .3 : .3;
    super.initState();
  }

  double curve = 15;
  double bottomCurve;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(curve),
          //         topRight: Radius.circular(curve),
          //         bottomLeft: Radius.circular(bottomCurve ?? curve),
          //         bottomRight: Radius.circular(bottomCurve ?? curve)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.2),
          //         spreadRadius: 1,
          //         blurRadius: 3,
          //         offset: Offset(0, 3),
          //       ),
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.2),
          //         spreadRadius: 1,
          //         blurRadius: 0,
          //         offset: Offset(0, 0.5),
          //       ),
          //     ]),
          child: SizedBox(
            width: 350,
            height: 300,
            child: Card(
              shadowColor: Colors.black12,
              elevation: 1,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(curve),
              ),
              child: _buildContent(context),
            ),
          )),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: _buildHeader(),
          ),
          Flexible(
            flex: 3,
            child: _buildBody(),
          ),
          Flexible(
            flex: 2,
            child: _buildFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.trip_origin),
          text('Medication Name'),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 10),
              text('Scheduled for 08:00, today', fontSize: 12.0),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.filter_center_focus, size: 20),
              SizedBox(width: 10),
              text('Take 3 pill(s)', fontSize: 12.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: Container(
          decoration: BoxDecoration(
              color: widget.reminder.isComplete ? Colors.greenAccent : null,
              gradient: RadialGradient(
                radius: 5,
                tileMode: TileMode.mirror,
                focalRadius: 2,
                colors: [
                  colorToFade.shade300.withOpacity(opacity),
                  colorToFade.shade200.withOpacity(opacity),
                  Colors.white.withOpacity(.1),
                  Colors.white.withOpacity(.1),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(curve), // was 20  10
                topRight: Radius.circular(curve),
              )),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40),
            child: Container(
              alignment: Alignment.center,
              child: text(
                'random text',
                textColor: Colors.black87,
                fontFamily: 'Regular',
                fontSize: textSizeMedium,
              ),
            ),
          )),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.reminder.isComplete ? Colors.greenAccent : null,
            gradient: RadialGradient(
              radius: 5,
              tileMode: TileMode.mirror,
              focalRadius: 2,
              colors: [
                Colors.white.withOpacity(.1),
                colorToFade.shade200.withOpacity(opacity),
                colorToFade.shade500.withOpacity(opacity),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomCurve ?? curve), // was 20  10
              bottomRight: Radius.circular(bottomCurve ?? curve),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 75,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _skipActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/x/close.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Skip",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 75,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _takenActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/checkbox/tick_outline2.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Take",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 75,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _snoozeActionSheet(context);
                        },
                        padding: EdgeInsets.all(3),
                        icon: SvgPicture.asset(
                          'assets/icons/navigation/clock/wall-clock.svg',
                          width: 30,
                          height: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      text(
                        "Snooze",
                        textColor: Colors.black,
                        fontFamily: fontSemibold,
                        fontSize: 12.0,
                        maxLine: 2,
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void _snoozeActionSheet(BuildContext context) {
    final snoozeActionSheet = CupertinoActionSheet(
      message: text("How long do you want to snooze for?",
          fontSize: 16.0, textColor: Colors.black, isCentered: true),
      actions: [
        CupertinoActionSheetAction(
          child: text("Snooze 10m", fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Snooze 30m", fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Snooze 1hr", fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Postpone until...",
              fontSize: 16.0, textColor: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            _showSnooze(context);
          },
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
        context: context, builder: (context) => snoozeActionSheet);
  }

  _showSnooze(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CustomTimerPicker(
          desciption:
              'A period of time set to snooze your reminder of Medication Name',
          height: height,
          width: width,
          onPressed: () {
            Navigator.pop(context);
          },
          timerPicker: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            initialTimerDuration: Duration(minutes: 0),
            onTimerDurationChanged: (Duration changedtimer) {
              print(changedtimer);
            },
          ),
        );
      },
    );
  }

  void _skipActionSheet(BuildContext context) {
    final skipActionSheet = CupertinoActionSheet(
      message: text("Can you please indicate why you're skipping this dose?",
          maxLine: 2,
          fontSize: 16.0,
          textColor: Colors.black,
          isCentered: true),
      actions: [
        CupertinoActionSheetAction(
          child: text("Med isn't near me",
              fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Forgot / busy / asleep",
              fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Ran out of medication",
              fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Side effects / other health concerns",
              fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text("Other", fontSize: 16.0, textColor: Colors.black),
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
        context: context, builder: (context) => skipActionSheet);
  }

  void _takenActionSheet(BuildContext context) {
    final takenActionSheet = CupertinoActionSheet(
      message: text("When did you take your meds?",
          fontSize: 16.0, textColor: Colors.black, isCentered: true),
      actions: [
        CupertinoActionSheetAction(
          child: text("On Time", fontSize: 16.0, textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: text(
              "Now (" + DateFormat('HH:mm').format(DateTime.now()) + ")",
              fontSize: 16.0,
              textColor: Colors.black),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child:
              text("Pick Exact Time", fontSize: 16.0, textColor: Colors.black),
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
        context: context, builder: (context) => takenActionSheet);
  }
}

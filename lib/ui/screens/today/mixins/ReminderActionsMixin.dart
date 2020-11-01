import 'dart:ui';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile.screen.dart';
import 'package:diabetty/ui/screens/today/components/reminder_info.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:intl/intl.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

@optionalTypeArgs
mixin ReminderActionsMixin<T extends Widget> {
  @protected
  Reminder get reminder => reminder;

  void showSnoozeActionSheet(context) => showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            message: Text(
              "How long do you want to snooze for?",
            ),
            actions: [
              CupertinoActionSheetAction(
                child: Text("Snooze 10 min"),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text("Snooze 30 min"),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Reschedule till...",
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showPostponePicker(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Container(color: Colors.white, child: Text('Cancel')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));

  void showSkipActionSheet(context) => showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            message: Text("Why are you skipping this dose?"),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "No access / out of stock",
                ),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Busy / unavailable",
                ),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Side effects / other health concerns",
                ),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text("Other"),
                onPressed: () {},
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Container(color: Colors.white, child: Text('Cancel')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));

  void showTakenActionSheet(context) => showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            message: const Text('When did you take it?'),
            actions: <Widget>[
              CupertinoActionSheetAction(onPressed: () {}, child: Text('Now')),
              CupertinoActionSheetAction(
                  onPressed: () {}, child: Text('On Time')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    showExactTimePicker(context);
                  },
                  child: Text('Choose a Time')),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: Container(color: Colors.white, child: Text('Cancel')),
            ),
          ));

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
                onPressed: () {
                  Navigator.pop(context);
                  showExactTimePicker(context);
                },
                child: Text('Choose a Time')),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Container(color: Colors.white, child: Text('Cancel')),
          ),
        ),
      );

  void showPostponePicker(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return TimerPicker(
            onConfirm: () {
              Navigator.pop(context);
            },
            timepicker: CupertinoDatePicker(
              use24hFormat: false,
              mode: CupertinoDatePickerMode.time,
              minuteInterval: 1,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (dateTimeChange) {
                print(dateTimeChange);
              },
            ),
          );
        },
      );

  void showExactTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            Navigator.pop(context);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 1,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (dateTimeChange) {
              print(dateTimeChange);
            },
          ),
        );
      },
    );
  }

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
    this.manager,
    Key key,
  }) : super(key: key);

  final Reminder reminder;
  final TherapyManager manager;

  @override
  _ReminderInfoModalState createState() => _ReminderInfoModalState();
}

class _ReminderInfoModalState extends State<ReminderInfoModal>
    with ReminderActionsMixin {
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
          child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.33,
            child: Card(
              shadowColor: null,
              elevation: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(curve),
              ),
              child: _buildContent(context, size),
            ),
          )),
    );
  }

  Widget _buildContent(BuildContext context, size) {
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
            child: _buildBody2(size),
          ),
          Flexible(
            flex: 2,
            child: _buildFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(size) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            appearance_iconss[widget.reminder.apperance],
            width: 30,
            height: 30,
          ),
          text(widget.reminder.name),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 10),
              text(
                  'Scheduled for ' +
                      DateFormat('dd/MM/yy').format(widget.reminder.time),
                  fontSize: 12.0),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.filter_center_focus, size: 20),
              SizedBox(width: 10),
              text('Take ' + 'widget.reminder.dose.toString()' + ' pill(s)',
                  fontSize: 12.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(size) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      appearance_iconss[0],
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: text(widget.reminder.name,
                        fontSize: 18.0,
                        textColor: Colors.black,
                        fontFamily: fontBold,
                        latterSpacing: 1.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                    child: text('widget.reminder.advice',
                        fontSize: 15.0,
                        textColor: Colors.black87,
                        fontFamily: fontSemibold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 1,
            width: size.width * 0.75,
            color: Colors.black12,
            margin: EdgeInsets.only(bottom: 10),
          ),
          Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 20),
              text(
                  'Scheduled for ' +
                      DateFormat('dd/MM/yy').format(widget.reminder.time) +
                      ' at ' +
                      widget.reminder.time.formatTime(),
                  fontSize: 12.0),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.filter_center_focus, size: 20),
              SizedBox(width: 20),
              text('Take ' + widget.reminder.dose.toString() + ' pill(s)',
                  fontSize: 12.0),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_vert, color: Colors.transparent),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, therapyprofile),
                      child: Icon(Icons.more_horiz)),
                ),
              ],
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
    showSnoozeActionSheet(context);
  }

  void _skipActionSheet(BuildContext context) {
    showSkipActionSheet(context);
  }

  void _takenActionSheet(BuildContext context) {
    showTakenActionSheet(context);
  }
}

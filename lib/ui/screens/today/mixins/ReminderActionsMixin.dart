import 'dart:ui';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/index.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/today/components/reminder_info.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:intl/intl.dart';

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
                child: Text("Snooze 10m"),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text("Snooze 30m"),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text("Snooze 1hr"),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Postpone until...",
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
            message:
                Text("Can you please indicate why you're skipping this dose?"),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "Med isn't near me",
                ),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Forgot / busy / asleep",
                ),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Ran out of medication",
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

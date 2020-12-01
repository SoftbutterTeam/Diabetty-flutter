import 'dart:ui';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/today/components/reminder_info.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/mixins/reminder_manager_mixin.dart';
import 'package:provider/provider.dart';

@optionalTypeArgs
mixin ReminderActionsMixin<T extends Widget> {
  @protected
  Reminder get reminder;

  void snoozeReminder(
      BuildContext context, Reminder reminder, Duration snoozeFor) {
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: false);
    dayPlanManager.snoozeReminder(reminder, snoozeFor);
  }

  DayPlanManager getDayPlanManager(BuildContext context) =>
      Provider.of<DayPlanManager>(context, listen: false);

// pass reminder into here
  void showSnoozeActionSheet(BuildContext context, Reminder reminder) =>
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                message: Text(
                  "How long do you want to snooze for?",
                ),
                actions: [
                  CupertinoActionSheetAction(
                    child: Text("Snooze 10 min"),
                    onPressed: () {
                      Navigator.pop(context);
                      snoozeReminder(context, reminder, Duration(minutes: 10));
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text("Snooze 30 min"),
                    onPressed: () {
                      Navigator.pop(context);
                      snoozeReminder(context, reminder, Duration(minutes: 30));
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      "Reschedule till...",
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showPostponePicker(context, reminder);
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

  void skipReminder(BuildContext context, Reminder reminder) {
    DayPlanManager dayPlanManager = getDayPlanManager(context);
    dayPlanManager.skipReminder(reminder);
  }

  void showSkipActionSheet(context) => showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            message: Text("Why are you skipping this dose?"),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "No access / out of stock",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Busy / unavailable",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Side effects / other health concerns",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Other"),
                onPressed: () {
                  Navigator.pop(context);
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
/*
  void showTakenActionSheet(context) {
    DayPlanManager dayPlanManager = getDayPlanManager(context);

    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              message: const Text('When did you take it?'),
              actions: <Widget>[
                CupertinoActionSheetAction(
                    onPressed: () {
                      dayPlanManager.takeReminder(reminder, DateTime.now());
                    },
                    child: Text('Now')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      dayPlanManager.takeReminder(reminder, reminder.time);
                    },
                    child: Text('On Time')),
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
  }
*/
  void unTakeReminder(BuildContext context, Reminder reminder) {
    getDayPlanManager(context).unTakeReminder(reminder);
  }

  void showTakeActionPopup(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          DayPlanManager dayPlanManager = getDayPlanManager(context);

          return CupertinoActionSheet(
            //  title: const Text('When did you it?'),
            message: const Text('When did you take it?'),

            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);

                    dayPlanManager.takeReminder(reminder, DateTime.now());
                  },
                  child: Text('Now')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    dayPlanManager.takeReminder(reminder, reminder.time);
                    Navigator.pop(context);
                  },
                  child: Text('On Time')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    showExactTimePicker(
                      context,
                      (DateTime choosenTime) {
                        dayPlanManager.takeReminder(reminder, choosenTime);
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Text('Choose a Time')),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: Container(color: Colors.white, child: Text('Cancel')),
            ),
          );
        },
      );
  void showExactTimePicker(BuildContext context, Function function) {
    DateTime choosenTime;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            function(choosenTime);
            Navigator.pop(context);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: DateTime.now(),
            minuteInterval: 1,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (dateTimeChange) {
              choosenTime = dateTimeChange;
            },
          ),
        );
      },
    );
  }

  void showPostponePicker(BuildContext context, Reminder reminder) =>
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
              onDateTimeChanged: (dateTimeChange) {},
            ),
          );
        },
      );

  void showReminderPopupModal(BuildContext context) => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        barrierColor: Colors.black12, //black12 white
        pageBuilder: (context, anim1, anim2) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 3,
            child: ReminderInfoModal(reminder: reminder)),
        transitionBuilder: _transitionBuilderStyle1(),
        transitionDuration: Duration(milliseconds: 250),
      );

  _transitionBuilderStyle1() =>
      (BuildContext context, Animation<double> anim1, anim2, Widget child) {
        bool isReversed = anim1.status == AnimationStatus.reverse;
        double animValue = isReversed ? 0 : anim1.value;
        var size = MediaQuery.of(context).size;
        return SafeArea(
          child: BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 8 * animValue, sigmaY: 8 * animValue),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: size.height * .1),
              child: FadeTransition(
                opacity: anim1,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tp) =>
                            Navigator.pop(context),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      };
}

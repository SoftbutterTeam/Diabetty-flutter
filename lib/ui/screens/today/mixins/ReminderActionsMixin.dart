import 'dart:ui';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/screens/therapy/components/IntakePopUp.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile_screen2.dart';
import 'package:diabetty/ui/screens/today/components/reminder_info.widget.dart';
import 'package:diabetty/ui/screens/today/edit_dose.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/mixins/reminder_manager_mixin.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';

@optionalTypeArgs
mixin ReminderActionsMixin<T extends Widget> {
  @protected
  Reminder get reminder;

  void navigateToTherapy(BuildContext context, Reminder reminder) {
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: false);
    TherapyManager therapyManager = dayPlanManager.therapyManager;
    Therapy therapy = therapyManager?.usersTherapies
        ?.firstWhere((element) => element.id == reminder.therapyId);
    if (therapy == null) return null;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TherapyProfileScreen2(therapy: therapy, manager: therapyManager),
      ),
    );
  }

  void openTypeThing(BuildContext context, Reminder reminder, Size size, settingState) {
    int s;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IntakePopUp(
          height: size.height,
          width: size.width,
          onPressed: () {
            Navigator.of(context).pop(context);
            reminder.doseTypeIndex = s;
            settingState();
          },
          intakePicker: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: 0),
            itemExtent: 35,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int x) {
              s = x;
            },
            children: new List<Widget>.generate(
              unitTypes.length,
              (int index) {
                return new Center(
                  child: new Text(unitTypes[index].plurarlUnits(3)),
                );
              },
            ),
          ),
        );
      },
    );
  }

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
                      Navigator.of(context).pop(context);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text("Snooze 30 min"),
                    onPressed: () {
                      snoozeReminder(context, reminder, Duration(minutes: 30));
                      Navigator.of(context).pop(context);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      "Choose a Time",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(context);
                      showPostponePicker(context, reminder);
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Container(color: Colors.white, child: Text('Cancel')),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                ),
              ));

  void skipReminder(BuildContext context, Reminder reminder) {
    DayPlanManager dayPlanManager = getDayPlanManager(context);
    dayPlanManager.skipReminder(reminder);
  }

  void showReminderInfoMoreActionSheet(context) => showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "Edit Dose",
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditDosageScreen(
                              reminder: reminder,
                            )),
                  );
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Delete Reminder",
                ),
                onPressed: () {
                  getDayPlanManager(context).deleteReminder(reminder);
                  Navigator.of(context).pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Container(color: Colors.white, child: Text('Cancel')),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          ));

  void unTakeReminder(BuildContext context, Reminder reminder) {
    getDayPlanManager(context).unTakeReminder(reminder);
  }

  void takeReminder(BuildContext context, Reminder reminder) {
    getDayPlanManager(context).takeReminder(reminder, DateTime.now());
  }

  void showTakeActionPopup(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          DayPlanManager dayPlanManager = getDayPlanManager(context);

          return CupertinoActionSheet(
            message: const Text('Taken at?'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    dayPlanManager.takeReminder(reminder, DateTime.now());
                    Navigator.of(context).pop(context);
                  },
                  child: Text('Now')),
              if (!DateTime.now()
                  .isBefore(reminder.rescheduledTime ?? reminder.time))
                CupertinoActionSheetAction(
                    onPressed: () {
                      dayPlanManager.takeReminder(
                          reminder, reminder.rescheduledTime ?? reminder.time);
                      Navigator.of(context).pop(context);
                    },
                    child: Text('On Time')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                    showExactTimePicker(
                      context,
                      (DateTime choosenTime) {
                        dayPlanManager.takeReminder(reminder, choosenTime);
                      },
                    );
                  },
                  child: Text('Choose a Time')),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(context),
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
            Navigator.of(context).pop(context);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: DateTime.now().subtract(Duration(days: 7)),
            minuteInterval: 1,
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (dateTimeChange) {
              choosenTime = dateTimeChange;
            },
          ),
        );
      },
    );
  }

  void showPostponePicker(BuildContext context, Reminder reminder) {
    DateTime _dateTimeChange;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return TimerPicker(
          onConfirm: () {
            Navigator.of(context).pop(context);
            getDayPlanManager(context)
                .rescheduleReminder(reminder, _dateTimeChange);
          },
          timepicker: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.dateAndTime,
            minuteInterval: 1,
            minimumDate: DateTime.now(),
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (dateTimeChange) {
              _dateTimeChange = dateTimeChange;
            },
          ),
        );
      },
    );
  }

  void showActionSheet(BuildContext context, List<Reminder> reminder) =>
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          DayPlanManager dayPlanManager = getDayPlanManager(context);
          DateTime rescheduledTo;
          return CupertinoActionSheet(
            message: const Text('All Reminders'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    print(reminder);
                    // dayPlanManager.takeAllReminders(reminder);
                    Navigator.of(context).pop(context);
                  },
                  child: Text('Take All')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    // dayPlanManager.skipAllReminders(reminder);
                    Navigator.of(context).pop(context);
                  },
                  child: Text('Skip All')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    // dayPlanManager.rescheduleAllReminders(
                    //     reminder, rescheduledTo);
                    Navigator.of(context).pop(context);
                    showExactTimePicker(
                      context,
                      (DateTime choosenTime) {},
                    );
                  },
                  child: Text('Reschedule All')),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(context),
              child: Container(color: Colors.white, child: Text('Cancel')),
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
                            Navigator.of(context).pop(context),
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

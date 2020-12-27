import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/ui/screens/therapy/components/timerpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

@optionalTypeArgs
mixin TimeSlotActionsMixin<T extends Widget> {
  @protected
  TimeSlot get timeSlot;
  DayPlanManager getDayPlanManager(BuildContext context) =>
      Provider.of<DayPlanManager>(context, listen: false);
  void showTimeSlotActionSheet(BuildContext context, List<Reminder> reminder) {
    DayPlanManager dayPlanManager = getDayPlanManager(context);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          message:
              Text('${timeSlot.time.formatTime().toLowerCase()} Reminders'),
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);

                  dayPlanManager.takeAllReminders(timeSlot.reminders);
                },
                child: Text('Take All')),
            CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);

                  showExactTimePicker(
                    context,
                    (DateTime choosenTime) {
                      if (choosenTime != null && choosenTime != timeSlot.time)
                        dayPlanManager.rescheduleAllReminders(
                            timeSlot.reminders, choosenTime);
                    },
                  );
                },
                child: Text('Reschedule All')),
            CupertinoActionSheetAction(
                onPressed: () {
                  dayPlanManager.skipAllReminders(timeSlot.reminders);
                },
                child: Text('Skip All')),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Container(color: Colors.white, child: Text('Cancel')),
          ),
        );
      },
    );
  }

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
            initialDateTime: DateTime.now().add(Duration(minutes: 1)),
            maximumDate: DateTime.now().add(Duration(days: 7)),
            onDateTimeChanged: (dateTimeChange) {
              choosenTime = dateTimeChange;
            },
          ),
        );
      },
    );
  }
}

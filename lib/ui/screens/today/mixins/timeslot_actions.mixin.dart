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
  void showTimeSlotActionSheet(BuildContext context, List<Reminder> reminder) =>
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            message:
                Text('${timeSlot.time.formatTime().toLowerCase()} Reminders'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    getDayPlanManager(context)
                        .takeAllReminders(timeSlot.reminders);
                  },
                  child: Text('Take All')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                    showExactTimePicker(
                      context,
                      (DateTime choosenTime) {
                        getDayPlanManager(context).rescheduleAllReminders(
                            timeSlot.reminders, choosenTime);
                      },
                    );
                  },
                  child: Text('Reschedule All')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop(context);

                    getDayPlanManager(context)
                        .skipAllReminders(reminder);
                  },
                  child: Text('Skip All')),
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
}

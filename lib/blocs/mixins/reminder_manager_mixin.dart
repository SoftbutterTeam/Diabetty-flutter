import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/services/reminder.service.dart';

abstract class ReminderManagerMixin<T extends Manager> {
  ReminderService reminderService = ReminderService();
  /**
    Big Brain todos
      - what if a Reminder is Taken, and then cancelled after. Does it still have takenAt
      - what if Reminder is cancelled and then taken/reschedueld/snoozed

    Tips if you need something from the day manager use @protected get. 
    e.g. is in the ReminderActionsMixin
   */
  @protected
  void updateListeners();

  void takeReminder(Reminder reminder, DateTime takenAt) async {
    takenAt ??= DateTime.now();
    reminder.takenAt = takenAt;
    reminder.skippedAt = null;
    // update Push Notifcations
    reminderService.saveReminder(reminder);
    updateListeners();
  }

  void unTakeReminder(Reminder reminder) async {
    reminder.takenAt = null;
    reminder.skippedAt = null;
    reminderService.saveReminder(reminder);
    updateListeners();
  }
  /**
     Calls the Service Code.
     -> reminder.takenAt -> DateTime takenAt
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners r
    */

  void skipReminder(Reminder reminder) async {
    reminder.takenAt = null;
    reminder.skippedAt = DateTime.now();
    print('skipped --here');
    reminderService.saveReminder(reminder);
    // update Push Notifcations
    updateListeners();

    /**
     Calls the Service Code.
     -> reminder.cancelled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 

    */
  }

  Future<void> snoozeReminder(Reminder reminder, Duration snoozeFor) async {
    reminder.rescheduledTime =
        (reminder.rescheduledTime ?? reminder.time).add(snoozeFor);
    reminder.skippedAt = null;
    reminder.takenAt = null;
    reminderService.saveReminder(reminder);
    updateListeners();
    /**
     Calls the Service Code.
     -> reminder.time -> time.add( duration snoozeFor)
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
      -> then calls updateListeners 
    */
  }

  Future<void> rescheduleReminder(
      Reminder reminder, DateTime rescheduledTo) async {
    if (rescheduledTo == null) return null;
    reminder.rescheduledTime = rescheduledTo;
    reminder.takenAt = null;
    reminder.skippedAt = null;
    reminderService.saveReminder(reminder);
    updateListeners();
    /**
     Calls the Service Code.
     -> reminder.time -> rescheduledTo
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
  }

  Future<void> editDoseReminder(Reminder reminder, int dose) async {
    reminder.dose = dose;
    reminder.doseEdited = true;
    reminderService.saveReminder(reminder);
    updateListeners();
    /**
     Calls the Service Code.
     -> dose-> dose
     -> reminder.doseEdited -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
  }
}

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

  void takeReminder(Reminder reminder, DateTime takenAt) {
    takenAt ??= DateTime.now();
    reminder.takenAt = takenAt;
    reminder.cancelled = false;
    // update Push Notifcations
    reminderService.saveReminder(reminder);
    updateListeners();
  }
  /**
     Calls the Service Code.
     -> reminder.takenAt -> DateTime takenAt
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */

  void skipReminder(Reminder reminder) {
    reminder.takenAt = null;
    reminder.cancelled = true;
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

  void snoozeReminder(Reminder reminder, Duration snoozeFor) {
    reminder.rescheduledTime = reminder.time.add(snoozeFor);
    reminder.cancelled = false;
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

  void rescheduleReminder(Reminder reminder, DateTime rescheduledTo) {
    reminder.rescheduledTime = rescheduledTo;
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

  void editDoseReminder(Reminder reminder, int dose) {
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

import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:flutter/cupertino.dart';

abstract class ReminderManagerMixin<T extends Manager> {
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

    /**
     Calls the Service Code.
     -> reminder.takenAt -> DateTime takenAt
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
    updateListeners();
  }

  void skipReminder(Reminder reminder) {
    /**
     Calls the Service Code.
     -> reminder.cancelled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 

    */
  }

  void snoozeReminder(Reminder reminder, Duration snoozeFor) {
    /**
     Calls the Service Code.
     -> reminder.time -> time.add( duration snoozeFor)
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
      -> then calls updateListeners 
    */
  }

  void rescheduleReminder(Reminder reminder, DateTime rescheduledTo) {
    /**
     Calls the Service Code.
     -> reminder.time -> rescheduledTo
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
  }

  void editDoseReminder(Reminder reminder, int dose) {
    /**
     Calls the Service Code.
     -> dose-> dose
     -> reminder.doseEdited -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
  }
}

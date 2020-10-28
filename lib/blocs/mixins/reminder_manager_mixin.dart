import 'package:diabetty/models/reminder.model.dart';

class ReminderManagerMixin {
  /**
    Big Brain todos
      - what if a Reminder is Taken, and then cancelled after. Does it still have takenAt
      - what if Reminder is cancelled and then taken/reschedueld/snoozed

    Tips if you need something from the day manager use @protected get. 
    e.g. is in the ReminderActionsMixin
   */

  void takeReminder(Reminder reminder, DateTime takenAt) {
    takenAt ??= DateTime.now();

    /**
     Calls the Service Code.
     -> reminder.takenAt -> DateTime takenAt
     -> if Reminder is not Stored, Save.
    */
  }

  void skipReminder(Reminder reminder) {
    /**
     Calls the Service Code.
     -> reminder.cancelled -> true
     -> if Reminder is not Stored, Save.
    */
  }

  void snoozeReminder(Reminder reminder, Duration snoozeFor) {
    /**
     Calls the Service Code.
     -> reminder.time -> time.add( duration snoozeFor)
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
     
    */
  }

  void rescheduleReminder(Reminder reminder, DateTime rescheduledTo) {
    /**
     Calls the Service Code.
     -> reminder.time -> rescheduledTo
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
    */
  }

  void editDoseReminder(Reminder reminder, int dose) {
    /**
     Calls the Service Code.
     -> dose-> dose
     -> reminder.doseEdited -> true
     -> if Reminder is not Stored, Save.
    */
  }
}

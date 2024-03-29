import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/services/reminder.service.dart';
import 'package:flutter/material.dart';

abstract class ReminderManagerMixin<T extends Manager> {
  ReminderService reminderService = ReminderService();
  @protected
  void updateListeners();
  @protected
  TherapyManager therapyManager;

  void takeReminder(Reminder reminder, DateTime takenAt,
      {update = true}) async {
    takenAt ??= DateTime.now();
    reminder.takenAt = takenAt;
    reminder.skippedAt = null;
    // update Push Notifcations
    reminderService.saveReminder(reminder);
    Therapy therapy = therapyManager?.usersTherapies?.firstWhere(
      (element) => element.id == reminder.therapyId,
      orElse: () => null,
    );
    if (therapy != null && therapy.stock != null)
      therapy.stock.takenAmount(reminder.dose);
    if (update) updateListeners();
  }

  void takeMedication(Therapy therapy, DateTime takenAt,
      {update = true, int dose = 1}) async {
    ReminderRule reminderRule = new ReminderRule(
        days: Days.fromDate(DateTime.now()),
        time: TimeOfDay.fromDateTime(takenAt),
        dose: dose);
    Reminder reminder =
        Reminder.generated(therapy, reminderRule, DateTime.now());
    takenAt ??= DateTime.now();
    reminder.takenAt = takenAt;
    reminder.skippedAt = null;
    // update Push Notifcations
    reminderService.saveReminder(reminder);

    if (therapy != null && therapy.stock != null)
      therapy.stock.takenAmount(reminder.dose);
    if (update) updateListeners();
  }

  void unTakeReminder(Reminder reminder) async {
    reminder.takenAt = null;
    reminder.skippedAt = null;

    reminderService.saveReminder(reminder);
    Therapy therapy = therapyManager?.usersTherapies?.firstWhere(
      (element) => element.id == reminder.therapyId,
      orElse: () => null,
    );
    if (therapy != null && therapy.stock != null)
      therapy.stock.refillAdd(reminder.dose);
    updateListeners();
  }

  Future<void> deleteReminder(Reminder reminder) async {
    reminder.takenAt = null;
    reminder.skippedAt = null;
    reminder.rescheduledTime = null;
    reminder.deletedAt = DateTime.now();
    await reminderService.saveReminder(reminder);

    updateListeners();
  }
  /**
     Calls the Service Code.
     -> reminder.takenAt -> DateTime takenAt
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners r
    */

  skipReminder(Reminder reminder, {update = true}) async {
    reminder.takenAt = null;
    reminder.skippedAt = DateTime.now();
    // print('skipped --here');
    reminderService.saveReminder(reminder);
    // update Push Notifcations
    if (update) updateListeners();

    /**
     Calls the Service Code.
     -> reminder.cancelled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 

    */
  }

  unSkipReminder(Reminder reminder, {update = true}) async {
    reminder.takenAt = null;
    reminder.skippedAt = null;
    // print('unskipped --here');
    reminderService.saveReminder(reminder);
    // update Push Notifcations
    if (update) updateListeners();

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

  Future<void> rescheduleReminder(Reminder reminder, DateTime rescheduledTo,
      {update = true}) async {
    if (rescheduledTo == null) return null;
    reminder.rescheduledTime = rescheduledTo;
    reminder.takenAt = null;
    reminder.skippedAt = null;
    reminderService.saveReminder(reminder);
    if (update) updateListeners();
    /**
     Calls the Service Code.
     -> reminder.time -> rescheduledTo
     -> reminder.rescheduled -> true
     -> if Reminder is not Stored, Save.
     -> then calls updateListeners 
    */
  }

  Future<void> editDoseReminder(Reminder reminder, int dose,
      {int strength}) async {
    reminder.dose = dose;
    reminder.strength = strength.abs() ?? null;
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

  Future<void> takeAllReminders(List<Reminder> reminders) async {
    reminders.forEach((element) {
      if (element.takenAt == null)
        takeReminder(element, DateTime.now(), update: false);
    });
    updateListeners();
  }

  Future<void> skipAllReminders(List<Reminder> reminders) async {
    reminders.forEach((element) {
      if (element.skippedAt == null) skipReminder(element, update: false);
    });
    updateListeners();
  }

  Future<void> rescheduleAllReminders(
      List<Reminder> reminders, DateTime rescheduledTo) async {
    reminders.forEach((element) {
      if (element.takenAt == null)
        rescheduleReminder(element, rescheduledTo, update: false);
    });
    updateListeners();
  }
}

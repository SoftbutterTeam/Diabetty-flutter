import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';

class Therapy {
  String uid;
  String name;
  Schedule schedule;
  MedicationInfo medicationInfo;
}

class Schedule {
  List<Reminder> reminders;
  ScheduleSettings settings;
  Schedule({
    this.reminders,
    this.settings,
  });
}

class ReminderRule {
  Days days;
  double dose;
  String time;
  String window;
  ReminderRule({
    this.days,
    this.dose,
    this.time,
    this.window,
  });
}

class Days {
  bool monday, tuesday, wednesday, thursday, friday, saturday, sunday = false;
  Days({
    this.monday = false,
    this.tuesday = false,
    this.wednesday = false,
    this.thursday = false,
    this.friday = false,
    this.saturday = false,
    this.sunday = false,
  });
}

class ScheduleSettings {
  bool silent = false;
  ScheduleSettings({this.silent});
}

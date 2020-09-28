import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';

class Therapy {
  String uid;
  String name;
  Schedule schedule;
  MedicationInfo medicationInfo;
  int stock;
  String mode;
  Therapy({
    this.uid,
    this.name,
    this.schedule,
    this.medicationInfo,
    this.stock,
    this.mode,
  });
}

class Schedule {
  List<Reminder> reminders;
  AlarmSettings settings;
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

class AlarmSettings {
  bool silent = false;
  AlarmSettings({this.silent});
}

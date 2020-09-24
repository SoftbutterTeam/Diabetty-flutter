import 'package:diabetttty/models/MedicationInfo.dart';

class Theraphy {
  String uid;
  String name;
  Schedule schedule;
  MedicationInfo medicationInfo;
}

class Schedule {
  List<Reminders> reminders;
  ScheduleSettings settings;
  Schedule({
    this.reminders,
    this.settings,
  });
}

class Reminders {
  Days days;
  double dose;
  String time;
  String window;
  Reminders({
    this.days,
    this.dose,
    this.time,
    this.window,
  });
}

class Days {
  bool monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  Days(bool monday, bool tuesday, bool, wednesday, bool thursday, bool friday,
      bool saturday, bool sunday) {
    if (monday != null) this.monday = monday;
    if (tuesday != null) this.tuesday = tuesday;
    if (wednesday != null) this.wednesday = wednesday;
    if (thursday != null) this.thursday = thursday;
    if (friday != null) this.friday = friday;
    if (saturday != null) this.saturday = saturday;
    if (sunday != null) this.sunday = sunday;
  }
}

class ScheduleSettings {
  bool silent = false;
  ScheduleSettings({this.silent});
}

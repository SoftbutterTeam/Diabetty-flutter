import 'package:cloud_firestore/cloud_firestore.dart';

class Theraphy {
  String uid;
  String name;
  ...
}

class MedicationInfo {
  String name;
}

class Schedule {
  List<Reminders> reminders;
  ScheduleSettings settings;
}

class Reminders {
  Days days;
  double dose;
  String time;
  String window;
}

class Days {
  bool monday, tuesday, wednesday, thursday, friday, saturaday, sunday;
}

class ScheduleSettings {
  bool silent = false;
}

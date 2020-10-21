import 'package:diabetty/models/reminder.model.dart';

class TimeSlot {
  DateTime time;
  List<Reminder> reminders = new List();
  TimeSlot(this.time);

  bool get allComplete => !reminders.any((element) => element.takenAt == null);
}

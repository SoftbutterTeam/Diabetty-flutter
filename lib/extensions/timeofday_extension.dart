import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  String formatTimeOfDay() {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, this.hour, this.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  DateTime applyTimeOfDay() {
    final now = new DateTime.now();
    return DateTime(now.year, now.month, now.day, this.hour, this.minute);
  }
}

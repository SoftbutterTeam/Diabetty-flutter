import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isSameDayAs(DateTime date) {
    if (this.day != date.day) return false;
    if (this.month != date.month) return false;
    if (this.year != date.year) return false;
    return true;
  }

  DateTime applyTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  String formatTime() {
    return DateFormat.jm().format(this);
  }
}

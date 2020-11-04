import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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

  DateTime roundToNearest(int roundToMins) {
    var minute = this.minute;
    if (minute % roundToMins == 0) print('hello' + this.toIso8601String());

    if (minute % roundToMins == 0) return this;

    var minuteRoundUp = round(minute, roundToMins);
    if (this.minute == 39) {
      print(39);
      print(round(minute, roundToMins));
    }

    if (minuteRoundUp > 60)
      return new DateTime(this.year, this.month, this.day, this.hour)
          .add(Duration(hours: 1));
    else
      return new DateTime(
          this.year, this.month, this.day, this.hour, minuteRoundUp);
  }
}

int round(int numm, int roundTo) {
  int temp = numm % roundTo;
  if (temp < roundTo ~/ 2)
    return numm - temp;
  else
    return numm + roundTo - temp;
}

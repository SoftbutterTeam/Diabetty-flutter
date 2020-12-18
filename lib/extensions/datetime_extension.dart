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

  DateTime toSimpleDateTime() {
    if (this == null) return this;
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    String dtFormatted = df.format(this);
    return (df.parse(dtFormatted));
  }

  String formatTime2() {
    return DateFormat('h a').format(this).toLowerCase();
  }

  String formatTime() {
    return DateFormat.jm().format(this);
  }

  String slimDateTime(DateTime newTime) {
    String dayOfWeek;
    newTime ??= DateTime.now();
    if (this.isSameDayAs(newTime))
      dayOfWeek = "";
    else if (this.isSameDayAs(newTime.add(Duration(days: 1))))
      dayOfWeek = "Tomorrow, ";
    else if (this.isSameDayAs(newTime.subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday, ";
    else
      dayOfWeek = DateFormat("EEEE, d MMM").format(this);
    return dayOfWeek + this.formatTime();
  }

  DateTime roundToNearest(int roundToMins) {
    var minute = this.minute;

    if (minute % roundToMins == 0) return this;

    var minuteRoundUp = round(minute, roundToMins);

    if (minuteRoundUp > 60)
      return new DateTime(this.year, this.month, this.day, this.hour)
          .add(Duration(hours: 1));
    else
      return new DateTime(
          this.year, this.month, this.day, this.hour, minuteRoundUp);
  }

  String lessShortDateRepresent() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = "Today, ";
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = "Tomorrow, ";
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday, ";
    else
      dayOfWeek = DateFormat("EEEE, ").format(this);
    return dayOfWeek + DateFormat("d MMMM").format(this);
  }

  String shortenDateRepresent() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = "Today, ";
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = "Tomorrow, ";
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday, ";
    else
      dayOfWeek = DateFormat("EEEE, ").format(this);
    return dayOfWeek + DateFormat("d MMM").format(this);
  }

  String shortenDateRepresentShort() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = "Today, ";
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = "Tomorrow, ";
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday, ";
    else
      dayOfWeek = DateFormat("EE, ").format(this);

    return dayOfWeek + DateFormat("d MMM").format(this);
  }

  String shortenDayRepresent() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = "Today";
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = "Tomorrow";
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday";
    else
      dayOfWeek = DateFormat("EEEE").format(this);
    return dayOfWeek;
  }

  String justDayRepresent() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = DateFormat("EEEE").format(this);
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = DateFormat("EEEE").format(this);
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = DateFormat("EEEE").format(this);
    else
      dayOfWeek = DateFormat("EEEE").format(this);
    return dayOfWeek;
  }

  String monthYearRepresent() {
    String dayOfWeek;
    if (this.isSameDayAs(DateTime.now()))
      dayOfWeek = DateFormat("MMMM d").format(this);
    else if (this.isSameDayAs(DateTime.now().add(Duration(days: 1))))
      dayOfWeek = DateFormat("MMMM d").format(this);
    else if (this.isSameDayAs(DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = DateFormat("MMMM d").format(this);
    else
      dayOfWeek = DateFormat("MMMM d").format(this);
    return dayOfWeek;
  }
}

int round(int numm, int roundTo) {
  int temp = numm % roundTo;
  if (temp < roundTo ~/ 2)
    return numm - temp;
  else
    return numm + roundTo - temp;
}

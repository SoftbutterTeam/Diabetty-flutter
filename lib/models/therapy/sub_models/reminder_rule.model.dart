import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'package:diabetty/extensions/timeofday_extension.dart';

class ReminderRule {
  String id;
  Days days;
  int dose;
  TimeOfDay time;
  ReminderRule(
      {this.id, this.days, this.dose, this.time, forceGenerateUID = false}) {
    this.id = this.id ?? generateUID();
    if (forceGenerateUID) this.id = generateUID();
  }

  String generateUID() {
    return random.randomAlphaNumeric(6) +
        DateTime.now().microsecondsSinceEpoch.toString();
  }

  loadFromJson(Map<String, dynamic> json) {
    Map<String, dynamic> daysJson = new Map<String, dynamic>.from(json['days']);
    Days days = Days();
    days.loadFromJson(daysJson);
    this.days = days;
    this.id = json['id'];
    this.dose = json['dose'];
    this.time = TimeOfDay.now().stringToTimeOfDay(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'days': this.days.toJson(),
        'dose': this.dose,
        'time': this.time.formatTimeOfDay(),
      };

  dummyData() {
    var rng = new Random();
    Days days = Days();
    days.dummyData();
    this.days = days;

    this.dose = (rng.nextInt(100) * 5);
  }

  bool isActiveOn(DateTime date) {
    if (days.monday && date.weekday == 1) return true;
    if (days.tuesday && date.weekday == 2) return true;
    if (days.wednesday && date.weekday == 3) return true;
    if (days.thursday && date.weekday == 4) return true;
    if (days.friday && date.weekday == 5) return true;
    if (days.saturday && date.weekday == 6) return true;
    if (days.sunday && date.weekday == 7) return true;

    return false;
  }
}

class Days {
  bool monday, tuesday, wednesday, thursday, friday, saturday, sunday = false;
  Days({
    this.monday = true,
    this.tuesday = true,
    this.wednesday = true,
    this.thursday = true,
    this.friday = true,
    this.saturday = true,
    this.sunday = true,
  });
  Days.fromDays(Days days)
      : monday = days.monday,
        tuesday = days.tuesday,
        wednesday = days.wednesday,
        thursday = days.thursday,
        friday = days.friday,
        saturday = days.saturday,
        sunday = days.sunday;

  bool get isADaySelected => (monday ||
      tuesday ||
      wednesday ||
      thursday ||
      friday ||
      saturday ||
      sunday);

  loadFromJson(Map<String, dynamic> json) {
    this.monday = json['monday'];
    this.tuesday = json['tuesday'];
    this.wednesday = json['wednesday'];
    this.thursday = json['thursday'];
    this.friday = json['friday'];
    this.saturday = json['saturday'];
    this.sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() => {
        'monday': this.monday,
        'tuesday': this.tuesday,
        'wednesday': this.wednesday,
        'thursday': this.thursday,
        'friday': this.friday,
        'saturday': this.saturday,
        'sunday': this.sunday
      };

  dummyData() {
    this.monday = true;
    this.wednesday = true;
    this.friday = true;
  }
}

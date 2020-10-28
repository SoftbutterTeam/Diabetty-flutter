import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'dart:convert';
import 'reminder_rule.model.dart';
import 'alarmsettings.model.dart';
import 'schedule.model.dart';
import 'stock.model.dart';
// import 'package:json_serializable';

//btw Schedule.reminders should be called reminderRules for clarity
class Therapy {
  String userId;
  String id;
  String name;
  Schedule schedule;
  MedicationInfo medicationInfo;
  Stock stock;
  String mode;
  Therapy({
    this.userId,
    this.id,
    this.name,
    this.schedule,
    this.medicationInfo,
    this.stock,
    this.mode,
  });

  loadFromJson(Map<String, dynamic> json) {
    this.id ??= json['id'];
    this.userId ??= json['userId'];
    this.name = json['name'];
    this.mode = json['mode'];
    print(json.toString());
    Schedule schedule = Schedule();
    if (json['schedule'] != null) {
      Map<String, dynamic> sheduledata =
          new Map<String, dynamic>.from(json['schedule']);
      schedule.loadFromJson(sheduledata);
      this.schedule = schedule;
    }
    if (json['stock'] != null) {
      Map<String, dynamic> stockdata =
          new Map<String, dynamic>.from(json['stock']);
      Stock stock = new Stock();
      stock.loadFromJson(stockdata);
    }
    MedicationInfo medicationInfo = MedicationInfo();
    Map<String, dynamic> medicationinfodata =
        new Map<String, dynamic>.from(json['medicationInfo']);
    medicationInfo.loadFromJson(medicationinfodata);
    this.medicationInfo = medicationInfo;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'schedule': (this.schedule == null) ? null : this.schedule.toJson(),
        'medicationInfo': this.medicationInfo.toJson(),
        'stock': this.stock.toJson(),
        'mode': this.mode,
      };

  dummyData() {
    MedicationInfo medicationinfo = MedicationInfo();
    medicationinfo.dummyData();
    this.medicationInfo = medicationinfo;
    Schedule schedule = Schedule();
    schedule.dummyData();
    this.schedule = schedule;
    this.id = "YDpBWyABH3ZluJ9sDKTCTGXCqzz1";
    this.name = "cancer cure pls";
    this.schedule = schedule;
    this.medicationInfo = medicationInfo;
  }
}

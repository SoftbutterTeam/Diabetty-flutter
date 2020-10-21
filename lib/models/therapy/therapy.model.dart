import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'dart:convert';
import 'reminder_rule.model.dart';
import 'alarmsettings.model.dart';
import 'schedule.model.dart';
// import 'package:json_serializable';

//btw Schedule.reminders should be called reminderRules for clarity
class Therapy {
  String id;
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

  loadFromJson(jsonn) {
    this.id = jsonn['id'];
    this.name = jsonn['name'];

    Schedule schedule = Schedule();
    //error here

    Map<String, dynamic> sheduledata =
        new Map<String, dynamic>.from(jsonn['schedule']);
    schedule.loadFromJson(sheduledata);
    this.schedule = schedule;

    MedicationInfo medicationInfo = MedicationInfo();
    Map<String, dynamic> medicationinfodata =
        new Map<String, dynamic>.from(jsonn['medicationInfo']);
    medicationInfo.loadFromJson(medicationinfodata);
    this.medicationInfo = medicationInfo;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'schedule': this.schedule.toJson(),
        'medicationInfo': this.medicationInfo.toJson(),
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

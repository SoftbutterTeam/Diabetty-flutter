import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/sub_models/medication_info.model.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'dart:convert';
import 'sub_models/reminder_rule.model.dart';
import 'sub_models/alarmsettings.model.dart';
import 'sub_models/schedule.model.dart';
import 'sub_models/stock.model.dart';
import 'package:diabetty/extensions/timeofday_extension.dart';
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

  bool get isPlanned => mode.toLowerCase() == "planned";
  bool get isNeeded => !isPlanned;

  loadFromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) this.id ??= json['id'];

    if (json.containsKey('userId')) this.userId ??= json['userId'];
    this.name = json['name'];
    this.mode = json['mode'];
    //print(json.toString());
    Schedule schedule = Schedule();
    if (json['schedule'] != null) {
      Map<String, dynamic> sheduledata =
          new Map<String, dynamic>.from(json['schedule']);
      schedule.loadFromJson(sheduledata);
      this.schedule = schedule;
    }
    Stock stock = new Stock();

    if (json['stock'] != null) {
      Map<String, dynamic> stockdata =
          new Map<String, dynamic>.from(json['stock']);
      stock.loadFromJson(stockdata);
      this.stock = stock;
    }
    MedicationInfo medicationInfo = MedicationInfo();
    Map<String, dynamic> medicationinfodata =
        new Map<String, dynamic>.from(json['medicationInfo']);
    medicationInfo.loadFromJson(medicationinfodata);
    this.medicationInfo = medicationInfo;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': userId,
        'name': this.name,
        'schedule': (this.schedule == null) ? null : this.schedule.toJson(),
        'medicationInfo': this.medicationInfo.toJson(),
        'stock': this.stock.toJson(),
        'mode': this.mode,
      };
}

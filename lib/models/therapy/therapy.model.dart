import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:diabetty/models/therapy/schedule.model.dart';
import 'package:diabetty/models/therapy/stock.model.dart';

class Therapy {
  String id;
  String uid;
  String name;
  Schedule schedule;
  MedicationInfo medicationInfo;
  Stock stock;
  String mode;
  Therapy({
    this.uid,
    this.name,
    this.schedule,
    this.medicationInfo,
    this.stock,
    this.mode,
  });

  loadFromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];

    Schedule schedule = Schedule();
    schedule.loadFromJson(json['schedule']);
    this.schedule = schedule;

    MedicationInfo medicationInfo = MedicationInfo();
    medicationInfo.loadFromJson(json['medicationInfo']);
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

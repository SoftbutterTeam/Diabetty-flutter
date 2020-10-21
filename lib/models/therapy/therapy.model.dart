import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'dart:convert';
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
    var shed = jsonn['medicationInfo'];
    // print(jsonn['schedule']['reminders']);
    // print(json.decode(jsonn));
    Map<String, dynamic> mmm = new Map<String, dynamic>.from(jsonn['schedule']);
    //type '_InternalLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'
    schedule.loadFromJson(mmm);
    this.schedule = schedule;

    MedicationInfo medicationInfo = MedicationInfo();
    Map<String, dynamic> nnn =
        new Map<String, dynamic>.from(jsonn['medicationInfo']);
    medicationInfo.loadFromJson(nnn);
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

class Schedule {
  List<ReminderRule> reminderRules;

  Schedule({
    this.reminderRules,
  });

  loadFromJson(Map<String, dynamic> json) {
    List<dynamic> remindersJson = json['reminderRules'];
    List<ReminderRule> reminderRules = createReminders(remindersJson);
    AlarmSettings setting = AlarmSettings();
    this.reminderRules = reminderRules;
  }

  Map<String, dynamic> toJson() => {
        'reminderRules': mapJson(this.reminderRules),
      };

  mapJson(list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    jsonList.toList();
    return jsonList;
  }

  createReminders(List<dynamic> json) {
    List<ReminderRule> returnReminders = List();
    for (var reminder = 0; reminder < json.length; reminder++) {
      Map<String, dynamic> reminderJson =
          new Map<String, dynamic>.from(json.elementAt(reminder));
      ReminderRule currReminder = ReminderRule();
      currReminder.loadFromJson(reminderJson);
      returnReminders.add(currReminder);
    }
    return returnReminders;
  }

  dummyData() {
    List<ReminderRule> listoreminders = List();
    for (var i = 0; i < 3; i++) {
      ReminderRule reminderRules = ReminderRule();
      reminderRules.dummyData();
      listoreminders.add(reminderRules);
    }
    AlarmSettings settings = AlarmSettings();
    //settings.setSettings(true);

    // this.settings = settings;
    this.reminderRules = listoreminders;
  }
}

class ReminderRule {
  String uid;
  Days days;
  double dose;
  String time;
  String window;
  ReminderRule(
      {this.uid,
      this.days,
      this.dose,
      this.time,
      this.window,
      forceGenerateUID = false}) {
    //this.uid = this.uid ?? generateUID();
    if (this.uid == null) this.uid = generateUID();
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
    this.dose = json['dose'];
    this.time = json['time'];
    this.window = json['window'];
  }

  Map<String, dynamic> toJson() => {
        'days': this.days.toJson(),
        'dose': this.dose,
        'time': this.time,
        'window': this.window,
      };

  dummyData() {
    var rng = new Random();
    Days days = Days();
    days.dummyData();
    this.days = days;

    this.dose = (rng.nextDouble() * 5);
    this.time = (rng.nextInt(1000000).toString());
    this.window = (rng.nextInt(1000000).toString());
  }
}

class Days {
  bool monday, tuesday, wednesday, thursday, friday, saturday, sunday = false;
  Days({
    this.monday = false,
    this.tuesday = false,
    this.wednesday = false,
    this.thursday = false,
    this.friday = false,
    this.saturday = false,
    this.sunday = false,
  });

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

class AlarmSettings {
  bool silent = false;
  AlarmSettings({this.silent});
}

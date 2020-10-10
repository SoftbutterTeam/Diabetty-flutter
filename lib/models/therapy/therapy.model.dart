import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;

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

class Schedule {
  List<ReminderRule> reminders;

  Schedule({
    this.reminders,
  });

  loadFromJson(Map<String, dynamic> json) {
    List<dynamic> remindersJson = json['reminders'];
    List<ReminderRule> reminders = createReminders(remindersJson);
    AlarmSettings setting = AlarmSettings();
    this.reminders = reminders;
  }

  Map<String, dynamic> toJson() => {
        'reminders': mapJson(this.reminders),
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
      var reminderJson = json.elementAt(reminder);
      ReminderRule currReminder = ReminderRule();
      currReminder.loadFromJson(reminderJson);
      returnReminders.add(currReminder);
    }
    return returnReminders;
  }

  dummyData() {
    List<ReminderRule> listoreminders = List();
    for (var i = 0; i < 3; i++) {
      ReminderRule reminders = ReminderRule();
      reminders.dummyData();
      listoreminders.add(reminders);
    }
    AlarmSettings settings = AlarmSettings();
    //settings.setSettings(true);

    // this.settings = settings;
    this.reminders = listoreminders;
  }
}

class ReminderRule {
  String uid;
  Days days;
  int dose;
  DateTime time;
  Duration window;
  ReminderRule(
      {this.uid,
      this.days,
      this.dose,
      this.time,
      this.window,
      forceGenerateUID = false}) {
    this.uid = this.uid ?? _generateUID();
    if (forceGenerateUID) this.uid = _generateUID();
  }

  String _generateUID() {
    return random.randomAlphaNumeric(6) +
        DateTime.now().microsecondsSinceEpoch.toString();
  }

  loadFromJson(Map<String, dynamic> json) {
    var daysJson = json['days'];
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

    this.dose = (rng.nextInt(5) * 5);
    this.time = (DateTime.now());
    this.window = (rng.nextInt(1000000).toString());
  }

  bool activeOn(DateTime date) {
    if(date.weekday){
      
    }
    if (days.monday && date
  }
}

class Days {
  //* this should probably be an array
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

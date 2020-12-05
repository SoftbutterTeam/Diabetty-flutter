import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:intl/intl.dart';

class Reminder with DateMixin {
  String id;
  String userId;
  int appearance;
  String therapyId;
  String reminderRuleId;
  String name;
  DateTime time;
  int dose;
  int doseTypeIndex;
  int strength;
  int strengthUnitindex;
  Duration window;
  DateTime takenAt;
  DateTime rescheduledTime;
  double editedDose;
  bool doseEdited;
  DateTime skippedAt;
  DateTime deletedAt;

  List<int> advices;

  DateTime get getDateTimeAs12hr {
    if (time == null) return time;
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    String dtFormatted = df.format(time);
    return (df.parse(dtFormatted));
  }

  DateTime get date {
    if (time == null) return null;
    final df = new DateFormat('dd-MM-yyyy');
    String dtFormatted = df.format(time);
    return (df.parse(dtFormatted));
  }

  bool isToday({DateTime date}) {
    date ??= DateTime.now();
    return isSameDay(rescheduledTime ?? time, date);
  }

  // late is like isActive but for rescheduledTime.
  //? im going to remove is late, dont really think it makes sense, in a computational manor.
  bool get isComplete => takenAt != null;
  bool get isSnoozed =>
      !isComplete &&
      rescheduledTime != null &&
      !isLate &&
      DateTime.now().isBefore(rescheduledTime);
  bool get isMissed =>
      takenAt == null &&
      skippedAt == null &&
      DateTime.now().isAfter(
          (rescheduledTime ?? time).add(this.window ?? Duration(minutes: 5)));
  bool get isActive =>
      takenAt == null &&
      !isLate &&
      DateTime.now().compareTo(time) >= 0 &&
      !isSkipped &&
      !isMissed;
  bool get isSkipped => skippedAt != null;
  bool get isLate =>
      !isComplete &&
      !isSkipped &&
      rescheduledTime != null &&
      DateTime.now().compareTo(
              rescheduledTime.add(this.window ?? Duration(minutes: 5))) <=
          0 &&
      DateTime.now().compareTo(rescheduledTime) >= 0;
  bool get isIdle =>
      !isComplete &&
      !isSkipped &&
      rescheduledTime == null &&
      DateTime.now().compareTo(time) < 0;

  bool get isDeleted => deletedAt != null;

  ReminderStatus get status {
    if (isComplete) return ReminderStatus.completed;
    if (isSnoozed) return ReminderStatus.snoozed;
    if (isMissed) return ReminderStatus.missed;
    if (isActive) return ReminderStatus.active;
    if (isSkipped) return ReminderStatus.skipped;
    if (isLate) return ReminderStatus.isLate;
    if (isIdle) return ReminderStatus.idle;
    return null;
  }

  Reminder(
      {this.id,
      this.therapyId,
      this.reminderRuleId,
      this.name,
      this.appearance,
      this.time,
      this.dose,
      this.advices,
      this.skippedAt,
      this.window,
      this.editedDose,
      this.rescheduledTime,
      this.takenAt,
      this.doseEdited});

  ///*  Used to Project Reminders from the Therapys
  ///*  Note: There no uid assignment. so if no uid it must be a non-stored/saved reminder object
  Reminder.generated(Therapy therapy, ReminderRule rule, DateTime date)
      : this.therapyId = therapy.id,
        this.userId = therapy.userId,
        this.reminderRuleId = rule.id,
        this.name = therapy.medicationInfo.name,
        this.appearance = therapy.medicationInfo.appearanceIndex,
        this.time = DateTime(
            date.year, date.month, date.day, rule.time.hour, rule.time.minute),
        this.dose = rule.dose,
        this.window = therapy.schedule.window ?? Duration(minutes: 5),
        this.doseTypeIndex = therapy.medicationInfo.typeIndex,
        this.strength = therapy.medicationInfo.strength,
        this.strengthUnitindex = therapy.medicationInfo.unitIndex,
        this.advices = therapy.medicationInfo.intakeAdvices;

  Reminder.formJson(Map<String, dynamic> json) {
    loadFromJson(json);
  }

  loadFromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) this.id = json['id'];
    if (json.containsKey('userId')) this.userId = json['userId'];
    if (json.containsKey('therapyId')) this.therapyId = json['therapyId'];
    if (json.containsKey('reminderRuleId'))
      this.reminderRuleId = json['reminderRuleId'];
    if (json.containsKey('name')) this.name = json['name'];
    if (json.containsKey('appearance')) this.appearance = json['appearance'];
    if (json.containsKey('time')) this.time = DateTime.parse(json['time']);
    if (json.containsKey('dose')) this.dose = json['dose'];
    if (json.containsKey('doseTypeIndex'))
      this.doseTypeIndex = json['doseTypeIndex'];
    if (json.containsKey('strength')) this.strength = json['strength'];
    if (json.containsKey('strengthUnitIndex'))
      this.strengthUnitindex = json['strengthUnitIndex'];
    if (json.containsKey('advices'))
      this.advices = new List<int>.from(json['advices']);
    if (json.containsKey('window'))
      this.window = Duration(seconds: json['window']);

    if (json.containsKey('rescheduledTime'))
      this.rescheduledTime = DateTime.parse(json['rescheduledTime']);
    if (json.containsKey('takenAt'))
      this.takenAt = DateTime.parse(json['takenAt']);
    if (json.containsKey('skippedAt'))
      this.skippedAt = DateTime.parse(json['skippedAt']);
    if (json.containsKey('deletedAt'))
      this.deletedAt = DateTime.parse(json['deletedAt']);
    if (json.containsKey('doseEdited')) this.doseEdited = json['doseEdited'];
  }

  //TODO
  Map<String, dynamic> tojson() {
    Map<String, dynamic> output = {};
    if (this.id != null) output['id'] = this.id;
    if (this.userId != null) output['userId'] = this.userId;
    if (this.therapyId != null) output['therapyId'] = this.therapyId;
    if (this.reminderRuleId != null)
      output['reminderRuleId'] = this.reminderRuleId;
    if (this.appearance != null) output['appearance'] = this.appearance;

    if (this.name != null) output['name'] = this.name;
    if (this.time != null) output['time'] = this.time.toString();
    if (this.dose != null) output['dose'] = this.dose;
    if (this.doseTypeIndex != null)
      output['doseTypeIndex'] = this.doseTypeIndex;
    if (this.strength != null) output['strength'] = this.strength;
    if (this.strengthUnitindex != null)
      output['strengthUnitIndex'] = this.strengthUnitindex;
    if (this.window != null) output['window'] = this.window.inSeconds;
    if (this.takenAt != null) output['takenAt'] = this.takenAt.toString();
    if (this.rescheduledTime != null)
      output['rescheduledTime'] = this.rescheduledTime.toString();
    if (this.editedDose != null) output['editedDose'] = this.editedDose;
    if (this.skippedAt != null) output['skippedAt'] = this.skippedAt.toString();
    if (this.deletedAt != null) output['deletedAt'] = this.deletedAt.toString();

    if (this.advices != null) output['advices'] = this.advices;
    if (this.doseEdited != null) output['doseEdited'] = this.doseEdited;
    return output;
  }
}

enum ReminderStatus {
  completed,
  missed,
  active,
  skipped,
  isLate,
  snoozed,
  idle
}

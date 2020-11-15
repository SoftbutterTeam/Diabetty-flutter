import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/models/therapy/sub_models/medication_info.model.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:intl/intl.dart';

class Reminder with DateMixin {
  String id;
  int apperance;
  String therapyId;
  String reminderRuleId;
  String name;
  DateTime time;
  int dose;
  int doseUnitIndex;
  Duration window;
  DateTime takenAt;
  DateTime rescheduledTime;
  double editedDose;
  bool cancelled;
  List<String> advice;
  int adviceIndex;

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
    date = date ?? DateTime.now();
    return isSameDay(this.date, date);
  }

  bool get isComplete => takenAt != null;
  bool get isSnoozed => rescheduled != null && !rescheduled;
  bool get isMissed =>
      takenAt == null &&
      DateTime.now().compareTo(time.add(schedule.window)) > 0;

  bool get isActive => takenAt != null && DateTime.now().compareTo(time) > 0;

  Reminder(
      {this.id,
      this.therapyId,
      this.reminderRuleId,
      this.name,
      this.apperance,
      this.time,
      this.dose,
      this.advice,
      this.cancelled,
      this.window,
      this.editedDose,
      this.rescheduledTime,
      this.takenAt,
      this.adviceIndex});

  ///*  Used to Project Reminders from the Therapys
  ///*  Note: There no uid assignment. so if no uid it must be a non-stored/saved reminder object
  Reminder.generated(Therapy therapy, ReminderRule rule, DateTime date)
      : this.therapyId = therapy.id,
        this.reminderRuleId = rule.id,
        this.name = therapy.medicationInfo.name,
        this.apperance = therapy.medicationInfo.appearanceIndex,
        this.time = DateTime(
            date.year, date.month, date.day, rule.time.hour, rule.time.minute),
        this.dose = rule.dose,
        this.window = therapy.schedule.window,
        this.doseUnitIndex = therapy.medicationInfo.unitIndex,
        this.advice = therapy.medicationInfo.intakeAdvice,
        this.adviceIndex = therapy.medicationInfo.intakeIndex;

  Reminder.formJson(Map<String, dynamic> json) {
    loadFromJson(json);
  }

  Reminder.fromJson(Map<String, dynamic> json) :
    this.id = json['id'],
    this.therapyId = json['therapyId'],
    this.reminderRuleId = json['reminderRuleId'],
    this.name = json['name'],
    this.apperance = json['apperance'],
    this.time = json['time'],
    this.dose = json['dose'],
    this.doseUnitIndex = json['doseUnitIndex'],
    this.advice = json['advice'],
    this.window = json['window'],
    this.takenAt = json['takenAt'],
    this.
    this.reportUnitsIndex = json['reportUnitsIndex'];
    this.journalEntries = journalEntriesFromJson(json['journalEntries']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'name': this.name,
        'reportUnitsIndex': this.reportUnitsIndex,
        'journalEntries': mapJson(this.journalEntries),
      };
}

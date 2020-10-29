import 'package:diabetty/mixins/date_mixin.dart';
import 'package:diabetty/models/therapy/sub_models/medication_info.model.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:intl/intl.dart';

class Reminder with DateMixin {
  String uid;
  int apperance;
  String therapyId; //*therapy could have been deleted
  String reminderRuleId;
  String name;
  DateTime time; //*scheduled time
  int dose;
  int doseUnitIndex;
  Duration window;
  DateTime takenAt;
  bool rescheduled;
  bool cancelled;
  bool doseEdited;
  List<String> advice;

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

  Reminder(
      {this.uid,
      this.therapyId,
      this.reminderRuleId,
      this.name,
      this.apperance,
      this.time,
      this.dose,
      this.advice,
      this.cancelled,
      this.window,
      this.doseEdited,
      this.rescheduled,
      this.takenAt});

  ///*  Used to Project Reminders from the Therapys
  ///*  Note: There no uid assignment. so if no uid it must be a non-stored/saved reminder object
  Reminder.generated(Therapy therapy, ReminderRule rule, DateTime date) {
    this.therapyId = therapy.id;
    this.reminderRuleId = rule.id;
    this.name = therapy.medicationInfo.name;
    this.apperance = therapy.medicationInfo.appearanceIndex;
    this.time = DateTime(
        date.year, date.month, date.day, rule.time.hour, rule.time.minute);
    this.dose = rule.dose;
    this.window = therapy.schedule.window;
    this.doseUnitIndex = therapy.medicationInfo.unitIndex;
    this.advice = therapy.medicationInfo.intakeAdvice;
  }
}

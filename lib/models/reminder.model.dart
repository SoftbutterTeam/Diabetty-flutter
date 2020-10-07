import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:intl/intl.dart';

class Reminder {
  String uid;
  String therapyId; //*therapy could have been deleted
  String reminderRuleId;
  String name;
  DateTime time; //*scheduled time
  int dose;
  DateTime takenAt;
  bool rescheduled;
  bool cancelled;
  bool doseEdited;
  List<String> advice;

  set setTime(DateTime dateTime) {
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    String dtFormatted = df.format(dateTime);
    this.time = df.parse(dtFormatted);
  }

  get getTime {
    if (time == null) return time;
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    String dtFormatted = df.format(time);
    return (df.parse(dtFormatted));
  }

  bool get isComplete => takenAt != null;

  Reminder(
      {this.uid,
      this.therapyId,
      this.reminderRuleId,
      this.name,
      this.time,
      this.dose,
      this.advice,
      this.cancelled,
      this.doseEdited,
      this.rescheduled,
      this.takenAt});
}

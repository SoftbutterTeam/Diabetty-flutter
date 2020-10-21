import 'package:diabetty/models/therapy/alarmsettings.model.dart';
import 'package:diabetty/models/therapy/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';

class Schedule {
  List<ReminderRule> reminders;
  Duration window;
  DateTime startDate;
  DateTime endDate;
  AlarmSettings alarmSettings;

  Schedule({
    this.reminders,
    this.window,
    this.startDate,
    this.endDate,
    this.alarmSettings,
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

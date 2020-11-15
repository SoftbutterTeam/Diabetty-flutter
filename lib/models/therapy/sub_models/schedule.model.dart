import 'package:diabetty/models/therapy/sub_models/alarmsettings.model.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';

class Schedule {
  List<ReminderRule> reminderRules;
  Duration window;
  DateTime startDate;
  DateTime endDate;
  AlarmSettings alarmSettings;

//!! TODO IT ISNT COMPLETE
  Schedule({
    this.reminderRules,
    this.window,
    this.startDate,
    this.endDate,
    this.alarmSettings,
  });

  loadFromJson(Map<String, dynamic> json) {
    List<dynamic> remindersJson = json['reminderRules'];
    List<ReminderRule> reminders = createReminders(remindersJson);
    AlarmSettings setting = AlarmSettings();
    this.reminderRules = reminders;
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
    if (json == null || json.length == 0) return;
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
      ReminderRule reminders = ReminderRule();
      reminders.dummyData();
      listoreminders.add(reminders);
    }
    AlarmSettings settings = AlarmSettings();
    //settings.setSettings(true);

    // this.settings = settings;
    this.reminderRules = listoreminders;
  }
}

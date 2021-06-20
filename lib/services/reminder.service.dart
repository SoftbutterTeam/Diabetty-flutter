import 'package:diabetty/repositories/local_repositories/reminder.local.repository.dart';
import 'package:diabetty/models/reminder.model.dart';

class ReminderService {
  ReminderRepository reminderRepo = ReminderRepository();

  Future<void> saveReminder(Reminder reminder) async {
    try {
      reminderRepo.setReminder(reminder);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    try {
      reminderRepo.deleteReminder(reminder);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Reminder>> getReminders(String uid, {bool local: false}) async {
    try {
      final reminders =
          (await reminderRepo.getAllReminders(uid, local: local)).data;
      if (reminders == null) {
        //print('init null');
        return List();
      }
      //print('init here');
      return reminders.map<Reminder>((json) {
        //print('init map');
        Reminder reminder = Reminder();
        reminder.id = json['id'];
        print(reminder.id);
        return reminder..loadFromJson(json);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream localStream() {
    return reminderRepo.onStateChanged('uid');
  }
}

import 'package:diabetty/repositories/reminder.repository.dart';
import 'package:diabetty/models/reminder.model.dart';

class ReminderService {
  ReminderRepository reminderRepository = ReminderRepository();

  Future<void> updateReminder(Reminder reminder) async {
    try {
      reminderRepository.updateReminder(reminder);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveReminder(Reminder reminder) async {
    try {
      reminderRepository.setReminder(reminder);
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:async';
import 'package:diabetty/models/reminder.model.dart';
import 'package:localstore/localstore.dart';

class ReminderRepository {
  final _localdb = Localstore.instance;

  Future<DataResult<List<Map<String, dynamic>>>> getAllReminders(
      {bool local}) async {
    try {
      var result = await _localdb.collection('reminders').get();

      var data = (result.entries.map((e) {
        var json = Map<String, dynamic>.from(e.value)
          ..['id'] = e.key.split('/').last;
        return json;
      }).toList());
      //// print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      //// print('HELLLO');
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    if (reminder.userId == null) return null;

    // reminder.
    await _localdb
        .collection('reminders')
        .doc(reminder.id)
        .delete()
        .catchError((e) {
      // print('error');
      // print(e);
    });
    return true;
  }

  Future<void> setReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    //   if (reminder.userId == null) return null;
    print('listened set Data');
    reminderData = reminder.tojson();
    reminderData['updatedAt'] = DateTime.now().toString();

    // reminder.
    await _localdb
        .collection('reminders')
        .doc(reminder.id)
        .set(reminderData)
        .catchError((e) {
      // print('error');
      // print(e);
    });
    //  await getAllReminders();
    return true;
  }

  Stream<Map<String, dynamic>> onStateChanged() {
    return _localdb.collection('reminders').stream.distinct();
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

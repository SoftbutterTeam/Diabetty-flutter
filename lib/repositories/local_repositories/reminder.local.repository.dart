import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:localstore/localstore.dart';

class ReminderRepository {
  final _localdb = Localstore.instance;

  Future<DataResult<List<Map<String, dynamic>>>> getAllReminders(
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.serverAndCache;

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
    if (reminder.userId == null) return null;

    reminderData = reminder.tojson();

    // reminder.
    await _localdb
        .collection('reminders')
        .doc(reminder.id)
        .set(reminderData)
        .catchError((e) {
      // print('error');
      // print(e);
    });
    return true;
  }

  Stream<Map<String, dynamic>> onStateChanged() {
    return _localdb.collection('reminders').stream;
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

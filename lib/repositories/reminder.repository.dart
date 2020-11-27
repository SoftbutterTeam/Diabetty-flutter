import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;

  Future<void> updateReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    reminderData = reminder.tojson();
    // reminder.
    await _db
        .collection('users')
        .document(reminder.userId)
        .collection('reminders')
        .document(reminder.id)
        .updateData(reminderData)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  Future<void> setReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    reminderData = reminder.tojson();
    // reminder.
    await _db
        .collection('users')
        .document(reminder.userId)
        .collection('reminders')
        .document(reminder.id)
        .setData(reminderData)
        .catchError((e) {
      print(e);
    });
    return true;
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/repositories/team.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;

  Future<DataResult<List<Map<String, dynamic>>>> getAllReminders(String userId,
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.serverAndCache;

      var result = await _db
          .collection("users")
          .document(userId)
          .collection('reminders')
          .getDocuments(source: source);

      var data = (result.documents.map((e) {
        var json = Map<String, dynamic>.from(e.data)..['id'] = e.documentID;
        return json;
      }).toList());
      //print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      //print('HELLLO');
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    if (reminder.userId == null) return null;

    // reminder.
    await _db
        .collection('users')
        .document(reminder.userId)
        .collection('reminders')
        .document(reminder.id)
        .delete()
        .catchError((e) {
      print('error');
      print(e);
    });
    return true;
  }

  Future<void> setReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    if (reminder.userId == null) return null;

    reminderData = reminder.tojson();

    // reminder.
    await _db
        .collection('users')
        .document(reminder.userId)
        .collection('reminders')
        .document(reminder.id)
        .setData(reminderData)
        .catchError((e) {
      print('error');
      print(e);
    });
    return true;
  }

  Stream<QuerySnapshot> onStateChanged(String uid) {
    //print('hererehere' + uid);

    return _db
        .collection('users')
        .document(uid)
        .collection('reminders')
        .snapshots();
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

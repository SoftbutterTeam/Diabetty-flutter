import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderRepository {
  ReminderRepository() {
    //AuthService authService;
    //authService.currentUser();
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;

  Future<void> updateReminder(Reminder reminder) async {
    Map<String, dynamic> reminderData = Map();
    //therapyData = reminder.toJson();

    await _db
        .collection('users')
        .document(reminder.therapyId)
        .collection('therapies')
        .document(reminder.uid)
        .updateData(reminderData)
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

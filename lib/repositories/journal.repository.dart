import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JournalRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;
  //!TODO increase db.settings cache at the end
  Future<void> createJournal(Journal journal) async {
    if (journal.userId == null)
      journal.userId = (await _firebaseAuth.currentUser()).uid;
    Map<String, dynamic> journalData = journal.toJson();
    var timeNow = DateTime.now().toString();
    journalData['createdAt'] ??= timeNow;
    journalData['lastUpdated'] = timeNow;

    await _db
        .collection('users')
        .document(journal.userId)
        .collection('journals')
        .document()
        .setData(journalData)
        .catchError((e) {
      print(e);
    });
    return;
  }

  Future<void> updateJournal(Journal journal) async {
    if (journal.userId == null)
      journal.userId = (await _firebaseAuth.currentUser()).uid;
    Map<String, dynamic> journalData = journal.toJson();
    var timeNow = DateTime.now().toString();
    journalData['lastUpdated'] = timeNow;

    await _db
        .collection('users')
        .document(journal.userId)
        .collection('journals')
        .document()
        .updateData(journalData)
        .catchError((e) {
      print(e);
    });
    return;
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllJournals(String userId,
      {bool local = false}) async {
    Source source = local ? Source.cache : Source.server;
    try {
      var result = await _db
          .collection("users")
          .document(userId)
          .collection('journals')
          .getDocuments(source: source);
      var data = (result.documents.map((e) {
        var json = Map<String, dynamic>.from(e.data)..['id'] = e.documentID;
        return json;
      }).toList());
      print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Stream<QuerySnapshot> onStateChanged(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .collection('journals')
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

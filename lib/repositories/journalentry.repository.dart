import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JournalEntryRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;

  Future<void> updateEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = Map();
    entryData = entry.toJson();
    // entry.
    await _db
        .collection('users')
        .document(entry.userId)
        .collection('journals')
        .document(entry.journalId)
        .collection('journalEntries')
        .document(entry.id)
        .updateData(entryData)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllEntrys(
      String userId, String journalId,
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.server;

      var result = await _db
          .collection("users")
          .document(userId)
          .collection('journals')
          .document(journalId)
          .collection('journalEntries')
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

  Future<DataResult<List<Map<String, dynamic>>>> getLatestEntrys(
      String userId, String journalId,
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.server;

      var result = await _db
          .collection("users")
          .document(userId)
          .collection('journals')
          .document(journalId)
          .collection('journalEntries')
//          .orderBy('date', descending: true)
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

  Future<void> deleteEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = Map();
    if (entry.userId == null) return null;

    // entry.
    await _db
        .collection('users')
        .document(entry.userId)
        .collection('journals')
        .document(entry.journalId)
        .collection('journalEntries')
        .document(entry.id)
        .delete()
        .catchError((e) {
      print('error');
      print(e);
    });
    return true;
  }

  Future<void> setEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = Map();
    if (entry.userId == null) return null;
    entryData = entry.toJson();
    await _db
        .collection('users')
        .document(entry.userId)
        .collection('journals')
        .document(entry.journalId)
        .collection('journalEntries')
        .document(entry.id)
        .setData(entryData)
        .catchError((e) {
      print('error');
      print(e);
    });
    return true;
  }

  Stream<QuerySnapshot> onStateChanged(String uid, String journalId) {
    return _db
        .collection('users')
        .document(uid)
        .collection('journals')
        .document(journalId)
        .collection('journalEntries')
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

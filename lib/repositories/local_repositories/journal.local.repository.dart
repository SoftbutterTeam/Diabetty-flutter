import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstore/localstore.dart';

class JournalRepository {
  final _localdb = Localstore.instance;

  //!TODO increase db.settings cache at the end
  Future<void> createJournal(Journal journal) async {
    Map<String, dynamic> journalData = journal.toJson();
    var timeNow = DateTime.now().toString();
    journalData['createdAt'] ??= timeNow;
    journalData['updatedAt'] = timeNow;

    await _localdb
        .collection('journals')
        .doc()
        .set(journalData)
        .then((value) => print(value + 'toto'))
        .catchError((e) {
      //print(e);
    });
    return;
  }

  Future<void> deleteJournal(Journal journal) async {
    await _localdb
        .collection('journals')
        .doc(journal.id)
        .delete()
        .catchError((e) {
      //print(e);
    });

    return;
  }

  Future<void> updateJournal(Journal journal) async {
    Map<String, dynamic> journalData = journal.toJson();
    var timeNow = DateTime.now().toString();
    journalData['updatedAt'] = timeNow;

    await _localdb
        .collection('journals')
        .doc()
        .set(journalData)
        .catchError((e) {
      print(e);
    });
    return;
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllJournals(String userId,
      {bool local = false}) async {
    Source source = local ? Source.cache : Source.serverAndCache;
    try {
      var result = await _localdb.collection('journals').get();

      print("--here");
      print(result);
      var data = (result.entries.map((e) {
        var json = Map<String, dynamic>.from(e.value)..['id'] = e.key;
        return json;
      }).toList());
      //print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      print("--here eror");

      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Stream<Map<String, dynamic>> onStateChanged(String uid) {
    return _localdb.collection('journals').stream;
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

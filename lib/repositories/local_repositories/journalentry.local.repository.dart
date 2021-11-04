import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstore/localstore.dart';

class JournalEntryRepository {
  final _localdb = Localstore.instance;

  Future<void> updateEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = entry.toJson();
    entryData['updatedAt'] = DateTime.now();
    Map<String, dynamic> json =
        await _localdb.collection('journals').doc(entry.journalId).get();
    json['updatedAt'] = DateTime.now().toString();
    await _localdb.collection('journals').doc(entry.journalId).set(json);
    await _localdb
        .collection('journals')
        .doc(entry.journalId)
        .collection('journalEntries')
        .doc(entry.id)
        .set(entryData)
        .catchError((e) {
      // print(e);
    });
    return true;
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllEntrys(String journalId,
      {bool local}) async {
    try {
      Map<String, dynamic> result = await _localdb
              .collection('journals')
              .doc(journalId)
              .collection('journalEntries')
              .get() ??
          new Map();
      // print('step1');

      var data = (result.entries.map((e) {
        var json = Map<String, dynamic>.from(e.value)
          ..['id'] = e.key.split('/').last;
        return json;
      }).toList());
      // print('step2');

      //// print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      // print('HELLLO2');

      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<DataResult<List<Map<String, dynamic>>>> getLatestEntrys(
      String journalId,
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.serverAndCache;

      var result = await _localdb
          .collection('journals')
          .doc(journalId)
          .collection('journalEntries')
//          .orderBy('date', descending: true)
          .get();

      var data = (result.entries.map((e) {
        var json = Map<String, dynamic>.from(e.value)
          ..['id'] = e.key.split('/').last;
        return json;
      }).toList());
      //// print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      // print('HELLLO');
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<void> deleteEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = Map();
    if (entry.userId == null) return null;
    Map<String, dynamic> json =
        await _localdb.collection('journals').doc(entry.journalId).get();
    json['updatedAt'] = DateTime.now().toString();
    await _localdb.collection('journals').doc(entry.journalId).set(json);
    await _localdb
        .collection('journals')
        .doc(entry.journalId)
        .collection('journalEntries')
        .doc(entry.id)
        .delete()
        .catchError((e) {
      // print('error');
      // print(e);
    });
    return true;
  }

  Future<void> setEntry(JournalEntry entry) async {
    Map<String, dynamic> entryData = Map();
    entryData = entry.toJson();
    entryData['updatedAt'] = DateTime.now().toString();
    Map<String, dynamic> json =
        await _localdb.collection('journals').doc(entry.journalId).get();
    json['updatedAt'] = DateTime.now().toString();
    await _localdb.collection('journals').doc(entry.journalId).set(json);
    await _localdb
        .collection('journals')
        .doc(entry.journalId)
        .collection('journalEntries')
        .doc(entry.id)
        .set(entryData)
        .catchError((e) {
      // print('error');
      // print(e);
    });
    return true;
  }

  Stream<Map<String, dynamic>> onStateChanged(String journalId) {
    return _localdb
        .collection('journals')
        .doc(journalId)
        .collection('journalEntries')
        .stream;
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

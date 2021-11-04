import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstore/localstore.dart';

class TherapyRepository {
  TherapyRepository() {
    //AuthService authService;
    //authService.currentUser();
  }

  final _localdb = Localstore.instance;

  Future<void> setTherapy(Therapy therapy) async {
    Map<String, dynamic> therapyData = Map();

    therapyData = therapy.toJson();

    // print(therapyData);

    // therapy.

    await _localdb
        .collection('therapies')
        .doc(therapy.id)
        .set(therapyData)
        .catchError((e) {
      // print('error');
      // print(e);
    });
    return true;
  }

  Future<void> deleteTherapy(Therapy therapy) async {
    Map<String, dynamic> therapyData = therapy.toJson();
    // print(therapyData);

    await _localdb
        .collection('therapies')
        .doc(therapy.id)
        .delete()
        .catchError((e) {
      // print('ahhhhhhaaaa');

      // print(e);
    });
    return;
  }

  // Future<void> deleteAllTherapy() async {
  //   await _localdb.collection('therapies').get()
  //     ..forEach((key, value) async {
  //       // print({key: key, value: value});
  //       await _localdb.collection('therapies').doc(key).delete();
  //     });
  //   return;
  // }

  Future<DataResult<List<Map<String, dynamic>>>> getAllTherapies(
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.serverAndCache;

      var result = await _localdb.collection('therapies').get();

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

  Future<void> updateTherapy(Therapy therapy) async {
    //// print(therapy.name);

    Map<String, dynamic> therapyData = Map();
    therapyData = therapy.toJson();
    var timeNow = DateTime.now().toString();
    therapyData['updatedAt'] = timeNow;
    await _localdb
        .collection('therapies')
        .doc(therapy.id)
        .set(therapyData)
        .catchError((e) {
      //// print(e);
    });
    return true;
  }

  Future<void> createTherapy(Therapy therapy) async {
    //// print(therapy.userId);

    Map<String, dynamic> therapyData = therapy.toJson();
    // print(therapyData);
    var timeNow = DateTime.now().toString();
    therapyData['createdAt'] = timeNow;
    therapyData['updatedAt'] = timeNow;
    //// print(therapy.name);
    await _localdb
        .collection('therapies')
        .doc()
        .set(therapyData)
        .catchError((e) {
      //// print('ahhhhhhaaaa');

      // print(e);
    });
    return;
  }

  Stream<Map<String, dynamic>> onStateChanged() {
    //// print('hererehere' + uid);

    return _localdb.collection('therapies').stream;
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

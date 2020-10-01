import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';

class TherapyRepository {
  TherapyRepository();
  final Firestore _db = Firestore.instance;

  //Dont know if this is ever going to be used
  Future<DataResult<dynamic>> getTherapy(String uid, String therapyid) async {
    try {
      var result = await _db
          .collection("users")
          .document(uid)
          .collection('therapies')
          .document(therapyid)
          .get();
      var data = Map<String, dynamic>.from(result.data);
      data['id'] = result.documentID;

      return DataResult(data: data);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  //* TODO review update CRUD and transactions
  Future<void> updateTherapy(Therapy therapy) async {
    Map<String, dynamic> therapyData = Map();
    therapyData = therapy.toJson();
    await _db
        .collection('users')
        .document(therapy.id)
        .collection('therapies')
        .document(therapy.uid)
        .updateData(therapyData)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  Future<void> createTherapy(Therapy therapy) async {
    Map<String, dynamic> therapyData = therapy.toJson();
    print(therapyData.toString());
    await _db
        .collection('users')
        .document(therapy.id)
        .collection('therapies')
        .document()
        .setData(therapyData)
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
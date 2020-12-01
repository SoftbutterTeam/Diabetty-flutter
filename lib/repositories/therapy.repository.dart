import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapyRepository {
  TherapyRepository() {
    //AuthService authService;
    //authService.currentUser();
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      data['userId'] = uid;
      return DataResult(data: data);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllTherapies(String userId,
      {bool local}) async {
    try {
      Source source = local ? Source.cache : Source.server;

      var result = await _db
          .collection("users")
          .document(userId)
          .collection('therapies')
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

  Future<void> updateTherapy(Therapy therapy) async {
    //print(therapy.name);
    if (therapy.userId == null) return null;

    Map<String, dynamic> therapyData = Map();
    therapyData = therapy.toJson();
    var timeNow = DateTime.now().toString();
    therapyData['updatedAt'] = timeNow;
    await _db
        .collection('users')
        .document(therapy.userId)
        .collection('therapies')
        .document(therapy.id)
        .updateData(therapyData)
        .catchError((e) {
      //print(e);
    });
    return true;
  }

  Future<void> createTherapy(Therapy therapy) async {
    //print(therapy.userId);
    if (therapy.userId == null)
      therapy.userId = (await _firebaseAuth.currentUser()).uid;
    Map<String, dynamic> therapyData = therapy.toJson();
    print(therapyData);
    var timeNow = DateTime.now().toString();
    therapyData['createdAt'] = timeNow;
    therapyData['updatedAt'] = timeNow;
    //print(therapy.name);
    await _db
        .collection('users')
        .document(therapy.userId)
        .collection('therapies')
        .document()
        .setData(therapyData)
        .catchError((e) {
      //print('ahhhhhhaaaa');

      print(e);
    });
    return;
  }

  Stream<QuerySnapshot> onStateChanged(String uid) {
    //print('hererehere' + uid);

    return _db
        .collection('users')
        .document(uid)
        .collection('therapies')
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

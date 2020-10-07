import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';

class TherapyRepository {
  TherapyRepository(String uid) {
    AuthService authService;
    authService.currentUser();
    TherapySer
    this.uid = uid;
  }

  final Firestore _db = Firestore.instance;
  String uid;

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

  Future<DataResult<List<Map<String, dynamic>>>> getAllTherapies(
      String uid, String therapyid) async {
    try {
      var result = await _db
          .collection("users")
          .document('YDpBWyABH3ZluJ9sDKTCTGXCqzz1')
          .collection('therapies')
          .getDocuments();

      var data = (result.documents.map((e) {
        var json = Map<String, dynamic>.from(e.data)..['id'] = e.documentID;
        return json;
      }).toList());
      print(data.map((e) => e.toString()));
      return DataResult<List<Map<String, dynamic>>>(data: data);
    } catch (exception, stackTrace) {
      print('HELLLO');
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
//Stream<List<Map<String, dynamic>>>
//

  Stream<QuerySnapshot> get onStateChanged {
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

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/user.model.dart';

class UserRepository {
  UserRepository();
  final Firestore _db = Firestore.instance;

  Future<DataResult<dynamic>> getData(String uid) async {
    try {
      var result = await _db.collection("users").document(uid).get();
      // User user = User();
      // user.setDummy();
      // user.setAllAttributes(
      //     uid: "YDpBWyABH3ZluJ9sDKTCTGXCqzz1", email: "cloudyplays@gmail.com");

      // createUser(user);

      var data = Map<String, dynamic>.from(result.data);
      data['id'] = result.documentID;

      return DataResult(data: data);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<bool> isEmailUnique(String email) async {
    try {
      var result = await _db
          .collection("users")
          .where("email", isEqualTo: email)
          .getDocuments();

      if (result.documents.length == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  //* TODO review update CRUD and transactions
  Future<void> updateUser(User user) async {
    String documentId = user.uid;
    Map<String, dynamic> userData = user.toJson();
    await _db
        .collection('users')
        .document(documentId)
        .updateData(userData)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  Future<void> createUser(User user) async {
    Map<String, dynamic> userData = user.toJson();
    print(userData.toString());
    await _db
        .collection('users')
        .document(user.uid)
        .setData(userData)
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

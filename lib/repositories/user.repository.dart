import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/user.model.dart';
import 'package:flutter/services.dart';

class UserRepository {
  UserRepository();
  final Firestore _db = Firestore.instance;

  Future<DataResult<dynamic>> getData(String uid) async {
    try {
      var result = await _db.collection("users").document(uid).get();
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
      //// print(e);
      return false;
    }
  }

  //* TODO review update CRUD and transactions
  Future<void> updateUser(User user) async {
    String documentId = user.uid;
    Map<String, dynamic> userData = user.toJson();

    DateTime timeNow = DateTime.now();
    userData['updatedAt'] = timeNow;
    await _db
        .collection('users')
        .document(documentId)
        .updateData(userData)
        .catchError((e) {
      //// print(e);
    });
    return true;
  }

  Future<DataResult<dynamic>> searchUserbyPhone(String phoneno) async {
    try {
      var result = await _db
          .collection("users")
          .where("phoneNumber", isEqualTo: phoneno)
          .getDocuments();
      if (result.documents.length == 0) {
        return null;
      } else if (result.documents.length > 1) {
        result.documents.sort((DocumentSnapshot a, DocumentSnapshot b) {
          if (a['updatedAt'] == null) {
            return 1;
          }
          if (b['updatedAt'] == null) {
            return -1;
          }
          return DateTime.parse(a['updatedAt']).compareTo(a['updatedAt']);
        });
      }
      var data = Map<String, dynamic>.from(result.documents.first.data);
      data['id'] = result.documents.first.documentID;

      return DataResult(data: data);
    } catch (e) {
      return null;
    }
  }

  Future<void> createUser(User user) async {
    Map<String, dynamic> userData = user.toJson();

    if (user.uid == null) {
      //// print('no user id given in repo');
      return false;
    }
    DateTime timeNow = DateTime.now();
    userData['createdAt'] = timeNow;
    userData['updatedAt'] = timeNow;
    //// print(userData.toString());

    await _db
        .collection('users')
        .document(user.uid)
        .setData(userData)
        .catchError((e) {
      //// print(e);
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

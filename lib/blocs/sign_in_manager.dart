import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      print(0);
//await auth.signOut();
      print(1);
      String uid = (await auth.signInWithEmailAndPassword(email, password)).uid;
      print(2);
      return await fetch(uid);
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<DataResult<dynamic>> fetch(String uid) async {
    User user;
    print(3);
    try {
      var result =
          await Firestore.instance.collection("users").document(uid).get();
      sleep(Duration(seconds: 10));

      print('thisfar');
      var data = Map<String, dynamic>.from(result.data);
      data['id'] = result.documentID;

      print(data);
      print('thatfar');
      sleep(Duration(seconds: 10));
      return null;
      //user = User.fromDocument(result);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
    //return DataResult(data: user);
  }

  // Future<void> signInWithFacebook() async {
  //   return await _signIn(auth.signInWithFacebook);
  // }

  Future<void> signInWithApple() async {
    return await _signIn(auth.signInWithApple);
  }
}

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}

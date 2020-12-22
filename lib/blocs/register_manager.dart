import 'dart:async';

import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/models/user.model.dart' as UserModel;

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class RegisterManager {
  RegisterManager({@required this.auth, @required this.isLoading});
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

  Future<void> createAccount(String displayName, String name, String email,
      String mobile, String password) async {
    try {
      isLoading.value = true;
      var result = await auth.createUserWithEmailAndPassword(
          email,
          password,
          UserModel.User(
              displayName: displayName,
              email: email,
              name: name,
              phoneNumber: mobile));
      return result;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  // Future<void> signInWithFacebook() async {
  //   return await _signIn(auth.signInWithFacebook);
  // }

  Future<void> signInWithApple() async {
    return await _signIn(auth.signInWithApple);
  }
}

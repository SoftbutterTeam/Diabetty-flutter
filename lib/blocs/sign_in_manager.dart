import 'dart:async';

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
    await auth.signOut(); //auth.signInAnonymously);
    return null;
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      var result = await auth.signInWithEmailAndPassword(email, password);
      try {
        isLoading.value = false;
      } catch (e) {}
      return result;
    } catch (e) {
      try {
        isLoading.value = false;
      } catch (e) {}
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
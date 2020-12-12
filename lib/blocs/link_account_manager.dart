import 'dart:async';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class LinkAccountManager {
  LinkAccountManager({@required this.auth, @required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<void> startNewAccount(AppContext appContext) async {
    try {
      isLoading.value = true;
      await auth.startAsNewUser(appContext);
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> logoutAccount() async {
    try {
      isLoading.value = true;
      await auth.signOut();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> linkAccount(AppContext appContext, String password) async {
    try {
      isLoading.value = true;
      final credential = EmailAuthProvider.getCredential(
        email: appContext.firebaseUser.email,
        password: password,
      );
      await auth.linkAccount(credential);
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}

import 'dart:async';
import 'package:diabetty/models/user.model.dart' as UserModel;

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
}

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(
      String email, String password, UserModel.User userInfo);
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithEmailAndLink({String email, String link});
  Future<bool> isSignInWithEmailLink(String link);
  Future<void> sendSignInWithEmailLink({
    @required String email,
    @required String url,
    @required bool handleCodeInApp,
    @required String iOSBundleID,
    @required String androidPackageName,
    @required bool androidInstallIfNotAvailable,
    @required String androidMinimumVersion,
  });
  Future<void> startAsNewUser(AppContext appContext);
  Future<AuthResult> linkAccount(AuthCredential credential);
  Future<bool> isAccountLinkable();
  Future<User> signInWithGoogle();
  // Future<User> signInWithFacebook();
  Future<User> signInWithApple({List<Scope> scopes});
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}

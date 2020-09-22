import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service/user.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:random_string/random_string.dart' as random;
import 'dart:math' show Random;
import 'package:diabetty/models/user.model.dart' as UserModel;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class FirebaseAuthService implements AuthService {
  String mode = String.fromEnvironment('d_mode', defaultValue: 'test');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserService _userService = new UserService();

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInAnonymously() async {
    final AuthResult authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(EmailAuthProvider.getCredential(
      email: email,
      password: password,
    ));
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password, UserModel.User userInfo) async {
    String uid;
    AuthResult authResult;
    try {
      authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      uid = authResult.user.uid;
      userInfo.uid = uid;
      await _userService.createUser(userInfo);

      return _userFromFirebase(authResult.user);
    } catch (e) {
      if (uid != null) {
        try {
          await authResult.user.delete();
        } catch (e) {}
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER',
            message: 'Failed to Create Account. Try again later.');
      }
      rethrow;
    }
  }

  @override
  //* RegisterUser( email, password, displayname, name){

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithEmailAndLink({String email, String link}) async {
    final AuthResult authResult =
        await _firebaseAuth.signInWithEmailAndLink(email: email, link: link);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<bool> isSignInWithEmailLink(String link) async {
    return await _firebaseAuth.isSignInWithEmailLink(link);
  }

  @override
  Future<void> sendSignInWithEmailLink({
    @required String email,
    @required String url,
    @required bool handleCodeInApp,
    @required String iOSBundleID,
    @required String androidPackageName,
    @required bool androidInstallIfNotAvailable,
    @required String androidMinimumVersion,
  }) async {
    return await _firebaseAuth.sendSignInWithEmailLink(
      email: email,
      url: url,
      handleCodeInApp: handleCodeInApp,
      iOSBundleID: iOSBundleID,
      androidPackageName: androidPackageName,
      androidInstallIfNotAvailable: androidInstallIfNotAvailable,
      androidMinimumVersion: androidMinimumVersion,
    );
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    //*    e.g.googleUser.email
    //* if email is already in use -> connect it to existing user instead
    //*
    //*  final Future<String> userid = currentUser().then((user) => user.uid);
    //* FirebaseUser

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        User createdEmailUser;
        try {
          UserModel.User userInfo = new UserModel.User(
              name: googleUser.displayName,
              displayName: googleUser.displayName,
              email: googleUser.email);
          createdEmailUser = await createUserWithEmailAndPassword(
              googleUser.email, random.randomAlphaNumeric(15), userInfo);
        } catch (e) {}
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        if (createdEmailUser != null) {
          final AuthResult authResult = await linkAccount(credential);
          return _userFromFirebase(authResult.user);
        }
        final AuthResult authResult =
            await _firebaseAuth.signInWithCredential(credential);
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthResult> linkAccount(AuthCredential credential) async {
    return _firebaseAuth
        .currentUser()
        .then((authUser) => authUser.linkWithCredential(credential));
  }

  Future<void> startAsNewUser(AppContext appContext) async {
    User firebaseUser = await currentUser();
    UserModel.User user = UserModel.User(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        name: firebaseUser.displayName,
        email: firebaseUser.email);

    await _userService.createUser(user);
    await appContext.fetchUser(toSinkUserChange: true);
  }

  Future<bool> isAccountLinkable() async {
    final user = await currentUser();
    if (user == null) return null;
    final email = user.email;
    return _userService.isEmailUnique(email);
  }

  // @override
  // Future<User> signInWithFacebook() async {
  //   final FacebookLogin facebookLogin = FacebookLogin();
  //   // https://github.com/roughike/flutter_facebook_login/issues/210
  //   facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
  //   final FacebookLoginResult result =
  //       await facebookLogin.logIn(<String>['public_profile']);
  //   if (result.accessToken != null) {
  //     final AuthResult authResult = await _firebaseAuth.signInWithCredential(
  //       FacebookAuthProvider.getCredential(
  //           accessToken: result.accessToken.token),
  //     );
  //     return _userFromFirebase(authResult.user);
  //   } else {
  //     throw PlatformException(
  //         code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  //   }
  // }

  @override
  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final AuthorizationResult result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );

        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final updateUser = UserUpdateInfo();
          updateUser.displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(updateUser);
        }
        return _userFromFirebase(firebaseUser);
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );
      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
    }
    return null;
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // googleSignIn.signIn();
    await googleSignIn.signOut();
    return _firebaseAuth.signOut();
    /*   final FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    return _firebaseAuth.signOut();
    */
  }

  @override
  void dispose() {}
}

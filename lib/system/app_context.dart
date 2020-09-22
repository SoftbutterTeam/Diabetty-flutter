import 'dart:async';

import 'package:diabetty/services/authentication/auth_service/user.service.dart';
import 'package:diabetty/models/user.model.dart' as UserModel;
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';

class AppContext {
  AuthService _authService;

  UserService _userService = new UserService();

  UserModel.User _user;

  UserModel.User get user => _user;

  User _firebaseUser;
  User get firebaseUser => _firebaseUser;

  AppContext(this._authService);

  StreamController<UserModel.User> _onUserChanged = StreamController();

  Stream<UserModel.User> get onUserChanged => _onUserChanged.stream;

  bool isFetching = false;

  /// could use
  ///  final ValueNotifier<bool> isLoading;
  /// and the builders listen to value notifier instead
  /// but it will cause a reset all the time

  Future<void> init() async {
    _authService.onAuthStateChanged.listen((firebaseUser) async {
      print(' - onAuthStateChange: $firebaseUser');
      _firebaseUser = firebaseUser;
      if (firebaseUser != null) {
        //await Future.delayed(Duration(seconds: 10), null);
        print(' - got user: ${firebaseUser.uid}');
        fetchUser(toSinkUserChange: true);
      } else {
        print(" -- no user");
        _user = null;
        _onUserChanged.sink.add(_user);
      }
    });
  }

  Future<UserModel.User> fetchUser({bool toSinkUserChange = false}) async {
    isFetching = true;
    print("isFetching: turned on");
    _firebaseUser = (await _authService.currentUser());
    await Future.delayed(Duration(seconds: 10), null);
    if (_firebaseUser != null) {
      try {
        if (_firebaseUser.uid != null)
          _user = await _userService.fetchUser(_firebaseUser.uid);
        _user.uid = _firebaseUser.uid;
        if (toSinkUserChange) _onUserChanged.sink.add(_user);
        isFetching = false;
        print("isFetching: turned off");
        return _user;
      } catch (exception, stackTrace) {
        print("problem: $exception");
        _user = null;
        if (toSinkUserChange) _onUserChanged.addError(exception, stackTrace);
        isFetching = false;

        print("isFetching: turned off");

        return _user;
      }
    } else {
      isFetching = false;
      print("isFetching: turned off");
      return null;
    }
  }

  Future<UserModel.User> lazyFetchUser() async {
    Duration waitforfetchTime = Duration(seconds: 1);
    return null;
    if (_user != null && _user.uid == _firebaseUser.uid) return _user;

    if (isFetching) {
      await Future.delayed(waitforfetchTime);
      return await lazyFetchUser();
    }

    return _user;
  }

  void dispose() {
    _onUserChanged.close();
  }
}

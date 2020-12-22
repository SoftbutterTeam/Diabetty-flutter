import 'dart:async';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/services/authentication/auth_service/user.service.dart';
import 'package:diabetty/models/user.model.dart' as UserModel;
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class AppContext extends ChangeNotifier {
  AuthService authService;

  UserService _userService = new UserService();

  User _firebaseUser;
  User get firebaseUser => _firebaseUser;

  UserModel.User user;
  // UserModel.User get user => _user;

  AppContext(this.authService);

  StreamController<UserModel.User> _onUserChanged = StreamController();

  Stream<UserModel.User> get onUserChanged => _onUserChanged.stream;

  bool isFetching = false;

  List<Manager> systemManagerBlocs = List();

  /// could use
  ///  final ValueNotifier<bool> isLoading;
  /// and the builders listen to value notifier instead
  /// but it will cause a reset all the time

  Future<void> init() async {
    authService?.onAuthStateChanged?.listen((firebaseUser) async {
      //print(' - onAuthStateChange: $firebaseUser');

      _firebaseUser = firebaseUser;
      if (firebaseUser != null) {
        //await Future.delayed(Duration(seconds: 10), null);
        //print(' - got user: ${firebaseUser.uid}');
        await fetchUser(toSinkUserChange: true);
      } else {
        //print(" -- no user");
        user = null;
        _onUserChanged.sink.add(user);
      }
      //print(systemManagerBlocs);
      systemManagerBlocs.forEach((element) async {
        await element.init();
      });
      notifyListeners();
    });
  }

  Future<UserModel.User> fetchUser({bool toSinkUserChange = false}) async {
    isFetching = true;
    //print("isFetching: turned on");
    _firebaseUser ??= (await authService?.currentUser());

    if (_firebaseUser != null) {
      try {
        if (_firebaseUser.uid != null)
          user = await _userService.fetchUser(_firebaseUser.uid);
        user.uid = _firebaseUser.uid;
        if (toSinkUserChange) _onUserChanged.sink.add(user);
        isFetching = false;
        //print("isFetching: turned off");
        return user;
      } catch (exception, stackTrace) {
        //print("problem: $exception");
        user = null;
        if (toSinkUserChange) _onUserChanged.addError(exception, stackTrace);
        isFetching = false;

        //print("isFetching: turned off");

        return user;
      }
    } else {
      print('this bs is running');
      isFetching = false;
      //print("isFetching: turned off");
      return null;
    }
  }

  Future<UserModel.User> lazyFetchUser() async {
    Duration waitforfetchTime = Duration(seconds: 1);

    if (user != null && user.uid == _firebaseUser.uid) return user;

    if (isFetching) {
      await Future.delayed(waitforfetchTime);
      return await lazyFetchUser();
    }

    return user;
  }

  void dispose() {
    _onUserChanged.close();
  }

  getTherapies() {}
}

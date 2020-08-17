import 'dart:ui';

import 'package:diabetttty/models/Profile.dart';
import 'package:diabetttty/models/User.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppState with ChangeNotifier {
  User _userAccount;
  Profile _userProfile;

  bool get isLoggedIn => userAccount.isLoggedIn;
  User get userAccount => _userAccount;
  Profile get userProfile => _userProfile;

  AppState() {
    if (userAccount == null) {
      this._userAccount = new User();
    } else {
      print("last login: " + userAccount.lastLogin);
    }
  }

  Future restoreData() async {
    print("RESTOREIIING DATAAAAAAAAAA");
    await this._userAccount.restoreData();
    print("app done");
    notifyListeners();
  }
}

/**
 * TODO soon merge with other App_State code which considers change in language
 * underscore before a variable name means its an internal function or var.abstract
 * not to be used outside the function
 */

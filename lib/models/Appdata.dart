import 'dart:ui';

import 'package:diabetttty/models/Profile.dart';
import 'package:diabetttty/models/UserAccount.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppState with ChangeNotifier {
  UserAccount _userAccount;
  Profile _userProfile;

  bool get isLoggedIn => userAccount.isLoggedIn;
  UserAccount get userAccount => _userAccount;
  Profile get userProfile => _userProfile;

  AppState() {
    if (userAccount == null) {
      this._userAccount = new UserAccount();
    } else {
      print("last login: " + userAccount.lastLogin);
    }
  }

  Future restoreData() async {
    print("RESTOREIIING DATAAAAAAAAAA");
    print(await this._userAccount.restoreData());
    notifyListeners();
  }
}

/**
 * TODO soon merge with other App_State code which considers change in language
 * underscore before a variable name means its an internal function or var.abstract
 * not to be used outside the function
 */

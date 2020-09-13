import 'package:diabetttty/oldfiles/User.dart';
import 'package:flutter/cupertino.dart';

class AppContext with ChangeNotifier {
  User _userAccount;

  bool get isLoggedIn => userAccount.isLoggedIn;
  User get userAccount => _userAccount;

  AppContext() {
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

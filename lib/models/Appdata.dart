import 'package:diabetttty/models/Profile.dart';
import 'package:diabetttty/models/UserAccount.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Appdata {
  UserAccount userAccount;
  Profile userProfile;

  Appdata() {
    if (UserAccount == null) {
      this.userAccount = new UserAccount.fromAll(
          null, null, null, null, null, DateTime.now().toString(), null);
    }
  }

  void restoreAccountData() async {
    print(await this.userAccount.restoreData());
  }
}

/**
 * underscore before a variable name means its an internal function or var.abstract
 * not to be used outside the function
 */

import 'package:diabetttty/models/AppData.dart';

class RegisterCon {
  static bool registerAsGuest(AppState appState) {
    if (appState.userAccount.type != null) {
      appState.userAccount.initGuestUser();
      return true;
    }
    return false;
  }
}

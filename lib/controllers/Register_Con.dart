import 'package:diabetttty/models/AppData.dart';
import 'package:diabetttty/models/UserAccount.dart';

class RegisterCon {
  static bool registerAsGuest(AppState appState, String name) {
    if (appState.userAccount.loggedIn != true) {
      appState.userAccount.initGuestUser(name: name);
      return true;
    }
    return false;
  }

  static bool registerUserA(AppState appState, RegisterUserForm registerInfo) {
    if (appState.userAccount.loggedIn != true) {
      appState.userAccount.registerUserA(registerInfo);
    }

    // TODO create a model for Form info, pass it through. Then edit registerUserA to extract what is can.
    // TODO wrtie saveData() after creation
  }
}

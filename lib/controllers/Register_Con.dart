import 'package:diabetttty/models/AppState.dart';
import 'package:diabetttty/models/forms/UserForm.dart';
import 'package:diabetttty/models/User.dart';

class RegisterCon {
  static bool registerAsGuest(AppState appState, String name) {
    if (appState.userAccount.isLoggedIn != true) {
      appState.userAccount.initGuestUser(name: name);
      return true;
    }
    return false;
  }

  static bool registerUserA(AppState appState, UserForm userform) {
    appState.userAccount.registerUserA2(userform: userform);
    print(userform.email);
    return true;
  }

  static bool registerUserB(AppState appState, UserForm userform) {
    appState.userAccount.registerUserB2(userform: userform);
    print(userform.email);
    return true;
  }

  static void submitIntroData(AppState appState, UserForm userform) {
    print("hwifhwiebfgweb");
    print("Userform" + userform.referralCode.toString());
    userform.status = "activeeEEeeeEEEee";
    appState.userAccount.updateUserWithForm(userform: userform);
  }
}

/**  todo static bool registerUserA(AppState appState, RegisterUserForm registerInfo) {
    // TODO create a model for Form info, pass it through. Then edit registerUserA to extract what is can.
    // TODO wrtie saveData() after creation
  }
  */

import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/screens/auth_screens/link_accounts/link_accounts.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/welcome.screen.dart';
import 'package:diabetty/ui/screens/loading/loading.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/user.model.dart' as UserModel;

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
/// Note: this class used to be called [LandingPage].
class AuthWidget extends StatelessWidget {
  const AuthWidget(
      {Key key,
      @required this.userSnapshot,
      this.aUserSnapshot,
      this.navigateTo,
      this.unauthorisedNavigateTo})
      : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  final AsyncSnapshot<UserModel.User> aUserSnapshot;
  final Widget navigateTo;
  final Widget unauthorisedNavigateTo;

  @override
  Widget build(BuildContext context) {
    final appContext = Provider.of<AppContext>(context, listen: false);
    if (userSnapshot.connectionState == ConnectionState.active &&
        aUserSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData
          ? FutureBuilder<UserModel.User>(
              future: appContext.lazyFetchUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return LoadingScreen();
                // print('dadada d' + snapshot.data.toJson().toString());
                return snapshot.hasData
                    ? WelcomeScreen() // todo here put home screen
                    : LinkAccountBuilder(); // todo here but link or create new
              })
          : unauthorisedNavigateTo; //unauthorisedNavigateTo;

    } else {
      return LoadingScreen();
    }
  }
}

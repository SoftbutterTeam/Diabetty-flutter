import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/layouts/dashboard.layout.dart';
import 'package:diabetty/ui/screens/auth_screens/link_accounts/link_accounts.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/welcome.screen.dart';
import 'package:diabetty/ui/screens/loading_screens/loading.screen.dart';
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
    print(1);
    if (userSnapshot.connectionState == ConnectionState.active &&
        aUserSnapshot.connectionState == ConnectionState.active) {
      print(3);
      if (userSnapshot.hasData) {
        print(4);

        return FutureBuilder<UserModel.User>(
            future: appContext.lazyFetchUser(),
            builder: (context, snapshot) {
              print('snappshot ' + snapshot.data.toString());
              if (snapshot.connectionState != ConnectionState.done)
                return LoadingScreen();
              return snapshot.hasData
                  ? DashBoard(initIndex: 1) // todo here put home screen
                  : LinkAccountBuilder(); // todo here but link or create new
            });
      }
      print(2);
      return LoginScreenBuilder(); //unauthorisedNavigateTo;

    } else {
      return LoadingScreen();
    }
  }
}

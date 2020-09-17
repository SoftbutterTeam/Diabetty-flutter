import 'package:diabetty/services/authentication/auth_service/auth_service.dart';

import 'package:flutter/material.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
/// Note: this class used to be called [LandingPage].
class AuthWidget extends StatelessWidget {
  const AuthWidget(
      {Key key,
      @required this.userSnapshot,
      this.navigateTo,
      this.unauthorisedNavigateTo})
      : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  final Widget navigateTo;
  final Widget unauthorisedNavigateTo;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData
          ? unauthorisedNavigateTo
          : unauthorisedNavigateTo; //unauthorisedNavigateTo;
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

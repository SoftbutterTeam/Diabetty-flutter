import 'package:diabetty/ui/screens/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/register/register.screen.dart';
import 'package:diabetty/ui/screens/layouts/dashboard.layout.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreenBuilder());
      case register:
        return MaterialPageRoute(
            builder: (BuildContext context) => RegisterScreenBuilder());
      case home:
        return PageRouteBuilder(
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 1),
            transitionDuration: Duration(seconds: 0));
      case today:
        return PageRouteBuilder(
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 1),
            transitionDuration: Duration(seconds: 0));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

const String login = '/login';
const String register = '/register';
const String home = '/home';
const String today = '/dashboard/today';

import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case diary:
        return MaterialPageRoute(builder: (_) => DashBoard(initIndex: 0));
      case today:
        return MaterialPageRoute(builder: (_) => DashBoard(initIndex: 1));
      case therapy:
        return MaterialPageRoute(builder: (_) => DashBoard(initIndex: 2));
      case login:
        return MaterialPageRoute(builder: (_) => LoginForm());
      case loginsplashscreen:
         return MaterialPageRoute(builder: (_) => SplashScreen(route: login,));
      // case '/settings':
      //   return MaterialPageRoute(builder: (_) => Settings());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

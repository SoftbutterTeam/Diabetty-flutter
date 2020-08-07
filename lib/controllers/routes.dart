import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/constant.dart';
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

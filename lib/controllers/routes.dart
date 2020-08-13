import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case diary:
        return MaterialPageRoute(builder: (context) => DashBoard(initIndex: 0));
      case today:
        return MaterialPageRoute(builder: (_) => DashBoard(initIndex: 1));
      case therapy:
        return MaterialPageRoute(builder: (_) => DashBoard(initIndex: 2));
      case login:
        var page = LoginForm();
        // page.createState().initState();

        return MaterialPageRoute(builder: (_) => page);

      case loginsplashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen(route: login));
      case initialquestion:
        return MaterialPageRoute(builder: (_) => InitialQuestionPage());
      case diabeticuserquestion:
        return MaterialPageRoute(builder: (_) => DiabeticUserQuestions());
      case buddyuserquestion:
        return MaterialPageRoute(builder: (_) => BuddyUserQuestions());
      case homescreensplashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen(route: diary));
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

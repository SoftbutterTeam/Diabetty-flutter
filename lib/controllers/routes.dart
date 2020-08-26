import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case diary:
        return MaterialPageRoute(builder: (BuildContext context) => DashBoard(initIndex: 0));
      case today:
        return MaterialPageRoute(builder: (BuildContext context) => DashBoard(initIndex: 1));
      case therapy:
        return MaterialPageRoute(builder: (BuildContext context) => DashBoard(initIndex: 2));
      case login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginForm());
      case loginsplashscreen:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen(route: login));
      case initialquestion:
        return MaterialPageRoute(builder: (BuildContext context) => InitialQuestionPage());
      case diabeticuserquestion:
        return MaterialPageRoute(builder: (BuildContext context) => DiabeticUserQuestions());
      case buddyuserquestion:
        return MaterialPageRoute(builder: (BuildContext context) => BuddyUserQuestions());
      case homescreensplashscreen:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen(route: diary));
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

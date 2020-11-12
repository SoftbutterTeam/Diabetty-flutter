import 'package:diabetty/ui/screens/diary/add_journal/add_journal.screen.dart';
import 'package:diabetty/ui/screens/others/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/others/auth_screens/register/register.screen.dart';
import 'package:diabetty/ui/layouts/dashboard.layout.dart';
import 'package:diabetty/ui/screens/others/settings_screens/settings_screen.dart';
import 'package:diabetty/ui/screens/therapy/add_medication.screen.dart';
import 'package:diabetty/ui/screens/therapy/therapy_profile.screen.dart';
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
      case addmedication:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddMedicationScreenBuilder());
      case therapyprofile:
        return MaterialPageRoute(
          settings: settings,
            builder: (BuildContext context) { 
                print((settings.arguments as Map)['reminder'].toString());
                print((ModalRoute.of(context).settings.arguments as Map)['reminder'].toString());
              return TherapyProfileScreen()});
      case appsettings:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingsScreen());
      case addJournal:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddJournalScreen());
      case diary:
        return PageRouteBuilder(
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 0),
            transitionDuration: Duration(seconds: 0));
      case today:
        return PageRouteBuilder(
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 1),
            transitionDuration: Duration(seconds: 0));
      case therapy:
        return PageRouteBuilder(
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 3),
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
const String diary = '/dashboard/diary';
const String today = '/dashboard/today';
const String therapy = '/dashboard/therapy';
const String addmedication = '/therapy/addmedication';
const String therapyprofile = '/therapy/therapyprofile';
const String appsettings = '/settings';
const String appearanceSettings = '/appearanceSettings';
const String addJournal = '/diary/addjournal';

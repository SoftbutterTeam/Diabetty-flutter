import 'package:diabetty/ui/screens/diary/a_journal/journal.screen.dart';
import 'package:diabetty/ui/screens/diary/add_journal/add_journal.screen.dart';
import 'package:diabetty/ui/layouts/dashboard.layout.dart';
import 'package:diabetty/ui/screens/others/settings_screens/settings.screen.dart';
import 'package:diabetty/ui/screens/therapy/add_medication.screen.dart';
import 'package:diabetty/ui/screens/diary/history/history.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map arguments = settings.arguments as Map;
    switch (settings.name) {
      case addmedication:
        return CupertinoPageRoute(
            builder: (BuildContext context) => AddMedicationScreenBuilder());

      case appsettings:
        return CupertinoPageRoute(
            builder: (BuildContext context) => SettingsScreen());
      case addJournal:
        return CupertinoPageRoute(
            builder: (BuildContext context) => AddJournalScreenBuilder());
      case aJournal:
        return CupertinoPageRoute(
            builder: (BuildContext context) =>
                JournalScreen(journal: arguments['journal']));
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
            pageBuilder: (_, a1, a2) => DashBoard(initIndex: 2),
            transitionDuration: Duration(seconds: 0));

      case history:
        return CupertinoPageRoute(
            builder: (BuildContext context) => HistoryScreenBuilder());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body:
                      Center(child: Text('No page found for ${settings.name}')),
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
const String aJournal = '/diary/journal';
const String history = '/diary/history';
const String team = '/dashboard/team';
const String supportFriend = '/team/supportFriend';

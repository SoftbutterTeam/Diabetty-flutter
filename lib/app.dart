import 'package:diabetttty/components/index.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/index.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _routes = {
      '/splashscreen': (context) => SplashScreen(),
      '/dashboards/dailyplanner': (context) => DashBoard(initIndex: 0),
      '/dashboards/reminder': (context) => DashBoard(initIndex: 1),
      '/dashboards/plan': (context) => DashBoard(initIndex: 2),
      '/dashboards/sos': (context) => DashBoard(initIndex: 3),
    };

    return ChangeNotifierProvider(
      create: (_) => AppState('en'),
      child: Consumer<AppState>(
        builder: (context, provider, builder) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // fontFamily: 'Andina',
              primaryColor: t3colorCustom,
              accentColor: appWhite,
              scaffoldBackgroundColor: t3_app_background,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/splashscreen',
            routes: _routes,
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: SBehavior(),
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}

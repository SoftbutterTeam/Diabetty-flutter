import 'package:diabetttty/components/Scroll_Behaviour/SBehavior.dart';
import 'package:diabetttty/screens/draft_screen.dart';
import 'package:diabetttty/screens/layouts/dashboard.dart';
import 'package:diabetttty/screens/splash_screens/Splash_Screen.dart';
import 'package:diabetttty/theme/AppColors.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:diabetttty/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _routes = {
      '/dashboards/dailyplanner': (context) => DashBoard(initIndex: 2)
    };

    return ChangeNotifierProvider(
        create: (_) => AppState('en'),
        child: Consumer<AppState>(builder: (context, provider, builder) {
          return MaterialApp(
            title: 'Diabetty Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // fontFamily: 'Andina',
              primaryColor: colorCustom,
              accentColor: appWhite,
              scaffoldBackgroundColor: appWhite,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/dashboards/dailyplanner',
            routes: _routes,
            //home: SplashScreen(),
            //TODO: need to apply a SplashScreen that follows on with the correct route after finishing.
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: SBehavior(),
                child: child,
              );
            },
          );
        }));
  }
}

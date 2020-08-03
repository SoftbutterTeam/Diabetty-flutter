import 'package:diabetttty/components/Scroll_Behaviour/SBehavior.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/AppColors.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:diabetttty/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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
              fontFamily: 'OpenSans',
              primaryColor: colorCustom,
              accentColor: appWhite,
              scaffoldBackgroundColor: appWhite,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/dashboards/dailyplanner',
            routes: _routes,
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

import 'package:diabetttty/components/Scroll_Behaviour/SBehavior.dart';
import 'package:diabetttty/controllers/Register_Con.dart';
import 'package:diabetttty/controllers/routes.dart';
import 'package:diabetttty/models/AppState.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/AppColors.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:diabetttty/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'theme/constant.dart';

class App extends StatelessWidget {
  Future _init() async {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    await appState.restoreData();
    print("done with init");
  }

  AppState appState = new AppState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (Center(
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return (MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => AppLangState('en'),
                ),
                ChangeNotifierProvider(create: (context) => appState),
                ChangeNotifierProvider(
                    create: (context) => appState.userAccount),
                ChangeNotifierProvider(
                    create: (context) => appState.userProfile),
              ],
              child: Consumer<AppLangState>(
                builder: (context, provider, _) {
                  print("helllo" + appState.isLoggedIn.toString());
                  return MaterialApp(
                    title: 'Diabuddy',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      fontFamily: 'OpenSans',
                      primaryColor: colorCustom,
                      accentColor: appWhite,
                      scaffoldBackgroundColor: t3_app_background,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    onGenerateRoute: Router.generateRoute,
                    initialRoute: appState.isLoggedIn
                        ? (!appState.userAccount.status.contains("no-intro")
                            ? diary
                            : (!appState.userAccount.type.contains("GA")
                                ? initialquestion
                                : diabeticuserquestion))
                        : loginsplashscreen,
                    builder: (context, child) {
                      return ScrollConfiguration(
                        behavior: SBehavior(),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ));
          }
        });
  }
}

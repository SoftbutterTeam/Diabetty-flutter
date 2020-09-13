import 'package:diabetttty/system/AppProvider.dart';
import 'package:diabetttty/routes.dart';
import 'package:diabetttty/ui/components/Scroll_Behaviour/SBehavior.dart';
import 'package:diabetttty/ui/theme/AppColors.dart';
import 'package:diabetttty/ui/theme/app_state.dart';
import 'package:diabetttty/ui/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'ui/theme/constant.dart';

class App extends StatelessWidget {
  Future _init() async {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    await appState.restoreData();
    print("done with init");
  }

  final AppState appState = new AppState();

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
                      scaffoldBackgroundColor: Colors.grey[50],
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

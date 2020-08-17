import 'package:diabetttty/components/Scroll_Behaviour/SBehavior.dart';
import 'package:diabetttty/controllers/routes.dart';
import 'package:diabetttty/screens/index.dart';
import 'package:diabetttty/theme/AppColors.dart';
import 'package:diabetttty/theme/app_state.dart';
import 'package:diabetttty/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'models/AppData.dart';
import 'theme/constant.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  Future _init() async {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //statusBarColor: Colors.
        systemNavigationBarColor: Colors.white));
    await appState.restoreData();
    // Should probs be an init function instead
    //Try removing this line once we get it working since its in the constructor
  }

  AppState appState = new AppState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init(),
        builder: (context, _) {
          return (
              //  inject providers
              MultiProvider(
                  providers: [
                ChangeNotifierProvider(
                  create: (_) => AppLangState('en'),
                ),
                ChangeNotifierProvider(
                    create: (context) => appState.userAccount),
                ChangeNotifierProvider(
                    create: (context) => appState.userProfile),
              ],
                  child:
                      Consumer<AppLangState>(builder: (context, provider, _) {
                    print(
                        "_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n_______________________________________\n");
                    print(appState.isLoggedIn);
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
                      initialRoute: appState.isLoggedIn ? diary : loginsplashscreen,
                      builder: (context, child) {
                        return ScrollConfiguration(
                          behavior: SBehavior(),
                          child: child,
                        );
                      },
                    );
                  })));
        });
  }
}

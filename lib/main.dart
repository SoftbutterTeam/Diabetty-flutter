import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart' as routerthing;
import 'package:diabetty/services/authentication/apple_auth_api/apple_sign_in_available.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service_adapter.dart';
import 'package:diabetty/services/authentication/firebase_email_api/email_secure_store.dart';
import 'package:diabetty/services/authentication/firebase_email_api/firebase_email_link_handler.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/auth_widget.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/auth_widget_builder.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/email_link_error_presenter.dart';
import 'package:diabetty/ui/common_widgets/scroll_behaviours/SBehavior.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/user.model.dart' as UserModel;
import 'package:diabetty/utils/application_state_reset_timer.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: appWhite));
  runApp(MyApp(appleSignInAvailable: appleSignInAvailable));
  // runApp(LoginApp());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {this.initialAuthServiceType = AuthServiceType.firebase,
      this.appleSignInAvailable});
  final AuthServiceType initialAuthServiceType;
  final AppleSignInAvailable appleSignInAvailable;

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthServiceAdapter(
      initialAuthServiceType: initialAuthServiceType,
    );
    AppContext appContext = AppContext(authService)..init();
    TherapyManager therapyManager = TherapyManager(appContext: appContext)
      ..init();

    DiaryBloc diaryBloc = DiaryBloc(appContext: appContext)..init();
    DayPlanManager dayPlanManager = DayPlanManager(appContext: appContext)
      ..init();
    TeamManager teamManager = TeamManager(appContext: appContext)..init();
    return MultiProvider(
        providers: [
          // ignore: todo
          //*TODO place AppleSignIn and emailSecure in AuthService
          Provider<AppleSignInAvailable>.value(value: appleSignInAvailable),
          Provider<AuthService>(
            create: (_) => authService,
            dispose: (_, AuthService authService) => authService.dispose(),
          ),
          Provider<AppContext>(
            create: (_) => appContext,
            dispose: (
              _,
              AppContext appContext,
            ) =>
                appContext.dispose(),
          ),
          ChangeNotifierProvider<TherapyManager>(
            create: (_) => therapyManager,
          ),
          ChangeNotifierProvider<DayPlanManager>(
            create: (_) => dayPlanManager,
          ),
          ChangeNotifierProvider<DiaryBloc>(
            create: (_) => diaryBloc,
          ),
          ChangeNotifierProvider<TeamManager>(
            create: (_) => teamManager,
          ),
          Provider<EmailSecureStore>(
            create: (_) => EmailSecureStore(
              flutterSecureStorage: FlutterSecureStorage(),
            ),
          ),
          ProxyProvider2<AuthService, EmailSecureStore,
              FirebaseEmailLinkHandler>(
            update:
                (_, AuthService authService, EmailSecureStore storage, __) =>
                    FirebaseEmailLinkHandler(
              auth: authService,
              emailStore: storage,
              firebaseDynamicLinks: FirebaseDynamicLinks.instance,
            )..init(),
            dispose: (_, linkHandler) => linkHandler.dispose(),
          ),
        ],
        child: AuthWidgetBuilder(builder: (BuildContext context,
            AsyncSnapshot<User> userSnapshot,
            AsyncSnapshot<UserModel.User> aUserSnapshot) {
          startKeepAlive(dayPlanManager.refresh);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.indigo,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: routerthing.Router.generateRoute,
              home: EmailLinkErrorPresenter.create(context,
                  child: AuthWidget(
                    userSnapshot: userSnapshot,
                    aUserSnapshot: aUserSnapshot,
                  )),
              builder: (context, child) => ScrollConfiguration(
                    behavior: SBehavior(),
                    child: child,
                  ));
        }));
  }
}

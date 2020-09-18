import 'package:diabetty/services/authentication/apple_auth_api/apple_sign_in_available.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service_adapter.dart';
import 'package:diabetty/services/authentication/firebase_email_api/email_secure_store.dart';
import 'package:diabetty/services/authentication/firebase_email_api/firebase_email_link_handler.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/auth_widget.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/auth_widget_builder.dart';
import 'package:diabetty/ui/common_widgets/auth_widget/email_link_error_presenter.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/welcome.screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
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
    return MultiProvider(
      providers: [
        // ignore: todo
        //*TODO place AppleSignIn and emailSecure in AuthService
        Provider<AppleSignInAvailable>.value(value: appleSignInAvailable),
        Provider<AuthService>(
          create: (_) => AuthServiceAdapter(
            initialAuthServiceType: initialAuthServiceType,
          ),
          dispose: (_, AuthService authService) => authService.dispose(),
        ),
        Provider<EmailSecureStore>(
          create: (_) => EmailSecureStore(
            flutterSecureStorage: FlutterSecureStorage(),
          ),
        ),
        ProxyProvider2<AuthService, EmailSecureStore, FirebaseEmailLinkHandler>(
          update: (_, AuthService authService, EmailSecureStore storage, __) =>
              FirebaseEmailLinkHandler(
            auth: authService,
            emailStore: storage,
            firebaseDynamicLinks: FirebaseDynamicLinks.instance,
          )..init(),
          dispose: (_, linkHandler) => linkHandler.dispose(),
        ),
      ],
      child: AuthWidgetBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: EmailLinkErrorPresenter.create(
            context,
            child: AuthWidget(
              userSnapshot: userSnapshot,
              unauthorisedNavigateTo: WelcomeScreen(),
              navigateTo: null,
            ),
          ),
        );
      }),
    );
  }
}

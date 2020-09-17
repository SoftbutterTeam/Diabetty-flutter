import 'package:diabetty/blocs/sign_in_manager.dart';
import 'package:diabetty/constants/strings.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/ui/common_widgets/platform_widgets/platform_exception_alert_dialog.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/keys.dart';
import 'package:diabetty/ui/screens/auth_screens/login/components/background.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/already_have_an_account_acheck.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_button.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_input_field.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_password_field.dart';

import 'package:diabetty/ui/screens/auth_screens/login/components/or_divider.dart';
import 'package:diabetty/ui/screens/auth_screens/login/components/social_icon.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/welcome.screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, SignInManager manager, __) => LoginScreen._(
              isLoading: isLoading.value,
              manager: manager,
              title: 'Firebase Auth Demo',
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  const LoginScreen._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  final SignInManager manager;
  final String title;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      print("yoyo");
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithEmailAndPassword("admin@123.com", "adminn");
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  // ignore: unused_element
  Future<void> _signInWithApple(BuildContext context) async {
    try {
      await manager.signInWithApple();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }
  /*
  Future<void> _signInWithEmailLink(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailLinkSignInPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Login",
              press: () {},
            ),
            Text(
              "forgotten password?",
              style: TextStyle(color: kPrimaryColor),
            ),
            SizedBox(height: size.height * 0.03),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  key: LoginScreen.facebookButtonKey,
                  iconSrc: "assets/icons/social/facebook.svg",
                  press: isLoading ? null : () => _signInWithFacebook(context),
                ),
                SocalIcon(
                  key: LoginScreen.anonymousButtonKey,
                  iconSrc: "assets/icons/social/twitter.svg",
                  press: isLoading ? null : () => _signInAnonymously(context),
                ),
                SocalIcon(
                  key: LoginScreen.googleButtonKey,
                  size: 30,
                  iconSrc: "assets/icons/social/google-plus.svg",
                  press: isLoading ? null : () => _signInWithGoogle(context),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.20),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

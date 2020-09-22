import 'package:diabetty/blocs/sign_in_manager.dart';
import 'package:diabetty/constants/strings.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/platform_widgets/platform_exception_alert_dialog.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/constants/keys.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/loading_button.dart';
import 'package:diabetty/ui/screens/auth_screens/form_models/email_password_form.model.dart';
import 'package:diabetty/ui/screens/auth_screens/login/components/background.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/already_have_an_account_acheck.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_button.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_input_field.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_password_field.dart';
import 'package:diabetty/ui/screens/auth_screens/register/register.screen.dart';
import 'package:validators/validators.dart' as validator;

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
            builder: (_, SignInManager manager, __) =>
                LoginScreen._(isLoading: isLoading.value, manager: manager),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  const LoginScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  EmailPasswordForm emailPasswordForm = EmailPasswordForm();
  final _loginKey = GlobalKey<FormState>();

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await widget.manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);

    print(appContext.user == null ? null : appContext.user.toJson());
    /* todo DO NOT DELETE, THIS IS THE REAL CODE
    try {
      await widget.manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }*/
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await widget.manager
          .signInWithEmailAndPassword("admin@123.com", "adminn");
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await widget.manager.signInWithEmailAndPassword(email, password);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      await widget.manager.signInWithApple();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _body(context),
    );
  }

  String _formSave() {
    _loginKey.currentState.save();
    return null;
  }

  Widget _buildEmailPasswordLoginForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _loginKey,
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            validator: (value) => !validator.isEmail(value)
                ? "Please enter a valid Email"
                : _formSave(),
            onSaved: (String value) =>
                emailPasswordForm.email = value.trim().toLowerCase(),
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            formKey: _loginKey,
            isLoginForm: true,
            onSaved: (value) => emailPasswordForm.password = value,
          ),
          LoadingButton(
              isLoading: widget.isLoading,
              child: RoundedButton(
                text: "Login",
                press: () {
                  if (_loginKey.currentState.validate()) {
                    _loginKey.currentState.save();
                    _signInWithEmailAndPassword(context,
                        emailPasswordForm.email, emailPasswordForm.password);
                  }
                },
              )),
          SizedBox(height: size.height * 0.01),
          Text(
            "forgotten password?",
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      )),
    );
  }

  Widget _buildSocialLogins(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocalIcon(
          key: LoginScreen.facebookButtonKey,
          iconSrc: facebook_social,
          color: Colors.lightBlue[700],
          press: widget.isLoading ? null : () => _signInWithFacebook(context),
        ),
        SocalIcon(
          key: LoginScreen.anonymousButtonKey,
          iconSrc: apple_social,
          color: Colors.lightBlue[700],
          press: widget.isLoading ? null : () => _signInAnonymously(context),
        ),
        SocalIcon(
          key: LoginScreen.googleButtonKey,
          size: 60,
          iconSrc: google_social,
          press: widget.isLoading ? null : () => _signInWithGoogle(context),
        ),
      ],
    ));
  }

  Widget _buildAlreadyHaveAccount(BuildContext context) {
    return AlreadyHaveAnAccountCheck(
      login: true,
      press: () {
        Navigator.pushNamed(context, register);
      },
    );
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        //height: size.height,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.15),
                  _buildEmailPasswordLoginForm(context),
                  SizedBox(height: size.height * 0.02),
                  OrDivider(),
                  _buildSocialLogins(context),
                ],
              ),
            ),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildAlreadyHaveAccount(context)),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}

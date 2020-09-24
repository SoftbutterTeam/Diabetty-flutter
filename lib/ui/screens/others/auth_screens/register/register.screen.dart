import 'package:diabetty/blocs/register_manager.dart';

import 'package:diabetty/constants/strings.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/ui/common_widgets/platform_widgets/platform_exception_alert_dialog.dart';

import 'package:diabetty/ui/constants/keys.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/loading_button.dart';
import 'package:diabetty/ui/screens/others/auth_screens/form_models/create_account_form.model.dart';
import 'package:diabetty/ui/screens/others/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/others/auth_screens/register/components/background.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/already_have_an_account_acheck.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_button.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_input_field.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_password_field.dart';
import 'package:validators/validators.dart' as validator;

import 'package:diabetty/ui/screens/others/auth_screens/register/components/or_divider.dart';
import 'package:diabetty/ui/screens/others/auth_screens/register/components/social_icon.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<RegisterManager>(
          create: (_) => RegisterManager(auth: auth, isLoading: isLoading),
          child: Consumer<RegisterManager>(
            builder: (_, RegisterManager manager, __) =>
                RegisterScreen._(isLoading: isLoading.value, manager: manager),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  const RegisterScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final RegisterManager manager;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  CreateAccountForm createAccountForm = CreateAccountForm();
  final _registerKey = GlobalKey<FormState>();

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await widget.manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await widget.manager
          .createAccount("test", "test user", "admin@123.com", "adminn");
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _registerWithEmailandPassword(BuildContext context,
      String displayName, String name, String email, String password) async {
    try {
      await widget.manager.createAccount(displayName, name, email, password);
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
    _registerKey.currentState.save();
    return null;
  }

  // ignore: unused_element
  Widget _buildCreateAccountForm(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _registerKey,
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
            keyboardType: TextInputType.name,
            hintText: 'Name',
            validator: (value) => !validator.isLength(value, 3)
                ? 'Please enter a Name'
                : _formSave(),
            onSaved: (String value) {
              createAccountForm.name = value.trim().toLowerCase();
              createAccountForm.displayName =
                  createAccountForm.name.split(" ")[0];
            },
          ),
          RoundedInputField(
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            //icon: Icons.email,
            validator: (String value) => !validator.isEmail(value.trim())
                ? 'Please enter a valid Email'
                : _formSave(),
            onSaved: (String value) =>
                createAccountForm.email = value.trim().toLowerCase(),
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            formKey: _registerKey,
            onSaved: (value) => createAccountForm.password = value,
          ),
          RoundedPasswordField(
            hintText: 'Repeat Password',
            formKey: _registerKey,
            validator: (String value) => value != createAccountForm.password
                ? "Password doesn't match"
                : null,
          ),
          LoadingButton(
              isLoading: widget.isLoading,
              child: RoundedButton(
                text: "Create Account",
                press: () {
                  if (_registerKey.currentState.validate()) {
                    _registerKey.currentState.save();
                    _registerWithEmailandPassword(
                        context,
                        createAccountForm.displayName,
                        createAccountForm.name,
                        createAccountForm.email,
                        createAccountForm.password);
                  }
                },
              )),
        ],
      )),
    );
  }

  Widget _buildSocialLogins(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocalIcon(
          key: RegisterScreen.facebookButtonKey,
          iconSrc: "assets/icons/social/facebook.svg",
          press: widget.isLoading ? null : () => _signInWithFacebook(context),
        ),
        SocalIcon(
          key: RegisterScreen.anonymousButtonKey,
          iconSrc: "assets/icons/social/twitter.svg",
          press: widget.isLoading ? null : () => _signInWithApple(context),
        ),
        SocalIcon(
          key: RegisterScreen.googleButtonKey,
          size: 30,
          iconSrc: "assets/icons/social/google-plus.svg",
          press: widget.isLoading ? null : () => _signInWithGoogle(context),
        ),
      ],
    ));
  }

  Widget _buildAlreadyHaveAccount(BuildContext context) {
    return (AlreadyHaveAnAccountCheck(
      login: false,
      press: () {
        Navigator.pushNamed(context, login);
      },
    ));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.05),
                  _buildCreateAccountForm(context),
                  SizedBox(height: size.height * 0.01),
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

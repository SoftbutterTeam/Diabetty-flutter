import 'package:diabetty/blocs/link_account_manager.dart';
import 'package:diabetty/blocs/sign_in_manager.dart';
import 'package:diabetty/constants/strings.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service/user.service.dart';
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
import 'package:diabetty/ui/screens/errors/drafterror.screen.dart';
import 'package:diabetty/ui/screens/loading/loading.screen.dart';
import 'package:validators/validators.dart' as validator;

import 'package:diabetty/ui/screens/auth_screens/login/components/or_divider.dart';
import 'package:diabetty/ui/screens/auth_screens/login/components/social_icon.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/welcome.screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LinkAccountBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);

    final appContext = Provider.of<AppContext>(context, listen: false);
    final User user = appContext.firebaseUser;

    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<LinkAccountManager>(
          create: (_) => LinkAccountManager(auth: auth, isLoading: isLoading),
          child: Consumer<LinkAccountManager>(
              builder: (_, LinkAccountManager manager, __) => FutureBuilder(
                  future: auth.isAccountLinkable(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      print('loading screen');
                      return LoadingScreen();
                    }
                    bool linkable = snapshot.data ?? false;
                    if (linkable == false || linkable == null) {
                      FutureBuilder(
                          future: auth.startAsNewUser(appContext),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return ErrorScreen();
                            }
                            return LoadingScreen();
                          });
                    }
                    return LinkAccountScreen._(
                        isLoading: isLoading.value,
                        manager: manager,
                        user: user,
                        linkable: linkable);
                  })),
        ),
      ),
    );
  }
}

class LinkAccountScreen extends StatefulWidget {
  @override
  LinkAccountScreen._(
      {Key key, this.isLoading, this.manager, this.user, this.linkable})
      : super(key: key);
  final LinkAccountManager manager;
  final bool isLoading;
  final User user;
  final bool linkable;
  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');
  static const Key emailLinkButtonKey = Key('email-link');
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  _LinkAccountScreenState createState() => _LinkAccountScreenState();
}

class _LinkAccountScreenState extends State<LinkAccountScreen> {
  EmailPasswordForm emailPasswordForm = EmailPasswordForm();
  final _linkKey = GlobalKey<FormState>();

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _linkAccount(
      BuildContext context, AppContext appContext, String password) async {
    try {
      await widget.manager.linkAccount(appContext, password);
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _startNewAccount(
      BuildContext context, AppContext appContext) async {
    try {
      await widget.manager.startNewAccount(appContext);
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: _body(context),
    );
  }

  Widget _buildLinkAccountForm(BuildContext context) {
    final appContext = Provider.of<AppContext>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _linkKey,
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text('Link to Existing Account ${widget.user.email}'),
          new RoundedPasswordField(
            onChanged: (value) {},
            formKey: _linkKey,
            isLoginForm: true,
            onSaved: (value) => emailPasswordForm.password = value,
          ),
          new LoadingButton(
              isLoading: widget.isLoading,
              child: RoundedButton(
                text: "Login",
                press: () {
                  if (_linkKey.currentState.validate()) {
                    _linkKey.currentState.save();
                    _linkAccount(
                        context, appContext, emailPasswordForm.password);
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

  Widget _buildCreateAccountButton(BuildContext context) {
    final appContext = Provider.of<AppContext>(context, listen: false);
    return (RoundedButton(
        text: "Start New",
        color: kPrimaryLightColor,
        textColor: Colors.black,
        press: () {
          _startNewAccount(context, appContext);
        }));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.15),
                if (widget.linkable) _buildLinkAccountForm(context),
                SizedBox(height: size.height * 0.02),
                OrDivider(),
                SizedBox(height: size.height * 0.1),
                _buildCreateAccountButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:diabetty/blocs/sign_in_manager.dart';
import 'package:diabetty/blocs/theraphy_manager.dart';
import 'package:diabetty/constants/strings.dart';
import 'package:diabetty/models/theraphy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/platform_widgets/platform_exception_alert_dialog.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/constants/keys.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/loading_button.dart';
import 'package:diabetty/ui/screens/others/auth_screens/form_models/email_password_form.model.dart';
import 'package:diabetty/ui/screens/others/auth_screens/login/components/background.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/already_have_an_account_acheck.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_button.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_input_field.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/rounded_password_field.dart';
import 'package:validators/validators.dart' as validator;

import 'package:diabetty/ui/screens/others/auth_screens/login/components/or_divider.dart';
import 'package:diabetty/ui/screens/others/auth_screens/login/components/social_icon.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TheraphyScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<TheraphyManager>(
          create: (_) =>
              TheraphyManager(appContext: appContext, isLoading: isLoading),
          child: Consumer<TheraphyManager>(
            builder: (_, TheraphyManager manager, __) =>
                TheraphyScreen._(isLoading: isLoading.value, manager: manager),
          ),
        ),
      ),
    );
  }
}

class TheraphyScreen extends StatefulWidget {
  @override
  const TheraphyScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final TheraphyManager manager;
  final bool isLoading;

  @override
  _TheraphyScreenState createState() => _TheraphyScreenState();
}

class _TheraphyScreenState extends State<TheraphyScreen> {
  EmailPasswordForm emailPasswordForm = EmailPasswordForm();
  final _loginKey = GlobalKey<FormState>();

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

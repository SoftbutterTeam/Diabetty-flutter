import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/newpages/screens/Login/login_screen.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/background.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/or_divider.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/social_icon.dart';
import 'package:diabetty/ui/screens/newpages/components/already_have_an_account_acheck.dart';
import 'package:diabetty/ui/screens/newpages/components/rounded_button.dart';
import 'package:diabetty/ui/screens/newpages/components/rounded_input_field.dart';
import 'package:diabetty/ui/screens/newpages/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: size.height * 0.03),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            ),
            SizedBox(height: size.height * 0.13),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
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

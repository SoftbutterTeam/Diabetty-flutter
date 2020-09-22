import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/rounded_button.dart';
import 'package:diabetty/ui/screens/auth_screens/login/login.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/register/register.screen.dart';
import 'package:diabetty/ui/screens/auth_screens/welcome/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Diabetty",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Get Started",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreenBuilder();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Login",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreenBuilder();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.20),
          ],
        ),
      ),
    );
  }
}

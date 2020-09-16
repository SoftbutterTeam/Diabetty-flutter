import 'package:diabetty/ui/screens/newpages/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/newpages/screens/Login/login_screen.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/signup_screen.dart';
import 'package:diabetty/ui/screens/newpages/screens/Welcome/components/background.dart';
import 'package:diabetty/ui/screens/newpages/components/rounded_button.dart';

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
            SvgPicture.asset(
              "assets/icons/chat.svg",
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
                      return SignUpScreen();
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
                      return LoginScreen();
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

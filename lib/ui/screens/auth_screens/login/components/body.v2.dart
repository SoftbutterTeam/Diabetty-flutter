import 'package:diabetty/ui/screens/auth_screens/fade_animation.widget.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/newpages/screens/Login/login_screen.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/background.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/or_divider.dart';
import 'package:diabetty/ui/screens/newpages/screens/Signup/components/social_icon.dart';
import 'package:flutter_svg/svg.dart';
/*
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 20),
              child: FadeAnimation(
                  1.4,
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Email or Phone number",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                isCollapsed: false,
                                suffix: GestureDetector(
                                    onTap: null,
                                    child: Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                      size: 20,
                                    )),
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  )),
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
                  iconSrc: "assets/icons/social/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/social/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  size: 30,
                  iconSrc: "assets/icons/social/google-plus.svg",
                  press: () {},
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
*/

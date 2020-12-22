import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                login
                    ? "Don’t have an Account ? "
                    : "Already have an Account ? ",
                style: TextStyle(color: kPrimaryColor, fontSize: 15),
              ),
              Text(
                login ? "Get Started" : "Log in",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}

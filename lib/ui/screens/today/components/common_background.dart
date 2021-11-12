import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/header.dart';

class CommonBackground extends StatelessWidget {
  final Widget child;
  final Widget header;

  const CommonBackground({Key key, @required this.child, @required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.orange[900], Colors.orange[600]])),
      height: size.height,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                child: header, preferredSize: Size.fromHeight(50)),
            body: Container(
              color: appWhite,
              child: Container(
                decoration: BoxDecoration(
                  color: extraLightBackgroundGray,
                  //NoDefaultCupertinoThemeData().scaffoldBackgroundColor, //t2_colorPrimaryLight, //maryLightColor
                  //   .withAlpha(220), //app_ba Colors.grey[50], appWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0), //was 20
                      topRight: Radius.circular(0)), // was 20
                ),
                child: child,
              ),
            )),
      ),
    );
  }
}

import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnoozeOptionsBackground extends StatelessWidget {
  final Widget child;
  final Widget header;
  const SnoozeOptionsBackground({Key key, @required this.child, this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: appWhite,
      child: Container(
        width: double.maxFinite,
        height: size.height,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  child: header, preferredSize: Size.fromHeight(60)),
              body: Container(
                decoration: BoxDecoration(
                  color: appWhite, //Colors.grey[50], appWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0), //was 20
                      topRight: Radius.circular(0)), // was 20
                ),
                child: child,
              )),
        ),
      ),
    );
  }
}

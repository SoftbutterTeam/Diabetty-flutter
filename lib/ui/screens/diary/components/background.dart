import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Widget header;
  const Background({Key key, @required this.child, this.header})
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
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                child: header ?? DiaryHeader(),
                preferredSize: Size.fromHeight(50)),
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
    );
  }
}

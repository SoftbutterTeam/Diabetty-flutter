import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/header.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
              child: DayPlanHeader(), preferredSize: Size.fromHeight(50)),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50], //Colors.grey[50], appWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: child,
          )),
    );
  }
}

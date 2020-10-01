import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/header.dart';

class Background extends StatelessWidget {
  final Widget child;
  final ValueNotifier<bool> isDropOpen;
  const Background({Key key, @required this.child, this.isDropOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange[900],
        Colors.orange[200],
        Colors.orange[600]
      ])),
      height: size.height,
      child: Column(
        children: [
          DayPlanHeader(isDropOpen: this.isDropOpen),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: child,
          )),
        ],
      ),
    );
  }
}

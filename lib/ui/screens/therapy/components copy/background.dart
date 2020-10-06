import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  const Background({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange[900],
        Colors.orange[200],
        Colors.orange[600]
      ])),
      height: size.height,

      // Here i can use size.width but use double.infinity because both work as a same
      child: Column(
        children: [
          Container(
            height: size.height * 0.11,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: onPressed,
                      color: Colors.transparent,
                      disabledTextColor: Colors.grey,
                      disabledColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      child: Align(
                        child: Icon(Icons.add, color: Colors.white),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 30),
                      child: subHeadingText("Therapy Planner", Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: child,
          )),
        ],
      ),
    );
  }
}

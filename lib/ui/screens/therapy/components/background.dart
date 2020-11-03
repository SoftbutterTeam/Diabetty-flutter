import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Function onPressed2;
  const Background({
    Key key,
    @required this.child,
    @required this.onPressed,
    @required this.onPressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.orange[900], Colors.orange[600]])),
      height: size.height,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: size.height * 0.105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: FlatButton(
                    onPressed: onPressed2,
                    padding: EdgeInsets.zero,
                    child: Align(
                      child: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 20.0,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: subHeadingText("Therapy Planner", Colors.white),
                ),
                Container(
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
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: child,
          )),
        ],
      ),
    );
  }
}

import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String leftButtonText;
  final String rightButtonText;
  final Function onLeftTap;
  final Function onRightTap;
  final String centerText;

  TopBar(
      {this.centerText,
      this.onLeftTap,
      this.leftButtonText,
      this.onRightTap,
      this.rightButtonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.orange[900], Colors.orange[600]]),
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Center(
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 1),
                    child: text(centerText, 
                        //  fontFamily: 'SfPro',
                        fontSize: textSizeMedium, textColor: Colors.white),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                child: Container(
                    // color: Colors.green,
                    padding: EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: () {},
                      disabledTextColor: Colors.grey,
                      disabledColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: onLeftTap,
                        child: Align(
                          child: text(leftButtonText,
                              fontSize: textSizeMedium2,
                              //fontFamily: 'Regular',
                              textColor: Colors.blue[900]),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    )),
              ),
              Positioned(
                right: 5,
                child: Container(
                  // color: Colors.blue,
                  padding: EdgeInsets.only(top: 5),
                  child: FlatButton(
                    onPressed: onRightTap,
                    color: Colors.transparent,
                    disabledTextColor: Colors.grey,
                    disabledColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Align(
                      child: text(rightButtonText,
                          fontSize: textSizeMedium2,
                          //fontFamily: 'Regular',
                          textColor: Colors.blue[900]),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

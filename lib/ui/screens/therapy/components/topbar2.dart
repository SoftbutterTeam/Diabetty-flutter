import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';

class TopBar2 extends StatefulWidget {
  final String leftButtonText;
  final String rightButtonText;
  final Function onLeftTap;
  final Function onRightTap;
  final String centerText;
  final Color color;
  final bool btnEnabled;

  TopBar2(
      {this.centerText,
      this.onLeftTap,
      this.leftButtonText,
      this.onRightTap,
      this.rightButtonText,
      this.color,
      this.btnEnabled});

  @override
  _TopBar2State createState() => _TopBar2State();
}

class _TopBar2State extends State<TopBar2> {
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
                    child: text(widget.centerText,
                        //  fontFamily: 'SfPro',
                        fontSize: textSizeMedium,
                        textColor: Colors.white),
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
                        onTap: widget.onLeftTap,
                        child: Align(
                          child: text(widget.leftButtonText,
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
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    disabledTextColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    textColor: widget.color,
                    onPressed: widget.onRightTap,
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Align(
                      child: text(widget.rightButtonText,
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

import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTimerPicker extends StatefulWidget {
  final double height;
  final double width;
  final Function onPressed;
  final CupertinoTimerPicker timerPicker;
  final String desciption;

  CustomTimerPicker(
      {this.onPressed,
      this.height,
      this.width,
      this.timerPicker,
      this.desciption});

  @override
  _CustomTimerPickerState createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: Container(
                      width: size.width,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          side: BorderSide(
                              width: 0.1,
                              color: Colors.deepOrange), //Colors.white
                        ),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                                horizontal: size.width * 0.05),
                            alignment: Alignment.center,
                            child: Text(
                              widget.desciption,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: textSizeLargeMedium - 3,
                                fontFamily: fontBold,
                                color: Colors.grey[700],
                              ),
                            )),
                      )),
                ))),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xff999999),
                width: 0.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              ),
              CupertinoButton(
                child: Text('Confirm'),
                onPressed: widget.onPressed,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              )
            ],
          ),
        ),
        Container(
          height: widget.height * 0.35,
          width: widget.width,
          color: Color(0xfff7f7f7),
          child: widget.timerPicker,
        ),
      ],
    );
  }
}

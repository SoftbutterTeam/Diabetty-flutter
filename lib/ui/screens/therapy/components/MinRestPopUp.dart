import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
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
                child: SizedBox(
                    // height: size.height * 0.15,
                    height: size.height * 0.12,
                    width: size.width,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),),
                        side: BorderSide(
                            width: 0.1,
                            color: Colors.deepOrange), //Colors.white
                      ),
                      // child: Container(
                      //   alignment: Alignment.center,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.info_outline,
                      //         size: size.height * 0.08,
                      //       ),
                      //       Text(
                      //         widget.desciption,
                      //         maxLines: 3,
                      //         textAlign: TextAlign.center,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Icon(
                                Icons.info_outline,
                                size: size.height * 0.03,
                              ),
                            ),
                            Flexible(
                                flex: 4,
                                child: text(widget.desciption,
                                    textColor: Colors.black87,
                                    fontSize: 13.0,
                                    maxLine: 3,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                    )))),
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

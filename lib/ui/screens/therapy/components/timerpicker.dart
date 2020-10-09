import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPicker extends StatefulWidget {
  final CupertinoDatePicker timepicker;
  final Function onConfirm;

  TimerPicker({this.timepicker, this.onConfirm});

  @override
  _TimerPickerState createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
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
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              ),
              CupertinoButton(
                child: Text('Confirm'),
                onPressed: widget.onConfirm,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
              )
            ],
          ),
        ),
        Container(
            height: size.height * 0.35,
            width: size.width,
            color: Color(0xfff7f7f7),
            child: widget.timepicker),
      ],
    );
  }
}

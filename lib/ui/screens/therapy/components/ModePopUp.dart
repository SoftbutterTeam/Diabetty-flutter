import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModePopUp extends StatefulWidget {
  final double height;
  final double width;
  final Function onPressed;
  final CupertinoPicker modePicker;

  ModePopUp({this.width, this.height, this.onPressed, this.modePicker});

  @override
  _ModePopUpState createState() => _ModePopUpState();
}

class _ModePopUpState extends State<ModePopUp> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
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
            child: widget.modePicker),
      ],
    );
  }
}

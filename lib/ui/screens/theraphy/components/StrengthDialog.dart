import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrengthDialog extends StatefulWidget {
  final double height;
  final double width;
  final TextEditingController strenghtController;
  final TextEditingController unitController;
  var strength;
  final Function onPressed;

  StrengthDialog(
      {this.height,
      this.width,
      this.strenghtController,
      this.unitController,
      this.strength,
      this.onPressed});

  @override
  _StrengthDialogState createState() => _StrengthDialogState();
}

class _StrengthDialogState extends State<StrengthDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: new Text("Strength & Units"),
      content: Container(
        margin: EdgeInsets.only(top: 20),
        height: widget.height * 0.12,
        width: widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: widget.width,
              margin: EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.only(bottom: 10),
              child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  controller: widget.strenghtController,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  placeholder: 'Strength...',
                  maxLines: 1,
                  maxLength: 30,
                  padding: EdgeInsets.only(
                      left: 16, top: 9.5, bottom: 9.5, right: 10),
                  style: TextStyle(
                      fontSize: textSizeLargeMedium - 1.5,
                      fontFamily: 'Regular')),
            ),
            Container(
              width: widget.width,
              padding: const EdgeInsets.only(bottom: 10),
              child: CupertinoTextField(
                  keyboardType: TextInputType.text,
                  controller: widget.unitController,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  placeholder: 'Units...',
                  maxLines: 1,
                  maxLength: 30,
                  padding: EdgeInsets.only(
                      left: 16, top: 9.5, bottom: 9.5, right: 10),
                  style: TextStyle(
                      fontSize: textSizeLargeMedium - 1.5,
                      fontFamily: 'Regular')),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: new Text("Save"),
          onPressed: widget.onPressed,
        )
      ],
    );
  }
}

import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';

class SnoozeOptionsHeader extends StatefulWidget {
  final String text;

  SnoozeOptionsHeader({this.text});

  @override
  _SnoozeOptionsHeaderState createState() => _SnoozeOptionsHeaderState();
}

class _SnoozeOptionsHeaderState extends State<SnoozeOptionsHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(left: 5),
                child: Align(
                  child: Icon(Icons.arrow_back_ios,
                      color: Colors.orange[800], size: 15),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: subHeadingText("", Colors.black87)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(right: 5),
                child: Align(
                  child: Text(widget.text,
                      style: TextStyle(
                          color: Colors.orange[800],
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400)),
                  alignment: Alignment.centerRight,
                ),
              ),
            )
          ],
        ));
  }
}

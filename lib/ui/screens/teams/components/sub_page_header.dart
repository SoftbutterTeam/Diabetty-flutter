import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';

class SubPageHeader extends StatefulWidget {
  final String text;
  final Function saveFunction;
  final Function backFunction;
  final Color iconColor;

  SubPageHeader({
    this.text,
    this.saveFunction,
    this.backFunction,
    this.iconColor,
  });

  @override
  _SubPageHeaderState createState() => _SubPageHeaderState();
}

class _SubPageHeaderState extends State<SubPageHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  widget.backFunction?.call();
                },
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(left: 0),
                child: Align(
                  child: Icon(Icons.arrow_back_ios,
                      color: widget.iconColor ?? Colors.orange[800], size: 15),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: subHeadingText("", Colors.white)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  widget.saveFunction?.call();
                },
                color: Colors.transparent,
                disabledTextColor: Colors.grey,
                disabledColor: Colors.transparent,
                padding: EdgeInsets.only(right: 5),
                child: Align(
                  child: Text(widget.text ?? '',
                      style: TextStyle(
                          color: widget.iconColor ?? Colors.orange[800],
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

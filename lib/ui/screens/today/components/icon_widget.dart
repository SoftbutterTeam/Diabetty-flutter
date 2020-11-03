import 'package:diabetty/models/reminder.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/extensions/string_extension.dart';

class IconWidget extends StatefulWidget {
  final String iconURL;
  final int index;
  final Reminder reminder;

  IconWidget({this.iconURL, this.index, this.reminder});

  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  var iconWidth;
  var iconHeight;
  @override
  Widget build(BuildContext context) {
    getIconSizes();
    return SizedBox(
      width: 40, //* was 35
      height: 40,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(60),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                widget.iconURL,
                color: widget.index.isOdd ? Colors.indigo[900] : null,
              ),
              Container(
                alignment: Alignment.topRight, // center bottom right
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[850], width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void getIconSizes() {
    /// if reminder is in the last 30minutes or next 30minutes and requires action
    /// -> should be larger
    /// but if () ->
    return;
  }
}

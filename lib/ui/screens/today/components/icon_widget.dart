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
      width: 37, //* was 35
      height: 37,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2, // was 2, 1 is good
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
                alignment: Alignment.topRight, // center bottom right   ------> this is the widget icon reminder thing you need to do.
                child: _buildActiveIcon(),
              ),
            ],
          )),
    );
  }

  Container _buildCompletedIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.greenAccent[700],
          border: Border.all(color: Colors.transparent, width: 1)),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

  Container _buildLateIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
          border: Border.all(color: Colors.transparent, width: 0.5)),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

   Container _buildSkippedIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
          border: Border.all(color: Colors.transparent, width: 0.5)),
      child: Center(
        child: Container(
          height: 1,
          width: 10,
          color: Colors.white,
        )
      ),
    );
  }

  Container _buildActiveIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
          border: Border.all(color: Colors.transparent, width: 0.5)),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

  Container _buildSnoozedIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: Icon(
          Icons.access_time,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

  Container _buildMissedIcon() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

  void getIconSizes() {
    /// if reminder is in the last 30minutes or next 30minutes and requires action
    /// -> should be larger
    /// but if () ->
    return;
  }
}

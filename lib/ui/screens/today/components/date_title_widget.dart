/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTitleWidget extends StatefulWidget {
  final double width;
  final DateTime date;
  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;
  final String locale;

  DateTitleWidget({
    @required this.date,
    @required this.monthTextStyle,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  _DateTitleWidgetState createState() => _DateTitleWidgetState();
}

class _DateTitleWidgetState extends State<DateTitleWidget>
    with AutomaticKeepAliveClientMixin {
  DayPlanManager manager;

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      child: Container(
        width: widget.width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: widget.selectionColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  new DateFormat("MMM", widget.locale)
                      .format(widget.date)
                      .toUpperCase(), // Month
                  style: widget.monthTextStyle),
              Text(widget.date.day.toString(), // Date
                  style: widget.dateTextStyle),
              Text(
                  new DateFormat("E", widget.locale)
                      .format(widget.date)
                      .toUpperCase(), // WeekDay
                  style: widget.dayTextStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (widget.onDateSelected != null) {
          // Call the onDateSelected Function
          widget.onDateSelected(this.widget.date);
        }
      },
    );
  }
}

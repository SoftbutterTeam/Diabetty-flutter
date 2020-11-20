import 'package:animated_button/animated_button.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/screens/today/dayplan.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/extensions/string_extension.dart';
import 'package:provider/provider.dart';

class RemIconWidget extends StatefulWidget {
  final String iconURL;
  final int index;
  final Reminder reminder;

  RemIconWidget({this.iconURL, this.index, this.reminder});

  @override
  _RemIconWidgetState createState() => _RemIconWidgetState();
}

class _RemIconWidgetState extends State<RemIconWidget> {
  var iconWidth;
  var iconHeight;
  @override
  Widget build(BuildContext context) {
    getIconSizes();
    DayPlanManager manager =
        Provider.of<DayPlanManager>(context, listen: false);
    return AnimatedScaleButton(
      size: 37,
      padding: 0,
      onTap: () {
        Scrollable.ensureVisible(manager
            .reminderScrollKeys[widget.reminder.reminderRuleId].currentContext);
      },
      child: SizedBox(
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
                  alignment: Alignment
                      .topRight, // center bottom right   ------> this is the widget icon reminder thing you need to do.
                  child: _buildRelevantIcon(),
                ),
              ],
            )),
      ),
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
      width: 18,
      height: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/navigation/checkbox/tick.svg',
          color: Colors.red, //Colors.white
          height: 15,
          width: 15,
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
      )),
    );
  }

  Tooltip _buildActiveIcon() {
    return Tooltip(
      message: 'This means its active',
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 2)),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/navigation/checkbox/tick.svg',
            color: Colors.greenAccent[700], //Colors.white
            height: 15,
            width: 15,
          ),
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

  Widget _buildRelevantIcon() {
    final reminder = widget.reminder;
    final complete = reminder.isComplete;
    final snoozed = reminder.isSnoozed;
    final missed = reminder.isMissed;
    final active = reminder.isActive;
    final skipped = reminder.isSkipped;
    final late = reminder.isLate;
    String error = "Reminder has encountered an error";
    print(reminder.window);

    if (complete) {
      return _buildCompletedIcon();
    } else if (skipped) {
      return _buildSkippedIcon();
    } else if (false) {
      return _buildMissedIcon();
    } else if (late) {
      return _buildLateIcon();
    } else if (snoozed) {
      return _buildSnoozedIcon();
    } else if (active) {
      return _buildActiveIcon();
    } else {
      return Tooltip(message: "Reminder has encountered an error");
    }
  }

  void getIconSizes() {
    /// if reminder is in the last 30minutes or next 30minutes and requires action
    /// -> should be larger
    /// but if () ->
    return;
  }
}

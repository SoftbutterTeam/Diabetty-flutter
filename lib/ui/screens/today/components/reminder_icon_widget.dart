import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/screens/today/dayplan.screen.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/extensions/string_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RemIconWidget extends StatefulWidget {
  final Reminder reminder;
  final double size;
  final bool extraFeatures;
  final Function func;
  final bool stateIcon;

  RemIconWidget(
      {this.extraFeatures = true,
      this.size = 37,
      this.stateIcon = true,
      this.func,
      this.reminder});

  @override
  _RemIconWidgetState createState() => _RemIconWidgetState();
}

class _RemIconWidgetState extends State<RemIconWidget> {
  var iconWidth;
  var iconHeight;

  @override
  Widget build(BuildContext context) {
    String iconURL = appearance_iconss[widget.reminder.appearance ?? 0];

    double size = widget.size;
    DayPlanManager manager =
        Provider.of<DayPlanManager>(context, listen: false);
    return AnimatedScaleButton(
      size: size,
      padding: 0,
      onTap: widget.func ??
          (widget.extraFeatures
              ? () {
                  if (manager
                          .reminderScrollKeys[widget.reminder.reminderRuleId] !=
                      null) {
                    Scrollable.ensureVisible(manager
                        .reminderScrollKeys[widget.reminder.reminderRuleId]
                        .currentContext);
                  }
                }
              : () => null),
      child: Tooltip(
        message: widget.extraFeatures
            ? (widget.reminder.rescheduledTime ?? widget.reminder.time)
                .formatTime()
            : widget.reminder.name,
        waitDuration: Duration(milliseconds: 0),
        showDuration: Duration(milliseconds: 3000),
        child: SizedBox(
          width: size, //* was 35
          height: size,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2, // was 2, 1 is good
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                  boxShadow: widget.extraFeatures && false
                      ? [
                          BoxShadow(
                              blurRadius: 0.7,
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.5)
                        ]
                      : null),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    iconURL,
                  ),
                  if (widget.stateIcon)
                    Container(
                      alignment: Alignment
                          .topRight, // center bottom right   ------> this is the widget icon reminder thing you need to do.
                      child: _buildRelevantIcon(),
                    ),
                ],
              )),
        ),
      ),
    );
  }

  Container _buildCompletedIcon() {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.greenAccent[700],
          border: Border.all(color: Colors.white, width: 1)),
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
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/navigation/checkbox/tick.svg',
          color: Colors.orange[900], //Colors.white
          height: 15,
          width: 15,
        ),
      ),
    );
  }

  Container _buildSkippedIcon() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/navigation/checkbox/tick.svg',
          color: Colors.white, //Colors.white
          height: 15,
          width: 15,
        ),
      ),
    );
  }

  Widget _buildActiveIcon() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/navigation/checkbox/tick.svg',
          color: Colors.greenAccent[700], //Colors.white
          height: 15,
          width: 15,
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
    ReminderStatus status = widget.reminder.status;
    // print(status.toString() + " ---h");
    switch (status) {
      case ReminderStatus.completed:
        return _buildCompletedIcon();
      case ReminderStatus.skipped:
        return _buildSkippedIcon();
      case ReminderStatus.missed:
        return _buildMissedIcon();
      case ReminderStatus.snoozed:
        return _buildSnoozedIcon();
      case ReminderStatus.active:
        return _buildActiveIcon();
      case ReminderStatus.isLate:
        return _buildLateIcon();
      case ReminderStatus.idle:
        return null;
      default:
        return null;
    }
  }
}

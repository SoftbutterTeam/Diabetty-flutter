import 'dart:async';
import 'dart:ui';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/animated_transform_rotate.dart';
import 'package:diabetty/ui/screens/today/components/reminder_card.widget.dart';
import 'package:diabetty/ui/screens/today/components/reminder_mini.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:diabetty/models/timeslot.model.dart' as Plan;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeSlot extends StatefulWidget {
  final Plan.TimeSlot timeSlot;
  final Key key;
  const TimeSlot({this.key, this.timeSlot}) : super(key: key);

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool minimize;
  bool allComplete;
  AnimationController rotationController;
  Timer _timer;
  @override
  void initState() {
    allComplete = widget.timeSlot.allComplete;
    minimize = allComplete;
    DayPlanManager manager =
        Provider.of<DayPlanManager>(context, listen: false);
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    widget.timeSlot.reminders.forEach((element) {
      manager.reminderScrollKeys.addAll({element.reminderRuleId: widget.key});
    });

    !minimize
        ? rotationController.forward(from: 1)
        : rotationController.reverse(from: 0.0);

    _timer = Timer.periodic(Duration(seconds: 50), (Timer t) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _toggleMinimize() {
    setState(() {
      minimize = !minimize;
      !minimize ? rotationController.forward() : rotationController.reverse();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    allComplete = widget.timeSlot.allComplete;

    DayPlanManager manager = Provider.of<DayPlanManager>(context, listen: true);

    super.build(context);
    String time = new DateFormat.jm()
        .format(DateTime.parse(widget.timeSlot.time.toString()));
    return Container(
      alignment: Alignment.topCenter,
      child: AnimatedSize(
          vsync: this,
          curve: Curves.bounceInOut,
          duration: Duration(milliseconds: 300),
          child: IntrinsicHeight(
            child: TimeSlotDecor(
              child: SizedBox(
                child: Column(children: <Widget>[
                  _buildTimeHeader(time),
                  Expanded(
                      child: !minimize
                          ? _buildReminderColumn()
                          : _buildMiniRemindersWrap())
                ]),
              ),
            ),
          )),
    );
  }

  Widget _buildTimeHeader(String time) {
    MaterialColor colorToFade = allComplete ? Colors.green : Colors.grey;
    double opacity = allComplete ? .3 : .1;
    return GestureDetector(
      onTap: () {
        _toggleMinimize();
      },
      child: Container(
          decoration: BoxDecoration(
              color: allComplete ? Colors.greenAccent : null,
              gradient: RadialGradient(
                //* could do without? or mix up blur
                radius: 5,
                tileMode: TileMode.mirror,
                focalRadius: 2,
                colors: [
                  Colors.white.withOpacity(.1),
                  colorToFade.shade200.withOpacity(opacity),
                  colorToFade.shade500.withOpacity(opacity),
                  //Colors.white.withOpacity(opacity),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // was 20  10
                topRight: Radius.circular(10),
              )),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 35),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 15, top: 2, right: 10),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: -0.5)
                            .animate(rotationController),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 0), //was 10
                    child: text(
                      time,
                      textColor: Colors.black87,
                      fontFamily: 'Regular',
                      fontSize: textSizeMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.only(right: 13.0, left: 12),
                        color: Colors.transparent,
                        child: Icon(
                          Icons.more_horiz,
                          size: 20,
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  GestureDetector _buildMiniRemindersWrap() {
    return GestureDetector(
      onTap: () {
        _toggleMinimize();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        color: Colors.transparent,
        child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: widget.timeSlot.reminders
                .map((e) => ReminderMiniCard(
                      reminder: e,
                    ))
                .cast<Widget>()
                .toList()),
      ),
    );
  }

  Widget _buildReminderColumn() {
    return Container(
      alignment: Alignment.topCenter,
      child: ColumnBuilder(
        itemCount: widget.timeSlot.reminders.length,
        itemBuilder: (context, index) {
          return ReminderCard(reminder: widget.timeSlot.reminders[index]);
        },
      ),
    );
  }
}

class TimeSlotDecor extends StatelessWidget {
  const TimeSlotDecor({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: child);
  }
}

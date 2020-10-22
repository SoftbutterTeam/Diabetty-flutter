import 'dart:ui';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/components/reminder_card.widget.dart';
import 'package:diabetty/ui/screens/today/components/reminder_mini.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:diabetty/models/timeslot.model.dart' as Plan;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

///TimeSlot v1.2
///Shadow is different. This time a double layer, to give a defining
///line to the top border of the widget. Allowing for a clearer
///shaded time header
class TimeSlot extends StatefulWidget {
  final Plan.TimeSlot timeSlot;

  const TimeSlot({Key key, this.timeSlot}) : super(key: key);

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool minimize;
  bool allComplete;
  @override
  void initState() {
    allComplete = widget.timeSlot.allComplete;
    minimize = allComplete;
    super.initState();
  }

  void _toggleMinimize() {
    setState(() {
      minimize = !minimize;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String time = new DateFormat.jm()
        .format(DateTime.parse(widget.timeSlot.time.toString()));
    return AnimatedSize(
        vsync: this,
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 300),
        child: IntrinsicHeight(
          child: SizedBox(
            child: TimeSlotDecor(
              child: Column(children: <Widget>[
                _buildTimeHeader(time),
                Expanded(
                    child: !minimize
                        ? _buildReminderColumn()
                        : _buildMiniRemindersWrap())
              ]),
            ),
          ),
        ));
  }

  Widget _buildTimeHeader(String time) {
    MaterialColor colorToFade = allComplete ? Colors.green : Colors.grey;
    double opacity = allComplete ? .3 : .1;
    return GestureDetector(
      onTap: () {
        _toggleMinimize();
      },
      onDoubleTap: () {
        _toggleMinimize();
      },
      child: Container(
          decoration: BoxDecoration(
              color: allComplete ? Colors.greenAccent : null,
              gradient: RadialGradient(
                // could do without? or mix up blur
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
                topLeft: Radius.circular(20), // was 20  10
                topRight: Radius.circular(20),
              )),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              alignment: Alignment.center,
              child: text(
                time,
                textColor: Colors.black87,
                fontFamily: 'Regular',
                fontSize: textSizeMedium,
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
      onDoubleTap: () {
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
    return GestureDetector(
        onDoubleTap: () {
          setState(() {
            minimize = !minimize;
          });
        },
        child: ColumnBuilder(
          itemCount: widget.timeSlot.reminders.length,
          itemBuilder: (context, index) {
            return ReminderCard(reminder: widget.timeSlot.reminders[index]);
          },
        ));
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
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, 0.5),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: child);
  }
}

import 'dart:math';
import 'dart:async';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/reminder_icon_widget.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/ui/screens/today/components/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:flutter_svg/svg.dart';

class CirclePlan extends StatefulWidget {
  final DayPlanManager manager;
  final bool circleMinimized;
  final Animation<double> minAnimationRotate;
  final double heightOfCircleSpace;
  const CirclePlan(
      {Key key,
      this.manager,
      this.circleMinimized,
      this.minAnimationRotate,
      this.heightOfCircleSpace})
      : super(key: key);

  @override
  _CirclePlanState createState() => _CirclePlanState();
}

class _CirclePlanState extends State<CirclePlan> {
  Animation<double> _minAnimationRotate;
  TimeOfDay _initialTime = TimeOfDay(hour: 0, minute: 0);
  double initialAngle;
  double progressAngle;
  bool circleMinimized;
  Timer _everysecond;

  TimeOfDay get initialTime => manager.choosenTime ?? _initialTime;
  /* get choosenTime {
    if (manager.choosenTime == null)
    return _initialTime;
    else if (manager.choosenTime == )*/

  DateTime get initalDateTime =>
      widget.manager.currentDateStamp.applyTimeOfDay(initialTime);
  DateTime get endDateTime => initalDateTime.add(Duration(hours: 12));
  double dragSensitivity = 3;

  DayPlanManager get manager => widget.manager;

  void setStateFunc(AnimationStatus status) {
    setState(() {});
  }

  @override
  void initState() {
    _minAnimationRotate = widget.minAnimationRotate;
    circleMinimized = widget.circleMinimized;

    manager.minController.addStatusListener(setStateFunc);
    manager.fadeAnimation.addStatusListener(setStateFunc);
    _everysecond = Timer.periodic(Duration(minutes: 2), (Timer t) {
      setState(() {});
    });

    print('newwoo');
    super.initState();
  }

  @override
  void dispose() {
    _everysecond?.cancel();
    manager.minController.removeStatusListener(setStateFunc);
    manager.fadeAnimation.removeStatusListener(setStateFunc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: _buildCirclePlan(context));
  }

  Widget _buildCirclePlan(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Reminder> reminders = List.of(manager.getFinalRemindersList());
    //print('remidners length ' + reminders.length.toString());
    calcTimeFrames();
    setUpCirclesAngles();
    print(size.width * 0.65);
    double circleWidth = size.width * 0.65;
    double completePercent = calcProgressTime();
    double innerCompletePercent = calcProgressTime(
        TimeOfDay(hour: 0, minute: 0),
        initialTime.hour != 6 ? initialTime : null); //initialTime
    return Container(
        height: widget.heightOfCircleSpace,
        alignment: Alignment.center,
        width: circleWidth,
        child: CircleList(
          origin: Offset(0, 0),
          innerRadius: min(circleWidth, widget.heightOfCircleSpace) / 2 - 30,
          outerRadius: min(circleWidth, widget.heightOfCircleSpace) / 2,
          spinFactor: _minAnimationRotate,
          initialAngle: initialAngle,
          progressAngle: progressAngle,
          showInitialAnimation: true,
          innerCircleRotateWithChildren: true,
          rotateMode: RotateMode.stopRotate,
          progressColor: Colors.orangeAccent,
          progressCompletion: completePercent,
          innerProgressCompletion: innerCompletePercent,
          centerWidget: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            height: double.maxFinite,
            width: double.maxFinite,
            child: new CustomPaint(
                foregroundPainter: new MyPainter(
                    completeColor: Colors.orangeAccent,
                    completePercent: 0, //innerCompletePercent,
                    //? styl1 : can try toggle the limit (_initalTime) for different but still accurate representation
                    width: 1.0),
                child: GestureDetector(
                    onTap: (manager.minController.status ==
                            AnimationStatus.dismissed)
                        ? () {
                            manager.fadeAnimation.reverse(from: 1);
                          }
                        : null,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '', // '1:02 PM',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepOrange[900], fontSize: 14),
                            semanticsLabel: 'the time represented by the clock',
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: manager.minController.isCompleted ? 0 : 1,
                          duration: Duration(milliseconds: 100),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(30),
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  initalDateTime.formatTime2() +
                                      ' ' +
                                      ' - ' +
                                      ' ' +
                                      endDateTime
                                          .formatTime2(), // ' midnight - noon '
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.deepOrange[900],
                                      fontSize: 14),
                                  semanticsLabel:
                                      'the time represented by the clock',
                                ),
                                Text('reminders',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          children: List.generate(12 * 4, (index) {
            final rems = getReminderOnIndex(index, reminders);
            return rems.isNotEmpty
                ? RemIconWidget(
                    reminder: getMostImportantRem(rems),
                  )
                : SizedBox.shrink();
          }),
        ));
  }

  List<Reminder> getReminderOnIndex(int index, List<Reminder> reminders) {
    DateTime indexTime = initalDateTime.add(Duration(minutes: index * 15));
    List<Reminder> results = [];
    //print(indexTime);
    reminders.forEach((reminder) {
      if (reminder.time.roundToNearest(15).compareTo(indexTime) == 0)
        results.add(reminder);
    });
    //print(results);
    return results;
  }

  void setUpCirclesAngles() {
    if (initialTime.hour == 0) {
      initialAngle = -(pi / 2);
      progressAngle = 0;
    } else if (initialTime.hour == 6) {
      initialAngle = (pi / 2);
      progressAngle = (pi);
    } else if (initialTime.hour == 12) {
      initialAngle = -(pi / 2);
      progressAngle = 0;
    }
  }

  void calcTimeFrames() {
    if (hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.getFinalRemindersList()) &&
        !hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 24, minute: 0)),
            manager.getFinalRemindersList())) {
      _initialTime = TimeOfDay(hour: 0, minute: 0);
    } else if (!hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.getFinalRemindersList()) &&
        hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 24, minute: 0)),
            manager.getFinalRemindersList())) {
      _initialTime = TimeOfDay(hour: 12, minute: 0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 6, minute: 0))) <
            0 &&
        hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 6, minute: 0)),
            manager.getFinalRemindersList())) {
      _initialTime = TimeOfDay(hour: 0, minute: 0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0))) <
            0 &&
        hasNotTakenReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 6, minute: 0)),
            manager.getFinalRemindersList())) {
      //print("0yyy");
      _initialTime = TimeOfDay(hour: 0, minute: 0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0))) <
            0 &&
        hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.getFinalRemindersList())) {
      //print("12aaa");
      _initialTime = TimeOfDay(hour: 6, minute: 0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 18, minute: 0))) <
            0 &&
        hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 6, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.getFinalRemindersList()) &&
        !hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 18, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 24, minute: 0)),
            manager.getFinalRemindersList())) {
      //print("18aaa0");
      _initialTime = TimeOfDay(hour: 6, minute: 0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
            .applyTimeOfDay(TimeOfDay(hour: 18, minute: 0))) <
        0) {
      //print("18aaa");
      _initialTime = TimeOfDay(hour: 12, minute: 0);
    } else {
      //print("18aaa2");
      _initialTime = TimeOfDay(hour: 12, minute: 0);
    }
    manager.initalTime = _initialTime;
  }

  double calcProgressTime([TimeOfDay timeOfDay, TimeOfDay limit]) {
    DateTime firstTime = timeOfDay == null
        ? initalDateTime
        : DateTime.now().applyTimeOfDay(timeOfDay);
    if (DateTime.now().compareTo(firstTime) <= 0) return 0;
    //print(timeOfDay);
    //print(limit);

    if (limit != null &&
        DateTime.now().applyTimeOfDay(limit).compareTo(
                manager.currentDateStamp.applyTimeOfDay(timeOfDay)) <=
            0) {
      print('hokakkkkk');
      return 0;
    }
    DateTime percTimeLimit = DateTime.now();
    if (limit != null) {
      //print('yooo');
      if (DateTime.now()
              .compareTo(manager.currentDateStamp.applyTimeOfDay(limit)) >
          0) {
        percTimeLimit = DateTime.now().applyTimeOfDay(limit);
      }
      //print("perclimit");
      //print(percTimeLimit.toIso8601String());
    }
    //print(firstTime.toIso8601String());
    final double perc = (percTimeLimit.difference(firstTime).inMinutes /
            Duration(hours: 12).inMinutes) *
        100;
    //print("hella");
    //print(perc);
    return perc <= 100 ? perc : 100;
  }

  bool hasNotTakenReminderBetween(
      DateTime firstTime, DateTime lastTime, List<Reminder> reminders) {
    return (reminders.any((element) =>
        element.time.compareTo(firstTime) >= 0 &&
        element.time.compareTo(lastTime) < 0 &&
        element.takenAt == null));
  }

  bool hasReminderBetween(
      DateTime firstTime, lastTime, List<Reminder> reminders) {
    return (reminders.any((element) =>
        element.time.compareTo(firstTime) >= 0 &&
        element.time.compareTo(lastTime) < 0));
  }
}

Reminder getMostImportantRem(List<Reminder> reminders) {
  return reminders.firstWhere(
          (element) => element.status == ReminderStatus.isLate,
          orElse: () => null) ??
      reminders.firstWhere((element) => element.status == ReminderStatus.active,
          orElse: () => null) ??
      reminders.firstWhere((element) => element.status == ReminderStatus.missed,
          orElse: () => null) ??
      reminders.firstWhere(
          (element) => element.status == ReminderStatus.snoozed,
          orElse: () => null) ??
      reminders.firstWhere((element) => element.status == ReminderStatus.idle,
          orElse: () => null) ??
      reminders.firstWhere((element) => element.status == ReminderStatus.missed,
          orElse: () => null) ??
      reminders.firstWhere(
          (element) => element.status == ReminderStatus.skipped,
          orElse: () => null) ??
      reminders.firstWhere(
          (element) => element.status == ReminderStatus.completed,
          orElse: () => null);
}

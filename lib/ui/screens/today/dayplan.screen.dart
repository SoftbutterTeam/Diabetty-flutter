import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/today/components/circle_list.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
//*swtich versions. animation differences*/
    as SlotWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'components/icon_widget.dart';

class DayPlanScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (_) => ValueNotifier<bool>(false),
        child: Consumer<ValueNotifier<bool>>(
          builder: (_, ValueNotifier<bool> isLoading, __) =>
              Consumer<TherapyManager>(
            builder: (_, TherapyManager therapyManager, __) =>
                Consumer<DayPlanManager>(
              builder: (_, DayPlanManager manager, __) {
                manager.therapyManager = therapyManager;
                return DayPlanScreen._(
                  isLoading: isLoading.value,
                  manager: manager,
                );
              },
            ),
          ),
        ));
  }
}

class DayPlanScreen extends StatefulWidget {
  @override
  const DayPlanScreen._({
    Key key,
    this.isLoading,
    this.manager,
  }) : super(key: key);
  final DayPlanManager manager;
  final bool isLoading;

  @override
  _DayPlanScreenState createState() => _DayPlanScreenState(manager);
}

class _DayPlanScreenState extends State<DayPlanScreen>
    with TickerProviderStateMixin {
  DayPlanManager manager;

  AnimationController _minController;

  Animation<double> _minAnimationRotate;
  _DayPlanScreenState(this.manager);

  AnimationController _dateController;
  Animation _animation;

  TimeOfDay _initialTime = TimeOfDay(hour: 0, minute: 0);
  double initialAngle;
  double progressAngle;
  bool circleMinimized;
  DateTime get initalDateTime =>
      manager.currentDateStamp.applyTimeOfDay(_initialTime);
  DateTime get endDateTime => initalDateTime.add(Duration(hours: 12));
  double dragSensitivity = 3;
  @override
  void initState() {
    super.initState();
    _dateController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 0.173).animate(_dateController);
    manager.pushAnimation = _dateController;
    circleMinimized = false;
    _minController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _minAnimationRotate =
        Tween<double>(begin: 0, end: 1).animate(_minController);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    print(_minAnimationRotate.value.toString() + "ds");
    Size size = MediaQuery.of(context).size;
    double heightOfCircleSpace = size.height * 0.35;
    return Background(
      child: StreamBuilder(
          stream: manager.dataStream, // manager.remindersbyDayDataStream,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AnimatedBox(
                    animation: _animation, shouldAnim: !circleMinimized),
                AnimatedSize(
                  duration: Duration(milliseconds: 600),
                  vsync: this,
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > dragSensitivity) {
                        if (circleMinimized) {
                          setState(() {
                            _minController.reverse();
                            circleMinimized = false;
                          });
                        }
                      } else if (details.delta.dy < -dragSensitivity) {
                        if (!circleMinimized) {
                          setState(() {
                            _minController.forward();
                            circleMinimized = true;
                          });
                        }
                      }
                    },
                    onDoubleTap: () {
                      if (circleMinimized) {
                        setState(() {
                          _minController.reverse();
                          circleMinimized = false;
                        });
                      } else {
                        setState(() {
                          _minController.forward();
                          circleMinimized = true;
                        });
                      }
                    },
                    child: SizedBox(
                        width: size.width,
                        height:
                            heightOfCircleSpace / (circleMinimized ? 2.8 : 1),
                        // 2.8
                        child: FittedBox(
                          alignment: circleMinimized
                              ? Alignment.topCenter
                              : Alignment.center,
                          fit: circleMinimized ? BoxFit.none : BoxFit.contain,
                          child: Container(
                              alignment: Alignment.center,
                              child: _buildCirclePlan(context, snapshot)),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, -1),
                          ),
                        ],
                        border: Border(
                            top: BorderSide(
                                color: (circleMinimized
                                    ? Colors.orangeAccent
                                    : Colors.transparent),
                                width: 1))),
                    child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: _buildRemindersList(context, snapshot)),
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget _buildRemindersList(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (widget.isLoading)
      return LoadingScreen();
    else if (snapshot.hasError) return ErrorScreen();

    List<TimeSlot> timeSlots = manager.sortRemindersByTimeSlots();

    if (timeSlots.length == 0) return SizedBox();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ColumnBuilder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SlotWidget.TimeSlot(timeSlot: timeSlots[index]));
        },
      ),
    );
  }

  Widget _buildCirclePlan(BuildContext context, AsyncSnapshot snapshot) {
    var size = MediaQuery.of(context).size;
    List<Reminder> reminders = List.from(manager.getFinalRemindersList());
    print('remidners length ' + reminders.length.toString());
    calcTimeFrames();
    return Container(
        // padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: size.width,
        child: CircleList(
          origin: Offset(0, 0),
          innerRadius: 100,
          outerRadius: 130,
          spinFactor: _minAnimationRotate,
          initialAngle: initialAngle,
          progressAngle: progressAngle,
          showInitialAnimation: true,
          innerCircleRotateWithChildren: true,
          rotateMode: RotateMode.stopRotate,
          progressColor: Colors.orangeAccent,
          progressCompletion: calcProgressTime(),
          centerWidget: new Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              height: double.maxFinite,
              width: double.maxFinite,
              child: new CustomPaint(
                  foregroundPainter: new MyPainter(
                      completeColor: Colors.orangeAccent,
                      completePercent: calcProgressTime(
                        TimeOfDay(hour: 0, minute: 0),
                        _initialTime,
                      ),
                      //? styl1 : can try toggle the limit (_initalTime) for different but still accurate representation
                      width: 1.0),
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      height: double.maxFinite,
                      width: double.maxFinite))),
          children: List.generate(12 * 4, (index) {
            final rems = getReminderOnIndex(index, reminders);
            return rems.isNotEmpty
                ? IconWidget(
                    index: index,
                    iconURL: appearance_icon_0,
                    reminder: rems[0],
                  )
                : SizedBox.shrink();
          }),
        ));
  }

  List<Reminder> getReminderOnIndex(int index, List<Reminder> reminders) {
    DateTime indexTime = initalDateTime.add(Duration(minutes: index * 15));
    List<Reminder> results = [];
    print(indexTime);
    reminders.forEach((reminder) {
      if (reminder.time.roundToNearest(15).compareTo(indexTime) == 0)
        results.add(reminder);
    });
    print(results);
    return results;
  }

  Widget build(BuildContext context) {
    return _body(context);
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
      initialAngle = -(pi / 2);
      progressAngle = 0;
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
      initialAngle = -(pi / 2);
      progressAngle = 0;
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
      initialAngle = -(pi / 2);
      progressAngle = 0;
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0))) <
            0 &&
        hasNotTakenReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 6, minute: 0)),
            manager.getFinalRemindersList())) {
      print("0yyy");
      _initialTime = TimeOfDay(hour: 0, minute: 0);
      initialAngle = -(pi / 2);
      progressAngle = (0);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0))) <
            0 &&
        hasReminderBetween(
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 0, minute: 0)),
            manager.currentDateStamp
                .applyTimeOfDay(TimeOfDay(hour: 12, minute: 0)),
            manager.getFinalRemindersList())) {
      print("12aaa");
      _initialTime = TimeOfDay(hour: 6, minute: 0);
      initialAngle = (pi / 2);
      progressAngle = (pi);
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
      print("18aaa0");
      _initialTime = TimeOfDay(hour: 6, minute: 0);
      initialAngle = (pi / 2);
      progressAngle = (pi);
    } else if (DateTime.now().compareTo(manager.currentDateStamp
            .applyTimeOfDay(TimeOfDay(hour: 18, minute: 0))) <
        0) {
      print("18aaa");
      _initialTime = TimeOfDay(hour: 12, minute: 0);
      initialAngle = -(pi / 2);
      progressAngle = 0;
    } else {
      print("18aaa2");
      _initialTime = TimeOfDay(hour: 12, minute: 0);
      initialAngle = -(pi / 2);
      progressAngle = 0;
    }
  }

  double calcProgressTime([TimeOfDay timeOfDay, TimeOfDay limit]) {
    if (DateTime.now().compareTo(initalDateTime) <= 0) return 0;
    print(timeOfDay);
    print(limit);
    DateTime firstTime = timeOfDay == null
        ? initalDateTime
        : DateTime.now().applyTimeOfDay(timeOfDay);
    if (limit != null &&
        DateTime.now().applyTimeOfDay(limit).compareTo(
                manager.currentDateStamp.applyTimeOfDay(timeOfDay)) <=
            0) {
      return 0;
    }
    DateTime percTimeLimit = DateTime.now();
    if (limit != null) {
      print('yooo');
      if (DateTime.now()
              .compareTo(manager.currentDateStamp.applyTimeOfDay(limit)) >
          0) {
        percTimeLimit = DateTime.now().applyTimeOfDay(limit);
      }
      print("perclimit");
      print(percTimeLimit.toIso8601String());
    }
    print(firstTime.toIso8601String());
    final double perc = (percTimeLimit.difference(firstTime).inMinutes /
            Duration(hours: 12).inMinutes) *
        100;
    print("hella");
    print(perc);
    return perc <= 100 ? perc : 100;
  }
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

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
    with SingleTickerProviderStateMixin {
  DayPlanManager manager;
  _DayPlanScreenState(this.manager);

  AnimationController _dateController;
  Animation _animation;

  TimeOfDay _initialTime = TimeOfDay(hour: 0, minute: 0);
  double initialAngle;
  double progressAngle;
  DateTime get initalTime =>
      manager.currentDateStamp.applyTimeOfDay(_initialTime);
  DateTime get endTime => initalTime.add(Duration(hours: 12));

  @override
  void initState() {
    super.initState();
    _dateController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 0.165).animate(_dateController);

    manager.pushAnimation = _dateController;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: StreamBuilder(
          stream: manager.dataStream, // manager.remindersbyDayDataStream,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                if (true)
                  AnimatedBox(
                    animation: _animation,
                  ),
                SizedBox(
                    height: size.height * 0.35, //was 0.35
                    child: _buildCirclePlan(context, snapshot) // was 0.35
                    ),
                if (true)
                  Expanded(child: _buildRemindersList(context, snapshot)),
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

    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: timeSlots.length,
          shrinkWrap: true, //recently changed to true
          padding: EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(top: 10),
                child: SlotWidget.TimeSlot(timeSlot: timeSlots[index]));
          }),
    );
  }

  Widget _buildCirclePlan(BuildContext context, AsyncSnapshot snapshot) {
    var size = MediaQuery.of(context).size;
    List<Reminder> reminders = List.from(manager.getFinalRemindersList());
    print('remidners length ' + reminders.length.toString());
    calcTimeFrames();
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            width: size.width,
            child: Center(
              child: CircleList(
                origin: Offset(0, 0),
                innerRadius: 100,
                outerRadius: 130,
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
                                        TimeOfDay(hour: 12, minute: 0)) >
                                    0
                                ? calcProgressTime(
                                    TimeOfDay(hour: 0, minute: 0))
                                : 0,
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
              ),
            )),
      ],
    );
  }

  List<Reminder> getReminderOnIndex(int index, List<Reminder> reminders) {
    DateTime indexTime = initalTime.add(Duration(minutes: index * 15));
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

  double calcProgressTime([TimeOfDay timeOfDay]) {
    if (DateTime.now().compareTo(initalTime) <= 0) return 0;

    DateTime lastTime = timeOfDay == null
        ? initalTime
        : DateTime.now().applyTimeOfDay(timeOfDay);

    final double perc = (DateTime.now().difference(lastTime).inMinutes /
            Duration(hours: 12).inMinutes) *
        100;
    print("hella");
    print(perc);
    return perc <= 100 ? perc : 100;
  }
}

bool hasReminderBetween(
    DateTime firstTime, lastTime, List<Reminder> reminders) {
  return (reminders.any((element) =>
      element.time.compareTo(firstTime) >= 0 &&
      element.time.compareTo(lastTime) < 0));
}

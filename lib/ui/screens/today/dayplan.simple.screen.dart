import 'package:diabetty/blocs/dayplan_manager.dart';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'dart:async';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/common_background.dart';
import 'package:diabetty/ui/screens/today/components/header.dart';
// import 'package:calendar_strip/calendar_strip.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
//*swtich versions. animation differences*/
    as SlotWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

class DayPlanScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
          builder: (_, ValueNotifier<bool> isLoading, __) =>
              Consumer<TherapyManager>(
                builder: (_, TherapyManager therapyManager, __) {
                  DayPlanManager dayPlanManager =
                      Provider.of<DayPlanManager>(context, listen: false);
                  dayPlanManager.therapyManager = therapyManager;
                  return DayPlanScreen._(
                    isLoading: isLoading.value,
                    manager: dayPlanManager,
                  );
                },
              )),
    );
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
  _DayPlanScreenState createState() => _DayPlanScreenState();
}

class _DayPlanScreenState extends State<DayPlanScreen>
    with TickerProviderStateMixin {
  DayPlanManager manager;

  AnimationController _minController;

  Animation<double> _minAnimationRotate;
  _DayPlanScreenState();

  AnimationController _dateController;
  Animation _animation;

  TimeOfDay _initialTime = TimeOfDay(hour: 0, minute: 0);
  double initialAngle;
  double progressAngle;
  bool circleMinimized;
  bool show;
  DateTime get initalDateTime =>
      manager.currentDateStamp.applyTimeOfDay(_initialTime);
  DateTime get endDateTime => initalDateTime.add(Duration(hours: 12));
  double dragSensitivity = 3;
  bool draggingIdle;
  StreamSubscription _subscription;
  List<TimeSlot> timeSlots;
  @override
  void initState() {
    timeSlots = List();
    draggingIdle = true;
    manager = Provider.of<DayPlanManager>(context, listen: false);
    manager.reminderScrollKeys = {};
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
    manager.minController = _minController;

    _subscription = manager.reminderStream.listen((event) {
      if (timeSlots == null) return;
      bool cond = timeSlots.any((element) => !element.reminders.every((el) =>
          element.time.isAtSameMomentAs(el.rescheduledTime ?? el.time)));
      if (cond) {
        setState(() {});
      }
    });

    manager.dayScreenSetState = setStateFunc;
    /*manager.dateChanges?.stream?.listen((event) {
      setState(() {});
    });*/
    List<Reminder> reminders = manager.getFinalRemindersList();
    String id;
    // print(reminders.length);
    if (reminders.isNotEmpty) {
      id = reminders
          .firstWhere(
              (element) =>
                  !element.isComplete &&
                  !element.isDeleted &&
                  !element.isSkipped &&
                  !element.isMissed,
              orElse: () => reminders.first)
          ?.id;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => () {
          manager.fadeAnimation?.addStatusListener(setStateFunc);
          if (id != null && manager.reminderScrollKeys[id] != null) {
            Scrollable.ensureVisible(
                manager.reminderScrollKeys[id].currentContext,
                duration: Duration(milliseconds: 500));
          }
        });
    show = true;
    super.initState();
  }

  void setStateFunc([AnimationStatus status]) {
    setState(() {});
  }

  @override
  void dispose() {
    _dateController?.dispose();
    _minController?.dispose();
    _subscription?.cancel();
    manager.fadeAnimation?.removeStatusListener(setStateFunc);
    //manager.fadeAnimation?.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CommonBackground(
        header: DayPlanHeader(),
        child: (manager.getFinalRemindersList().isEmpty)
            ? Container(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: text("No reminders for today!"),
                    ),
                    SvgPicture.asset(
                      'assets/images/empty_today.svg',
                      height: 250,
                      width: 300,
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBox(animation: _animation, shouldAnim: true),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: _buildRemindersList(context)),
                    ),
                  )
                ],
              ));
  }

  Widget _buildRemindersList(BuildContext context) {
    timeSlots = manager.sortRemindersByTimeSlots() ?? List();

    if (timeSlots.length == 0) return Container();
    var size = MediaQuery.of(context).size;
    return Scrollbar(
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 10),
        scrollDirection: Axis.vertical,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SlotWidget.TimeSlot(
                  key: new GlobalKey(), timeSlot: timeSlots[index]));
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return _body(context);
  }
}

import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'dart:async';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
//*swtich versions. animation differences*/
    as SlotWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/extensions/datetime_extension.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'components/reminder_icon_widget.dart';

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
  bool show;
  DateTime get initalDateTime =>
      manager.currentDateStamp.applyTimeOfDay(_initialTime);
  DateTime get endDateTime => initalDateTime.add(Duration(hours: 12));
  double dragSensitivity = 3;
  bool draggingIdle;
  StreamSubscription _subscription;
  @override
  void initState() {
    draggingIdle = true;

    manager.reminderScrollKeys = {};
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
    manager.minController = _minController;
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => manager.fadeAnimation?.addStatusListener(setStateFunc));
    manager.pushAnimation?.addListener(() {
      setState(() {});
    });

    show = true;
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
    //print(_minAnimationRotate.value.toString() + "ds");

    Size size = MediaQuery.of(context).size;
    double heightOfCircleSpace = size.height * 0.35;
    return Background(
      child: Builder(builder: (context) {
        if (manager.getFinalRemindersList().isEmpty) {
          return Container(
            child: Text('no reminders'),
            alignment: Alignment.center,
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AnimatedBox(animation: _animation, shouldAnim: !circleMinimized),
            if (false)
              Container(
                  color: Colors.white,
                  child: CalendarStrip(
                    startDate: DateTime.now().subtract(Duration(days: 14)),
                    endDate: DateTime.now().add(Duration(days: 8)),
                    onDateSelected: () {},
                    onWeekSelected: () {},
                    dateTileBuilder: null,
                    iconColor: Colors.black87,
                    monthNameWidget: null,
                    markedDates: [],
                    selectedDate: DateTime.now(),
                    addSwipeGesture: true,
                    containerDecoration: BoxDecoration(color: Colors.white),
                  )),
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
                                ? Colors.transparent //deepOrange
                                : Colors.transparent),
                            width: 1))),
                child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: _buildRemindersList(context)),
              ),
            )
          ],
        );
      }),
    );
  }

  //! onDoubleTap slows down a onTap

  Widget _buildRemindersList(BuildContext context) {
    List<TimeSlot> timeSlots = manager.sortRemindersByTimeSlots();
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: true);
    if (timeSlots.length == 0) return Container();
    var size = MediaQuery.of(context).size;
    return Scrollbar(
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
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

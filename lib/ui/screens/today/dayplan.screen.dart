import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/today/components/circle_list.dart';
import 'package:diabetty/ui/screens/today/components/circle_plan.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
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
    manager.minController = _minController;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    //print(_minAnimationRotate.value.toString() + "ds");
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
                _buildCirclePlanOverlay(
                  size,
                  heightOfCircleSpace,
                  child: CirclePlan(
                    manager: manager,
                    heightOfCircleSpace: heightOfCircleSpace,
                    circleMinimized: circleMinimized,
                    minAnimationRotate: _minAnimationRotate,
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

  AnimatedSize _buildCirclePlanOverlay(Size size, double heightOfCircleSpace,
      {CirclePlan child}) {
    return AnimatedSize(
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
                manager.fadeAnimation.reset();
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
              manager.fadeAnimation.reset();
            });
          }
        },
        child: SizedBox(
            width: size.width,
            height: heightOfCircleSpace / (circleMinimized ? 2.8 : 1),
            // 2.8

            child: CirclePlanOverlay(
              child: FittedBox(
                  alignment:
                      circleMinimized ? Alignment.topCenter : Alignment.center,
                  fit: circleMinimized ? BoxFit.none : BoxFit.scaleDown,
                  child: child),
            )),
      ),
    );
  }

  Widget _buildRemindersList(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (widget.isLoading)
      return LoadingScreen();
    else if (snapshot.hasError) return Container();

    List<TimeSlot> timeSlots = manager.sortRemindersByTimeSlots();

    if (timeSlots.length == 0) return Container();

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

  Widget build(BuildContext context) {
    return _body(context);
  }
}

class CirclePlanOverlay extends StatefulWidget {
  const CirclePlanOverlay({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  _CirclePlanOverlayState createState() => _CirclePlanOverlayState();
}

class _CirclePlanOverlayState extends State<CirclePlanOverlay>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<bool> fadeAnim;
  DayPlanManager manager;
  @override
  void initState() {
    manager = Provider.of<DayPlanManager>(context, listen: false);
    fadeController = AnimationController(
        vsync: this,
        reverseDuration: Duration(seconds: 4),
        duration: Duration(milliseconds: 100));
    fadeAnim = Tween<bool>(begin: false, end: true).animate(fadeController);
    fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) setState(() {});
    });
    manager.fadeAnimation = fadeController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            width: 50,
            alignment: Alignment.centerRight,
            child: RotatedBox(
              quarterTurns: 2,
              child: AnimatedOpacity(
                opacity: fadeAnim.value != true ? 0 : 1,
                duration: Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  'assets/icons/navigation/essentials/next.svg',
                  height: 18,
                  width: 18,
                  color: Colors.orange[800],
                ),
              ),
            ),
          ),
          AnimatedSize(
            alignment: Alignment.center,
            duration: Duration(milliseconds: 1),
            vsync: this,
            child: Container(width: size.width * 0.7, child: widget.child),
          ),
          Container(
            color: Colors.transparent,
            width: 50,
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              opacity: fadeAnim.value != true ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: SvgPicture.asset(
                'assets/icons/navigation/essentials/next.svg',
                height: 18,
                width: 18,
                color: Colors.orange[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

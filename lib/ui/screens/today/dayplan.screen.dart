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
  bool show;
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
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => manager.fadeAnimation.addStatusListener((status) {
              setState(() {});
            }));
    manager.pushAnimation.addListener(() {
      setState(() {});
    });
    show = true;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _minController.dispose();
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
                                    ? Colors.transparent //deepOrange
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
    print('AAAAAQQQQQQQ ' + (manager.fadeAnimation?.status.toString()));
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
              manager.fadeAnimation.reset();
              manager.resetTime();
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
            if (manager.fadeAnimation.status == AnimationStatus.dismissed) {
              manager.fadeAnimation.reset();
              manager.resetTime();
              print('jojo');
              setState(() {
                _minController.forward();
                circleMinimized = true;
              });
            }
          }
        },
        child: SizedBox(
            width: size.width,
            height: heightOfCircleSpace /
                (!show ? circleMinimized ? 2.8 : 1 : heightOfCircleSpace),
            // 2.8

            child: CirclePlanOverlay(
              child: FittedBox(
                  clipBehavior: Clip.none,
                  alignment: true ? Alignment.topCenter : Alignment.center,
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
        itemCount: timeSlots.length + 1,
        itemBuilder: (context, index) {
          if (show &&
                  index == 0 &&
                  manager.pushAnimation.status == AnimationStatus.dismissed ||
              index == 0 &&
                  manager.fadeAnimation != null &&
                  manager.fadeAnimation.status != AnimationStatus.dismissed) {
            return SizedBox(
              child: (show)
                  ? GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onTap: () => setState(() {
                            manager.fadeAnimation.reset();
                            show = false;
                          }))
                  : GestureDetector(
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.deepOrange,
                      ),
                      onTap: () => setState(() {
                            manager.fadeAnimation.reset();
                            show = true;
                          })),
            );
          } else if (index == 0) {
            return SizedBox();
          }
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SlotWidget.TimeSlot(timeSlot: timeSlots[index - 1]));
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
        duration: Duration(milliseconds: 150));
    fadeAnim = Tween<bool>(begin: false, end: true).animate(fadeController);
    fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) setState(() {});
    });
    manager.fadeAnimation = fadeController;
    manager.minController.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.dismissed) setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
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
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
              child: GestureDetector(
                  onTap: (manager.minController.status ==
                          AnimationStatus.dismissed)
                      ? () {
                          print('clicked');
                          fadeController.reverse(from: 1);
                        }
                      : null,
                  child: AbsorbPointer(
                    absorbing: !(fadeAnim.value == true),
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      child: AnimatedScaleButton(
                        onTap: (manager.minController.status ==
                                AnimationStatus.dismissed)
                            ? () {
                                print('clicked');
                                manager.backTime();
                                fadeController.reverse(from: 1);
                              }
                            : null,
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerRight,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Opacity(
                              opacity: !(fadeAnim.value == true) ||
                                      manager.choosenTime?.hour == 0
                                  ? 0
                                  : 1,
                              child: SvgPicture.asset(
                                'assets/icons/navigation/essentials/next.svg',
                                height: 18,
                                width: 18,
                                color: Colors.orange[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Container(width: size.width * 0.65, child: widget.child),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
              child: GestureDetector(
                onTap:
                    (manager.minController.status == AnimationStatus.dismissed)
                        ? () {
                            print('clicked');
                            fadeController.reverse(from: 1);
                          }
                        : null,
                child: AbsorbPointer(
                  absorbing: !(fadeAnim.value == true),
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: AnimatedScaleButton(
                      onTap: (manager.minController.status ==
                              AnimationStatus.dismissed)
                          ? () {
                              print('clicked');
                              manager.forwardTime();
                              print(manager.choosenTime.toString());
                              fadeController.reverse(from: 1);
                            }
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: !(fadeAnim.value == true) ||
                                  manager.choosenTime?.hour == 12
                              ? 0
                              : 1,
                          child: SvgPicture.asset(
                            'assets/icons/navigation/essentials/next.svg',
                            height: 18,
                            width: 18,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedScaleButton extends StatefulWidget {
  const AnimatedScaleButton({
    Key key,
    this.onTap,
    this.child,
    this.size,
    this.padding = 20,
  }) : super(key: key);

  final Function onTap;
  final Widget child;
  final double size;
  final double padding;

  @override
  _AnimatedScaleButtonState createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        widget.onTap.call();
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.2).animate(
            CurvedAnimation(parent: _controller, curve: Curves.bounceInOut)),
        child: Container(
            height: widget.size,
            width: widget.size,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            alignment: Alignment.centerRight,
            child: widget.child),
      ),
    );
  }
}

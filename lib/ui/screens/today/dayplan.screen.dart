import 'dart:async';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/today/components/circle_list.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
    as SlotWidget;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DayPlanScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Consumer<DayPlanManager>(
          builder: (_, DayPlanManager manager, __) => DayPlanScreen._(
            isLoading: isLoading.value,
            manager: manager,
          ),
        ),
      ),
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
    with SingleTickerProviderStateMixin {
  DayPlanManager manager;
  _DayPlanScreenState(this.manager);

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 0.165).animate(_controller);

    manager.pushAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget _buildRemindersList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: manager.dataStream, //manager.remindersbyDayDataStream,
        builder: (context, snapshot) {
          List<TimeSlot> timeSlots = manager.getRemindersByTimeSlots();
          if (widget.isLoading) {
            return LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else if (timeSlots.length == 0) {
            return Column(
              children: [
                Center(child: text('no reminders for today')),
              ],
            );
          }

          return Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return SlotWidget.TimeSlot(timeSlot: timeSlots[index]);
                }),
          );
        });
  }

  Widget _buildCirclePlan(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.colorDodge,
            color: appWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), //was 0.1
                spreadRadius: 1,
                blurRadius: 4, //was 4 , 3
                offset: Offset(0, 1), // was 1, 2
              ),
            ]),
        alignment: Alignment.center,
        width: size.width,
        child: Center(
          child: CircleList(
            origin: Offset(0, 0),
            innerRadius: 100,
            outerRadius: 130,
            initialAngle: 0,
            children: List.generate(24 * 1, (index) {
              //6
              return index % 3 != 0
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: 35,
                      height: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          appearance_icon_0,
                          color: index.isOdd ? Colors.indigo[900] : null,
                        ),
                      ),
                    );
            }),
          ),
        ));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          if (true)
            AnimatedBox(
              animation: _animation,
            ),
          SizedBox(
              height: size.height * 0.35,
              child: _buildCirclePlan(context) // was 0.35
              ),
          if (true) Expanded(child: _buildRemindersList(context)),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return _body(context);
  }
}

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/animatedBox.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/today/components/circle_list.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
//*swtich versions. animation differences*/
    as SlotWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  DateTime initalTime =
      DateTime.now().applyTimeOfDay(TimeOfDay(hour: 0, minute: 0));
  DateTime endTime = DateTime.now().applyTimeOfDay(TimeOfDay(
    hour: 12,
    minute: 0,
  ));

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
                initialAngle: -1.5,
                showInitialAnimation: true,
                rotateMode: RotateMode.stopRotate,
                centerWidget: Container(
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontFamily: 'Neue-Lt'),
                  ),
                ),
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
    print(indexTime.toIso8601String());
    reminders.forEach((reminder) {
      print(reminder.time.roundToNearest(15));

      if (reminder.time.roundToNearest(15).compareTo(indexTime) == 0)
        results.add(reminder);
//      reminders.remove(reminder);
    });
    print(results.toString());
    return results;
  }

  Widget build(BuildContext context) {
    return _body(context);
  }

  void calcTimeFrames() {}
}

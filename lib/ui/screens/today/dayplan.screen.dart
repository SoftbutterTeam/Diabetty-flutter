import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/screens/today/components/background.dart';
import 'package:diabetty/ui/screens/others/error_screens/drafterror.screen.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:diabetty/ui/screens/today/components/header.dart';
import 'package:diabetty/ui/screens/today/components/timeslot.widget.dart'
    as SlotWidget;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayPlanScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppContext appContext =
        Provider.of<AppContext>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<DayPlanManager>(
          create: (_) =>
              DayPlanManager(appContext: appContext, isLoading: isLoading)
                ..init(),
          child: Consumer<DayPlanManager>(
            builder: (_, DayPlanManager manager, __) =>
                DayPlanScreen._(isLoading: isLoading.value, manager: manager),
          ),
        ),
      ),
    );
  }
}

class DayPlanScreen extends StatefulWidget {
  @override
  const DayPlanScreen._({Key key, this.isLoading, this.manager})
      : super(key: key);
  final DayPlanManager manager;
  final bool isLoading;

  @override
  _DayPlanScreenState createState() => _DayPlanScreenState(manager);
}

class _DayPlanScreenState extends State<DayPlanScreen> {
  DayPlanManager manager;
  _DayPlanScreenState(this.manager);

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

          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                return SlotWidget.TimeSlot(timeSlot: timeSlots[index]);
              });
        });
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.35,
          ),
          Expanded(child: _buildRemindersList(context)),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return _body(context);
  }
}

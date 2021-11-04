import 'dart:math';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/diary/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/today/components/reminder_icon_widget.dart';
import 'package:diabetty/blocs/therapy_manager.dart';

class HistoryScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TherapyManager>(
      builder: (_, TherapyManager therapyManager, __) =>
          Consumer<DayPlanManager>(
        builder: (_, DayPlanManager manager, __) {
          manager.therapyManager = therapyManager;
          return HistoryScreen(
            manager: manager,
          );
        },
      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  final DayPlanManager manager;
  const HistoryScreen({Key key, this.manager}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DayPlanManager manager;

  @override
  void initState() {
    manager = widget.manager;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Container(
        child: Container(
      child: _buildHistory(context),
    ));
  }

  Widget _buildHistory(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: min(
            DateTime.now()
                    .difference(manager.lastReminderDate ?? DateTime.now())
                    .inDays +
                2,
            150),
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) {
          Map<String, List<Reminder>> history = manager.generateDayHistory(
              DateTime.now().subtract(Duration(days: index)));

          return _buildHistoryDay(
              context, history, DateTime.now().subtract(Duration(days: index)));
        },
      ),
    );
  }

  Widget _buildHistoryDay(BuildContext context,
      Map<String, List<Reminder>> history, DateTime dateTime) {
    List<Widget> children = [];
    history.forEach((key, value) {
      children.add(_buildMedicationHistory(context, key, value));
    });

    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                  top: BorderSide(color: Colors.black26, width: 0.4),
                  bottom: BorderSide(color: Colors.black26, width: 0.4)),
            ),
            padding: EdgeInsets.only(left: 25, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dateTime.shortenDateRepresent(),
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ]..addAll(children),
      ),
    );
  }

  Widget _buildMedicationHistory(
      BuildContext context, String therapyName, List<Reminder> reminders) {
    Size size = MediaQuery.of(context).size;
    if (reminders.isEmpty) return SizedBox();
    reminders.sort((Reminder a, Reminder b) =>
        (a.rescheduledTime ?? a.time).compareTo((b.rescheduledTime ?? b.time)));
    return Container(
        padding: EdgeInsets.only(left: 3, right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: size.width * 0.06, bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    appearance_iconss[reminders[0].appearance],
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: size.width * 0.05),
                  Text(
                    therapyName.capitalize(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
            ColumnBuilder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return _buildRemindersHistoryField(context, reminders[index]);
              },
            ),
          ],
        ));
  }

  Widget _buildRemindersHistoryField(BuildContext context, Reminder reminder) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(left: size.width * 0.17),
        padding: EdgeInsets.only(right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(reminder.dose.toString() +
                ' ' +
                unitTypes[reminder.doseTypeIndex].plurarlUnits(reminder.dose)),
            Container(
              child: Row(
                children: [
                  if (reminder.takenAt != null)
                    Container(
                      child: text(reminder.time.formatTime(),
                          textColor: Colors.green[600], fontSize: 13.0),
                    ),
                  SizedBox(width: 10),
                  ReminderStateIcon(
                      reminder: reminder,
                      onNull: _buildQuestionIcon(context),
                      size: 20.0),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildQuestionIcon(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.blue[300], width: 1)),
      child: Center(child: null),
    );
  }
}

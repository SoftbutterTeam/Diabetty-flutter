import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/medication_profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetty/blocs/dayplan_manager.dart' as Plan;
import 'package:intl/intl.dart';

class TimeSlot extends StatelessWidget {
  final Plan.TimeSlot timeSlot;

  const TimeSlot({Key key, this.timeSlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double unit = 1;
    String time =
        new DateFormat.jm().format(DateTime.parse(timeSlot.time.toString()));
    DateFormat.jm().parse(time);
    return SizedBox(
      height: (40 + 75 * timeSlot.reminders.length * unit).toDouble(),
      child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Column(children: <Widget>[
            Center(
              child: text(
                time,
                textColor: Colors.indigo[900],
                fontFamily: 'Regular',
                fontSize: textSizeMedium,
              ),
            ),
            Expanded(
                child: ColumnBuilder(
              itemCount: timeSlot.reminders.length,
              itemBuilder: (context, index) {
                return ReminderCard(reminder: timeSlot.reminders[index]);
              },
            ))
          ])),
    );
  }
}

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({Key key, this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unit = 1;
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: 75 * unit,
        child: Card(
          semanticContainer: true,
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 0.1, color: Colors.deepOrange)),
          child: _buildContent(context),
        ));
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 12, top: 7.0, bottom: 4, left: 12),
        child: GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MedicationProfile())),
          child: Row(
            children: <Widget>[
              _buildReminderIcon(context),
              _buildReminderInfo(context),
              _buidReminderTick(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderIcon(BuildContext context) {
    return Container(
        child: SizedBox(
      height: 25,
      width: 25,
      child: SvgPicture.asset(appearance_icon_0),
    ));
  }

  Widget _buildReminderInfo(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            text('Insulin 30mg', //reminder.name,
                textColor: Colors.indigo[900],
                fontFamily: 'Regular',
                fontSize: 15.0,
                overflow: TextOverflow.ellipsis),
            text('Reminder Description', fontSize: textSizeSmall),
          ],
        ),
      ),
    );
  }

  Widget _buidReminderTick(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {},
        padding: EdgeInsets.all(3),
        icon: SizedBox(
          width: 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(60),
              color: Colors.greenAccent[700],
            ),
            child: SvgPicture.asset(
              'assets/icons/navigation/checkbox/tick.svg',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

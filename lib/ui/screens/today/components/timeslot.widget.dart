import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/medication_profile.screen.dart';
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
                textColor: t2_colorPrimary,
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
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: _buildContent(context),
        ));
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 9, top: 7.0, bottom: 4, left: 4),
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
    return ClipOval(
      child: Image(
        height: 30,
        width: 30,
        image: AssetImage('assets/icons/navigation/clock/medication.jpeg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildReminderInfo(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(reminder.name,
                textColor: t2_colorPrimary,
                fontFamily: 'Regular',
                fontSize: textSizeMedium2,
                overflow: TextOverflow.ellipsis),
            text('Reminder Description', fontSize: textSizeSmall),
          ],
        ),
      ),
    );
  }

  Widget _buidReminderTick(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15),
        alignment: Alignment.center,
        child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.all(3),
            icon: SvgPicture.asset(
              'assets/icons/navigation/checkbox/tick.svg',
              width: 30,
              color: Colors.indigoAccent[100],
              height: 30,
            )));
  }
}

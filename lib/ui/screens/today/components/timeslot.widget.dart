import 'dart:ui';

import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/medication_profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return IntrinsicHeight(
      child: SizedBox(
        // height: (40 + 75 * timeSlot.reminders.length * unit).toDouble(),
        child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                      //* could do without? or mix up blur
                      radius: 5,
                      tileMode: TileMode.mirror,
                      focalRadius: 2,
                      colors: [
                        Colors.white.withOpacity(.1),
                        Colors.grey[200].withOpacity(.1),
                        Colors.grey[500].withOpacity(0.1),
                        Colors.white.withOpacity(.1),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Container(
                  alignment: Alignment.center,
                  child: text(
                    time,
                    textColor: Colors.black87,
                    fontFamily: 'Regular',
                    fontSize: textSizeMedium,
                  ),
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
      ),
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
    return IntrinsicHeight(
        child: SizedBox(
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 70), //was 75 may be bettter
          child: Card(
            color: Colors.white,
            shadowColor: Colors.grey.withOpacity(.1), // 0 works great was .2 .1
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  width: 0.1, color: Colors.deepOrange), //Colors.white
            ),
            child: _buildContent(context),
          )),
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
      ),
    );
  }

  Widget _buildReminderInfo(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, //was space evently
          children: <Widget>[
            text('Insulin 30mg', //reminder.name,
                fontFamily: 'Regular',
                fontSize: 15.0,
                overflow: TextOverflow.ellipsis),
            text(
              'Reminder Description ',
              fontSize: textSizeSmall,
              maxLine: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buidReminderTick(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: IconButton(
        color: Colors.transparent,
        onPressed: () {},
        padding: EdgeInsets.all(3),
        icon: SizedBox(
          width: 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(60),
              color: Colors.transparent, //   Colors.greenAccent[700]
            ),
            child: SvgPicture.asset(
              'assets/icons/navigation/checkbox/tick.svg',
              color: Colors.greenAccent[700], //Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class ReminderMiniCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderMiniCard({Key key, this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unit = 1;
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: SizedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 70), //was 75 may be bettter
          child: _buildContent(context),
        ),
      ),
    );
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
      ),
    );
  }

  Widget _buildReminderInfo(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, //was space evently
          children: <Widget>[
            text('Insulin 30mg', //reminder.name,
                fontFamily: 'Regular',
                fontSize: 15.0,
                overflow: TextOverflow.ellipsis),
            text(
              'Reminder Description ',
              fontSize: textSizeSmall,
              maxLine: 2,
            ),
          ],
        ),
      ),
    );
  }
}

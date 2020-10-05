import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/medication_profile.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({Key key, this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    bool completed = reminder.takenAt != null;
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(right: 3),
        child: SizedBox(
          width: 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !completed ? Colors.transparent : Colors.greenAccent[700],
            ),
            child: SvgPicture.asset(
              'assets/icons/navigation/checkbox/tick.svg',
              color: !completed ? Colors.greenAccent[700] : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

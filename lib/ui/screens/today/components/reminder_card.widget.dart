import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/sub_models/medication_info.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/medication_profile.screen.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/extensions/index.dart';

class ReminderCard extends StatelessWidget with ReminderActionsMixin {
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
          onTap: () => showReminderPopupModal(context),
          child: Row(
            children: <Widget>[
              _buildReminderIcon(context),
              _buildReminderInfo(context),
              _buildReminderTick(context),
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
            text(reminder.name, //reminder.name,
                fontFamily: 'Regular',
                fontSize: 15.0,
                overflow: TextOverflow.ellipsis),
            text(
              _buildReminderDescription(),
              fontSize: textSizeSmall,
              maxLine: 2,
            ),
          ],
        ),
      ),
    );
  }

  String _buildReminderDescription() {
    int remStrength = reminder.strength;
    int remQuantity = reminder.dose;
    int remType = reminder.doseTypeIndex;
    int remStrengthType = reminder.strengthUnitindex;
    String remDescription = "";
    if (remStrength != null && remStrengthType != null && remStrengthType != 0)
      remDescription += "$remStrength ${strengthUnits[remStrengthType]}";
    if (remDescription.isNotEmpty) remDescription += ', ';
    if (remType != null && remQuantity != null)
      remDescription +=
          "${remQuantity ?? ''} ${unitTypes[remType].plurarlUnits(remQuantity ?? 1)}";

    return remDescription;
  }

  //TODO: Remove the 'none' type of StrengthType either from the constants or from being shown via the if statement.

  Widget _buildReminderTick(BuildContext context) {
    bool completed = reminder.takenAt != null;
    return GestureDetector(
      onTap: () => showTakeModalPopup(context),
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

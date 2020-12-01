import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/ui/constants/icons.dart';
import 'package:diabetty/ui/screens/today/components/reminder_icon_widget.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:provider/provider.dart';

class ReminderMiniCard extends StatelessWidget with ReminderActionsMixin {
  final Reminder reminder;

  const ReminderMiniCard({Key key, this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  DayPlanManager manager = Provider.of<DayPlanManager>(context, listen: true);

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: SizedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 60, minWidth: 60), //was 75 may be bettter
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RemIconWidget(
        reminder: reminder,
        size: 35,
        extraFeatures: false,
        func: () => showReminderPopupModal(context),
      ),
    );
  }

  Widget _buildReminderIcon(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(appearance_icon_0),
      ),
    );
  }
}

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_therapy_reminders.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_reminder.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditReminder extends StatefulWidget {
  final Therapy therapy;

  EditReminder({this.therapy});
  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder>
    with EditTherapyModalsMixin {
  @override
  Therapy get therapy => widget.therapy;
  @override
  Widget build(BuildContext context) {
    final TherapyManager manager =
        Provider.of<TherapyManager>(context, listen: true);

    if (widget.therapy.schedule != null ||
        widget.therapy.schedule.reminderRules.isNotEmpty) {
      widget.therapy.schedule.reminderRules
        ..sort((ReminderRule a, ReminderRule b) =>
            a.time.applyTimeOfDay().compareTo(b.time.applyTimeOfDay()));
    }

    List<Widget> reminderRulesList = (therapy.schedule.reminderRules == null ||
            therapy.schedule.reminderRules.length == 0)
        ? List()
        : therapy.schedule.reminderRules
            .map(
                (e) => EditTherapyReminder(rule: e, therapy: therapy) as Widget)
            .toList()
      ..add(_buildAddReminderField(context));

    return SnoozeOptionsBackground(
        header: SnoozeOptionsHeader(
          text: '',
          backFunction: () {
            Navigator.pop(context);
            // _back();
          },
          saveFunction: () {},
        ),
        child: _body(context, reminderRulesList));
  }

  Widget _body(BuildContext context, List<Widget> reminderRulesList) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildBody(size, reminderRulesList),
        ),
      ],
    );
  }

  Widget _buildBody(Size size, List<Widget> reminderRulesList) {
    return Column(
      children: [
        // SizedBox(height: size.height * 0.05),
        Text('Scheduled Reminders'),
        ColumnBuilder(
          mainAxisAlignment: MainAxisAlignment.start,
          itemCount: reminderRulesList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Container(child: reminderRulesList[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddReminderField(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          CupertinoTextField(
            onTap: () {
              showEditReminderModal2(context, therapy);
            },
            decoration: BoxDecoration(
              color: appWhite,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey[200],
                    width: 1.2,
                    style: BorderStyle.solid),
              ),
            ),
            prefix: Container(
              padding: EdgeInsets.only(left: 18),
              child: Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.green,
                size: 23,
              ),
            ),
            placeholder: 'Add Reminder',
            readOnly: true,
            maxLines: 1,
            maxLength: 30,
            padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
            placeholderStyle: TextStyle(
              fontSize: textSizeLargeMedium - 3,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

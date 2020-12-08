import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_therapy_reminders.dart';
import 'package:diabetty/ui/screens/therapy/components/reminder_rule_field.widget.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_option_background.dart';
import 'package:diabetty/ui/screens/therapy/components/snooze_options_header.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditReminder extends StatefulWidget {
  final Therapy therapy;

  EditReminder({this.therapy});
  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  @override
  Widget build(BuildContext context) {
    List<Widget> reminderRulesList = (widget.therapy.schedule.reminderRules ==
                null ||
            widget.therapy.schedule.reminderRules.length == 0)
        ? List()
        : widget.therapy.schedule.reminderRules
            .map((e) => EditTherapyReminder(rule: e, therapy: widget.therapy)
                as Widget)
            .toList()
      ..add(_buildAddReminderField(context));

    return SnoozeOptionsBackground(
        header: SnoozeOptionsHeader(
          text: 'save',
          backFunction: () {
            Navigator.pop(context);
            // _back();
          },
          saveFunction: () {
            Navigator.pop(context);
          },
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
        SizedBox(height: size.height * 0.05),
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
              print('hi');
            },
            decoration: BoxDecoration(
              color: appWhite,
              border: Border.all(
                  color: Colors.black54, width: 0.1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(0),
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

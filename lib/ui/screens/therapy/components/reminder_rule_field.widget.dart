import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReminderRuleField extends StatefulWidget {
  const ReminderRuleField({
    Key key,
    this.rule,
    @required this.textstyle,
  }) : super(key: key);

  final TextStyle textstyle;
  final ReminderRule rule;

  @override
  _ReminderRuleFieldState createState() => _ReminderRuleFieldState();
}

class _ReminderRuleFieldState extends State<ReminderRuleField> {
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TherapyManager manager = Provider.of<TherapyManager>(context);
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Container(
        padding: EdgeInsets.only(left: 18),
        child: FlatButton(
          child: Icon(
            CupertinoIcons.minus_circled,
            color: Colors.red,
            size: 23,
          ),
          onPressed: () => _deleteRule(manager),
        ),
      ),
      suffix: Container(
          padding: EdgeInsets.only(right: 15),
          child: Text(_getTime(), style: widget.textstyle)),
      placeholder: _getReminderRuleDaysText(),
      readOnly: true,
      maxLines: 1,
      maxLength: 30,
      padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
      placeholderStyle: widget.textstyle,
      style: widget.textstyle,
    );
  }

  String _getReminderRuleDaysText() {
    String text = "";
    if (widget.rule.days.monday)
      text += 'M ';
    else
      text += "     ";
    if (widget.rule.days.tuesday)
      text += 'T ';
    else
      text += "     ";
    if (widget.rule.days.wednesday)
      text += 'W ';
    else
      text += "     ";
    if (widget.rule.days.thursday)
      text += 'T ';
    else
      text += "     ";
    if (widget.rule.days.friday)
      text += 'F ';
    else
      text += "     ";
    if (widget.rule.days.saturday)
      text += 'S ';
    else
      text += "     ";
    if (widget.rule.days.saturday)
      text += 'S ';
    else
      text += "     ";
    return text;
  }

  String _getTime() {
  
    return DateFormat.jm().format(widget.rule.time);
    // or this one - not sure how cute that first one is gonna be
    // change the : if you want it to be something else, its smart it will get u
    // add spaces where ever too
    return DateFormat("h:mm a").format(widget.rule.time);
  }

  _deleteRule(TherapyManager manager) {
    manager.therapyForm.reminderRules
        .removeWhere((element) => element.uid == widget.rule.uid);
    //*  that should delete it  e.g.  element == widget.rule
    //* if not use element.uid == widget.rule.uid
    //* dont worry I already generate the uids
      manager.updateListeners();
  }
}

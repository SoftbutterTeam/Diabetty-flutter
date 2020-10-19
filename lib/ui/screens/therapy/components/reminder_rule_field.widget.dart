import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReminderRuleField extends StatefulWidget {
  const ReminderRuleField({
    Key key,
    this.rule,
  }) : super(key: key);

  final ReminderRule rule;

  @override
  _ReminderRuleFieldState createState() => _ReminderRuleFieldState();
}

class _ReminderRuleFieldState extends State<ReminderRuleField> {
  @override
  dispose() {
    super.dispose();
  }

  var textstyle = TextStyle(
    letterSpacing: 1.0,
    fontFeatures: [
      FontFeature.proportionalFigures(),
    ],
    fontSize: textSizeLargeMedium - 3,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    TherapyManager manager = Provider.of<TherapyManager>(context);
    var size = MediaQuery.of(context).size;
    List<Widget> weekDays = buildWeekWidgets(context);
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Row(
        children: [
          GestureDetector(
            onTap: () => _deleteRule(manager),
            child: Container(
              padding: EdgeInsets.only(left: 18, right: 14),
              child: Icon(
                CupertinoIcons.minus_circled,
                color: Colors.red,
                size: 23,
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: weekDays,
            ),
          )
        ],
      ),
      suffix: Container(
          padding: EdgeInsets.only(right: 15),
          child: Text(_getTime(), style: textstyle)),
      placeholder: _getReminderRuleDaysText(),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontFeatures: [
          FontFeature.tabularFigures(),
        ],
      ),
      readOnly: true,
      maxLines: 1,
      maxLength: 30,
      padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
      placeholderStyle: textstyle,
    );
  }

  String _getReminderRuleDaysText() {
    String text = '';
    String emptyspace = '-'; // or the 5spaces '     ';
    String letterspace = ' ';
    if (widget.rule.days.monday)
      text += 'M' + letterspace;
    else
      text += letterspace + emptyspace + letterspace;
    if (widget.rule.days.tuesday)
      text += emptyspace + letterspace;
    else
      text += emptyspace + letterspace;
    if (widget.rule.days.wednesday)
      text += 'W' + letterspace;
    else
      text += emptyspace + letterspace;
    if (widget.rule.days.thursday)
      text += emptyspace + letterspace;
    else
      text += emptyspace + letterspace;
    if (widget.rule.days.friday)
      text += 'F' + letterspace;
    else
      text += emptyspace + letterspace;
    if (widget.rule.days.saturday)
      text += 'S' + letterspace;
    else
      text += emptyspace + letterspace;
    if (widget.rule.days.saturday)
      text += 'S' + letterspace;
    else
      text += emptyspace + letterspace;
    return '2 tablets';
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

  buildWeekWidgets(BuildContext context) {
    return <Widget>[
      Container(child: Text('M', style: textstyle)),
      Container(child: Text('T', style: textstyle)),
      Container(child: Text('W', style: textstyle)),
      Container(child: Text('-', style: textstyle)),
      Container(child: Text('F', style: textstyle)),
      Container(child: Text('S', style: textstyle)),
      Container(child: Text('S', style: textstyle)),
    ]
        .map((e) => Flexible(fit: FlexFit.tight, child: Center(child: e)))
        .toList();
  }
}

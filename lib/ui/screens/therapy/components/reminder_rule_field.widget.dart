import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/ui/screens/therapy/extensions/string_extension.dart';

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
            width: size.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: weekDays,
            ),
          )
        ],
      ),
      suffix: Stack(
        children: [_buildPlaceboTime(), _buildReminderTime()],
        alignment: Alignment.centerRight,
      ),
      placeholder: widget.rule.dose.toString() +
          ' ' +
          unitTypes[manager.therapyForm.unitsIndex]
              .plurarlUnits(widget.rule.dose),
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

  Container _buildReminderTime() {
    return Container(
        padding: EdgeInsets.only(right: 15),
        child: Text(_getTime(), style: textstyle));
  }

  Container _buildPlaceboTime() {
    return Container(
        padding: EdgeInsets.only(right: 15),
        child: Text('00:00 AM',
            style: TextStyle(
              color: Colors.transparent,
              letterSpacing: textstyle.letterSpacing,
              fontFeatures: textstyle.fontFeatures,
              fontSize: textstyle.fontSize,
            )));
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
    Text emptyClause = Text('-', style: textstyle);
    return <Widget>[
      Container(
          child: widget.rule.days.monday
              ? Text('M', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.tuesday
              ? Text('T', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.wednesday
              ? Text('W', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.thursday
              ? Text('T', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.friday
              ? Text('F', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.saturday
              ? Text('S', style: textstyle)
              : emptyClause),
      Container(
          child: widget.rule.days.sunday
              ? Text('S', style: textstyle)
              : emptyClause),
    ]
        .map((e) => Flexible(fit: FlexFit.tight, child: Center(child: e)))
        .toList();
  }
}
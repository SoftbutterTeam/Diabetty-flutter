import 'dart:math';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/teams/common.mixin.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/cupertino_text_field.dart'
    as custom;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/string_extension.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

class EditTherapyReminder extends StatefulWidget {
  const EditTherapyReminder({
    Key key,
    this.rule,
    this.therapy,
  }) : super(key: key);

  final ReminderRule rule;
  final Therapy therapy;

  @override
  _EditTherapyReminderState createState() => _EditTherapyReminderState();
}

class _EditTherapyReminderState extends State<EditTherapyReminder>
    with EditTherapyModalsMixin, CommonMixins {
  @override
  Therapy get therapy => widget.therapy;
  @override
  dispose() {
    super.dispose();
  }

  var textstyle = TextStyle(
    letterSpacing: 1.0,
    fontFeatures: [
      FontFeature.proportionalFigures(),
    ],
    fontSize: 14,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    TherapyManager manager = Provider.of<TherapyManager>(context);
    var size = MediaQuery.of(context).size;
    List<Widget> weekDays = buildWeekWidgets(context);
    return SizedBox(
      width: size.width,
      child: Container(
        width: size.width,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: GestureDetector(
                onTap: () {
                  areYouSurePopup(context, () {
                    _deleteRule(manager);
                  }, destructive: true);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 5, bottom: 3),
                  color: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: Colors.red,
                    size: 23,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                color: Colors.red,
                child: custom.CupertinoTextField(
                  onTap: () =>
                      showEditReminderModal(context, therapy, widget.rule),
                  overflow: TextOverflow.clip,
                  decoration: BoxDecoration(
                    color: appWhite,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey[200],
                          width: 1.2,
                          style: BorderStyle.solid),
                    ),
                  ),
                  prefix: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width * 0.4,
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: weekDays,
                      ),
                    ),
                  ),
                  suffix: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Text('00:00 AM', style: textstyle)),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(_getTime(), style: textstyle)),
                    ],
                  ),
                  placeholder: widget.rule.dose.toString() +
                      ' ' +
                      unitTypes[widget.therapy.medicationInfo.unitIndex]
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
                  padding:
                      EdgeInsets.only(left: 18, top: 13, bottom: 11, right: 10),
                  placeholderStyle: textstyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTime() {
    return DateFormat("h:mm a")
        .format(DateTime.now().applyTimeOfDay(widget.rule.time));

    //DateFormat.jm().format(widget.rule.time);

    // or this one - not sure how cute that first one is gonna be
    // change the : if you want it to be something else, its smart it will get u
    // add spaces where ever too
  }

  _deleteRule(TherapyManager manager) {
    therapy.schedule.reminderRules
        .removeWhere((element) => element.id == widget.rule.id);
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

import 'dart:math';
import 'dart:ui';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
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
    with EditTherapyModalsMixin {
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
    fontSize: textSizeLargeMedium - 2,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    TherapyManager manager = Provider.of<TherapyManager>(context);
    var size = MediaQuery.of(context).size;
    List<Widget> weekDays = buildWeekWidgets(context);
    return custom.CupertinoTextField(
      onTap: () => showEditReminderModal(context,
          therapy, widget.rule), //TODO click to show add reminder dialog with its attributes showing
      overflow: TextOverflow.clip,
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
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
      padding: EdgeInsets.only(left: 18, top: 13, bottom: 11, right: 10),
      placeholderStyle: textstyle,
    );
  }

  @override
  Widget build2(BuildContext context) {
    TherapyManager manager = Provider.of<TherapyManager>(context);
    var size = MediaQuery.of(context).size;
    List<Widget> weekDays = buildWeekWidgets(context);
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: min(70, size.height * 0.07),
            maxHeight: max(70, size.height * 0.08),
            minWidth: size.width * 0.8,
            maxWidth: size.width * 0.95),
        child: Container(
          decoration: BoxDecoration(
            color: appWhite,
            border: Border.all(
                color: Colors.black54, width: 0.1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 18, right: 14),
                    child: Icon(
                      CupertinoIcons.clear_circled,
                      color: Colors.red,
                      size: 23,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  height: max(6, size.height * 0.03),
                  width: 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange[800],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: weekDays,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.rule.dose.toString() +
                                ' ' +
                                unitTypes[2].plurarlUnits(widget.rule.dose) +
                                ' at ' +
                                _getTime(),
                            style: textstyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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

  // _deleteRule(TherapyManager manager) {
  //   manager.therapyForm.reminderRules
  //       .removeWhere((element) => element.id == widget.rule.id);
  //   //*  that should delete it  e.g.  element == widget.rule
  //   //* if not use element.uid == widget.rule.uid
  //   //* dont worry I already generate the uids
  //   manager.updateListeners();
  // }

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

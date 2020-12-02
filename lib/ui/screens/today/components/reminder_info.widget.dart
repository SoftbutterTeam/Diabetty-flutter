import 'dart:math';
import 'dart:ui';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/today/mixins/ReminderActionsMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:provider/provider.dart';

class ReminderInfoModal extends StatefulWidget {
  const ReminderInfoModal({
    this.reminder,
    Key key,
  }) : super(key: key);

  final Reminder reminder;

  @override
  _ReminderInfoModalState createState() => _ReminderInfoModalState();
}

class _ReminderInfoModalState extends State<ReminderInfoModal>
    with ReminderActionsMixin {
  MaterialColor colorToFade;
  double opacity;

  @override
  Reminder get reminder => widget.reminder;

  @override
  void initState() {
    super.initState();
  }

  double curve = 15;
  double bottomCurve;

  @override
  Widget build(BuildContext context) {
    DayPlanManager dayPlanManager =
        Provider.of<DayPlanManager>(context, listen: true);
    colorToFade = false ? Colors.green : Colors.grey;
    opacity = reminder.isComplete ? .3 : .3;
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: _buildContent(context, size),
      ),
    );
  }

  Widget _buildContent(BuildContext context, size) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: _buildHeader(),
          ),
          Flexible(
            flex: 4,
            child: _buildBody2(size),
          ),
          Flexible(
            flex: 2,
            child: _buildFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(size) {
    int remStrength = reminder.strength;
    int remQuantity = reminder.dose;
    int remType = reminder.doseTypeIndex;
    int remStrengthType = reminder.strengthUnitindex;
    int remAdviceInd = reminder.advices.isNotEmpty ? reminder.advices[0] : 0;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height * 0.25),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 13, right: 13),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 3,
                spacing: 7,
                direction: Axis.horizontal,
                children: [
                  SizedBox(
                    height: 33,
                    width: 33,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: SvgPicture.asset(
                        appearance_iconss[reminder.appearance],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(reminder.name.capitalizeBegins() + " ",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 21.0,
                            color: null,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: size.width * 0.1,
              color: Colors.orange[800],
              margin: EdgeInsets.only(bottom: 30, top: 5),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.date_range, size: 20),
                  SizedBox(width: 20),
                  text(
                      'Time: ' +
                          (reminder.rescheduledTime ?? reminder.time)
                              .shortenDateRepresent() +
                          " " +
                          (reminder.rescheduledTime ?? reminder.time)
                              .formatTime()
                              .toLowerCase(),
                      fontSize: 13.0),
                ],
              ),
            ),
            if (remType != null && remQuantity != null)
              Container(
                padding: EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.filter_center_focus, size: 20),
                    SizedBox(width: 20),
                    text(
                        'Dose: ' +
                            reminder.dose.toString() +
                            ' ' +
                            unitTypes[reminder.doseTypeIndex]
                                .plurarlUnits(reminder.dose) +
                            ((remStrength != null &&
                                    remStrengthType != null &&
                                    remStrengthType != 0)
                                ? ", $remStrength ${strengthUnits[remStrengthType]}"
                                : ''),
                        fontSize: 13.0),
                  ],
                ),
              ),
            if (remAdviceInd != 0)
              Container(
                padding: EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.filter_center_focus, size: 20),
                    SizedBox(width: 20),
                    text(
                        "Advice: ${intakeAdvice[reminder.advices[0]].toLowerCase()}",
                        fontSize: 13.0),
                  ],
                ),
              ),
            if (_buildReminderStatusDescription() != null)
              Container(
                padding: EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.filter_center_focus, size: 20),
                    SizedBox(width: 20),
                    _buildReminderStatusDescription() ?? SizedBox(),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildReminderStatusDescription() {
    String remDescription = "";
    Color color;

    switch (reminder.status) {
      case ReminderStatus.completed:
        if (reminder.takenAt == null) return null;
        remDescription = "taken at ${reminder.takenAt.formatTime()}";
        color = Colors.green[600];
        break;
      case ReminderStatus.skipped:
        if (reminder.skippedAt == null) return null;
        remDescription = "skipped at ${reminder.skippedAt.formatTime()}";
        color = Colors.orange[900];
        break;
      case ReminderStatus.missed:
        if (reminder.time == null) return null;
        remDescription =
            "missed at ${(reminder.rescheduledTime ?? reminder.time).add(reminder.window ?? Duration(minutes: 5)).formatTime()}";
        color = Colors.redAccent[700];
        break;
      case ReminderStatus.snoozed:
        if (reminder.rescheduledTime == null) return null;
        remDescription = "rescheduled from ${reminder.time.formatTime()}";
        color = Colors.orange[900];
        break;
      case ReminderStatus.active:
        if (reminder.time == null) return null;
        remDescription =
            "take before ${reminder.time.add(reminder.window ?? Duration(minutes: 5)).formatTime()}";
        color = Colors.green[600];
        break;
      case ReminderStatus.isLate:
        if (reminder.rescheduledTime == null) return null;
        remDescription =
            "take before ${reminder.rescheduledTime.add(reminder.window ?? Duration(minutes: 5)).formatTime()}";
        color = Colors.orange[900];
        break;
      case ReminderStatus.idle:
        return null;
      default:
        return null;
    }
    return text(remDescription.toLowerCase().capitalize(),
        fontSize: 13.0, maxLine: 2, textColor: color);
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(curve),
          topRight: Radius.circular(curve),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: reminder.isComplete ? Colors.transparent : Colors.transparent,
          gradient: RadialGradient(
            radius: 5,
            tileMode: TileMode.mirror,
            focalRadius: 2,
            colors: [
              colorToFade.shade300.withOpacity(opacity),
              colorToFade.shade200.withOpacity(opacity),
              Colors.white.withOpacity(.1),
              Colors.white.withOpacity(.1),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(curve),
            topRight: Radius.circular(curve),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.more_vert, color: Colors.transparent),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                    onTap: () {},
                    // onTap: () => navigateTherapyProfile(context),
                    child: Icon(Icons.more_horiz)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: reminder.isComplete
                ? Colors.transparent
                : Colors.transparent, // meant to be null
            gradient: RadialGradient(
              radius: 5,
              tileMode: TileMode.mirror,
              focalRadius: 2,
              colors: [
                Colors.white.withOpacity(.1),
                colorToFade.shade200.withOpacity(opacity),
                colorToFade.shade500.withOpacity(opacity),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomCurve ?? curve), // was 20  10
              bottomRight: Radius.circular(bottomCurve ?? curve),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ReminderModalFooterButton(
                text2: "Skip",
                assetName: 'assets/icons/navigation/x/close.svg',
                onTap: () {
                  skipReminder(context, reminder);
                  Navigator.of(context).pop(context);
                }),
            ReminderModalFooterButton(
                text2: "Take",
                assetName: 'assets/icons/navigation/checkbox/tick_outline2.svg',
                onTap: () => _takenActionSheet(context)),
            ReminderModalFooterButton(
                text2: "Snooze",
                assetName: 'assets/icons/navigation/clock/wall-clock.svg',
                onTap: () => _snoozeActionSheet(context)),
          ],
        ));
  }

  void _snoozeActionSheet(BuildContext context) {
    showSnoozeActionSheet(context, this.reminder);
  }

  void _skipActionSheet(BuildContext context) {
    skipReminder(context, this.reminder);
  }

  void _takenActionSheet(BuildContext context) {
    showTakeActionPopup(context);
  }
}

class ReminderModalFooterButton extends StatelessWidget {
  const ReminderModalFooterButton({
    Key key,
    @required this.text2,
    @required this.assetName,
    @required this.onTap,
  }) : super(key: key);

  final double height2 = 75.0;
  final double width2 = 60;
  final double width3 = 30;
  final double height3 = 30;
  final color = Colors.black;

  final String text2;
  final String assetName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var edgeInsets = EdgeInsets.fromLTRB(0, 10, 0, 0);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      margin: edgeInsets,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: onTap,
              padding: EdgeInsets.symmetric(
                  vertical: 3, horizontal: size.height * 0.01),
              icon: SvgPicture.asset(
                assetName,
                color: color,
              ),
            ),
            SizedBox(height: 5),
            text(
              text2,
              textColor: Colors.black,
              fontFamily: fontSemibold,
              fontSize: 13.0,
              maxLine: 1,
              isCentered: true,
            ),
          ]),
    );
  }
}

import 'dart:ui';
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
import 'package:diabetty/extensions/datetime_extension.dart';

class ReminderInfoModal extends StatefulWidget {
  const ReminderInfoModal({
    this.reminder,
    this.manager,
    Key key,
  }) : super(key: key);

  final Reminder reminder;
  final TherapyManager manager;

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
    colorToFade = reminder.isComplete ? Colors.green : Colors.grey;
    opacity = reminder.isComplete ? .3 : .3;
    super.initState();
  }

  double curve = 15;
  double bottomCurve;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: Card(
          shadowColor: null,
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(curve),
          ),
          child: _buildContent(context, size),
        ),
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

  Widget _buildBody(size) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            appearance_iconss[reminder.apperance],
            width: 30,
            height: 30,
          ),
          text(reminder.name),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 10),
              text(
                  'Scheduled for ' +
                      DateFormat('dd/MM/yy').format(reminder.time),
                  fontSize: 12.0),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.filter_center_focus, size: 20),
              SizedBox(width: 10),
              text('Take ' + 'reminder.dose.toString()' + ' pill(s)',
                  fontSize: 12.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody2(size) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height * 0.15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        appearance_iconss[(reminder.apperance == null)
                            ? 0
                            : reminder.apperance],
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: text(reminder.name,
                          fontSize: 18.0,
                          textColor: Colors.black,
                          fontFamily: fontBold,
                          latterSpacing: 1.5),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 10),
                      child: text(
                          intakeAdvice[(reminder.adviceIndex == null)
                              ? 0
                              : reminder.adviceIndex],
                          fontSize: 15.0,
                          textColor: Colors.black87,
                          fontFamily: fontSemibold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 1,
              width: size.width * 0.75,
              color: Colors.black12,
              margin: EdgeInsets.only(bottom: 10),
            ),
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.date_range, size: 20),
                SizedBox(width: 20),
                text(
                    'Scheduled for ' +
                        DateFormat('dd/MM/yy').format(reminder.time) +
                        ' at ' +
                        reminder.time.formatTime(),
                    fontSize: 12.0),
              ],
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.filter_center_focus, size: 20),
                SizedBox(width: 20),
                text(
                    'Take ' +
                        reminder.dose.toString() +
                        ' ' +
                        unitTypes[reminder.doseUnitIndex],
                    fontSize: 12.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: Container(
          decoration: BoxDecoration(
              color: reminder.isComplete ? Colors.greenAccent : null,
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
                topLeft: Radius.circular(curve), // was 20  10
                topRight: Radius.circular(curve),
              )),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_vert, color: Colors.transparent),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: () => navigateTherapyProfile(context),
                      child: Icon(Icons.more_horiz)),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: reminder.isComplete ? Colors.greenAccent : null,
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
                onTap: () => _skipActionSheet(context)),
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
    showSnoozeActionSheet(context);
  }

  void _skipActionSheet(BuildContext context) {
    showSkipActionSheet(context);
  }

  void _takenActionSheet(BuildContext context) {
    showTakenActionSheet(context);
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
    var edgeInsets = EdgeInsets.fromLTRB(10, 10, 10, 0);
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
        margin: edgeInsets,
        height: height2,
        width: width2,
        child: Column(children: <Widget>[
          IconButton(
            onPressed: onTap,
            padding: EdgeInsets.all(3),
            icon: SvgPicture.asset(
              assetName,
              width: width3,
              height: height3,
              color: color,
            ),
          ),
          SizedBox(height: 5),
          text(
            text2,
            textColor: Colors.black,
            fontFamily: fontSemibold,
            fontSize: 12.0,
            maxLine: 2,
            isCentered: true,
          ),
        ]));
  }
}

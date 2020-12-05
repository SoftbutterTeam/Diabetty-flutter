import 'dart:ui';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_alarm_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_stock_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/profile_custom_textfield.dart';
import 'package:diabetty/ui/screens/therapy/components/refill_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_background.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_header.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_reminder.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TherapyProfileScreen2 extends StatefulWidget {
  final Therapy therapy;
  final TherapyManager manager;
  final BuildContext context;
  TherapyProfileScreen2({this.context, this.therapy, this.manager});

  @override
  _TherapyProfileScreen2State createState() => _TherapyProfileScreen2State();
}

class _TherapyProfileScreen2State extends State<TherapyProfileScreen2>
    with EditTherapyModalsMixin {
  @override
  Therapy get therapy => widget.therapy;
  Color textColor = Colors.orange[800];

  @override
  Widget build(BuildContext context) {
    return TherapyProfileBackground(
        header: TherapyProfileHeader(therapy: widget.therapy),
        child: _body(context));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(size),
        Expanded(
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: _buildBody(size))),
        _buildFooter(size),
      ],
    );
  }

  Widget _buildBody(Size size) {
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    List<Widget> reminderRulesList = (widget.therapy.schedule == null ||
            widget.therapy.schedule.reminderRules.isEmpty)
        ? List()
        : widget.therapy.schedule.reminderRules
            .map((e) => TherapyProfileReminder(rule: e, therapy: widget.therapy)
                as Widget)
            .toList();

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 15), child: _buildStockField()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              "scheduled reminders",
              fontSize: 16.0,
              textColor: Colors.grey[600],
            )
          ],
        ),
        if (reminderRulesList.isNotEmpty)
          Container(
            color: backgroundColor,
            padding: EdgeInsets.only(top: 10),
            child: (reminderRulesList.length < 10)
                ? ColumnBuilder(
                    itemCount: reminderRulesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return reminderRulesList[index];
                    },
                  )
                : 'yeye',
          ),
        if (reminderRulesList.isEmpty)
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'No reminders here man, move on pls',
              style: TextStyle(
                fontSize: textSizeLargeMedium,
                color: Colors.grey[700],
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(
                "more info",
                fontSize: 16.0,
                textColor: Colors.grey[600],
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10), child: _buildWindowField()),
        _buildMinRestField(),
      ],
    );
  }

  Widget _buildStockField() {
    return CustomTextField(
      stackIcons: _icons(
          color: (widget.therapy.stock == null ||
                  widget.therapy.stock.currentLevel == null)
              ? Colors.blueGrey
              : (widget.therapy.stock.isLowOnStock)
                  ? Colors.red
                  : Colors.blueGrey),
      onTap: () => showEditStockDialog2(context),
      placeholder: _getStockMessage(),
      placeholderText: 'Stock',
    );
  }

  Widget _buildWindowField() {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {},
      placeholder: _getWindowMessage(),
      placeholderText: 'Window',
      // placeholderTextStyle: TextStyle(
      //   fontSize: textSizeLargeMedium - 4,
      //   color: Colors.grey[700],
      // ),
    );
  }

  Widget _buildMinRestField() {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () {},
      placeholder: _getMinRestMessage(),
      placeholderText: 'Minimum Rest Duration',
      // placeholderTextStyle: TextStyle(
      //   fontSize: textSizeLargeMedium - 4,
      //   color: Colors.grey[700],
      // ),
    );
  }

  Widget _buildFooter(Size size) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.15),
        child: IntrinsicHeight(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          width: size.width,
          decoration: BoxDecoration(
              color: appWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  spreadRadius: 0.5,
                  blurRadius: 1.5,
                  offset: Offset(0, -1),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(200, 100, 100, 0.2),
                  width: 0.7,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSilentColumn(size),
              _buildRefillColumn(size),
              _buildTakeColumn(size),
            ],
          ),
        )));
  }

  Column _buildTakeColumn(Size size) {
    return Column(
      children: [
        Container(
          height: size.height * 0.08,
          width: size.width * 0.16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: textColor),
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Center(
          child: text('take', //reminder.name,
              fontFamily: 'Regular',
              fontSize: 15.0,
              overflow: TextOverflow.ellipsis,
              textColor: textColor),
        ),
      ],
    );
  }

  Column _buildSilentColumn(Size size) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showEditAlarmDialog2(context),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.16,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange[100]),
            child: Center(
              child: Icon(
                CupertinoIcons.volume_up,
                color: textColor,
                size: 35,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Center(
          child: text('sound', //reminder.name,
              fontFamily: 'Regular',
              fontSize: 15.0,
              overflow: TextOverflow.ellipsis,
              textColor: textColor),
        ),
      ],
    );
  }

  GestureDetector _buildRefillColumn(Size size) {
    return GestureDetector(
      onTap: () => showRefillDialog(context),
      child: Column(
        children: [
          Container(
            height: size.height * 0.08,
            width: size.width * 0.16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange[100],
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: textColor,
                size: 35,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Center(
            child: text('refill', //reminder.name,
                fontFamily: 'Regular',
                fontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                textColor: textColor),
          ),
        ],
      ),
    );
  }

  Container _buildHeader(Size size) {
    String nextMessage = getNextReminderMessage();
    String lastMessage = getLastReminderMessage();
    return Container(
      width: size.width,
      height: size.height * 0.20,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0.5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(1),
              spreadRadius: 3,
              blurRadius: 0,
              offset: Offset(0, -1),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: Colors.transparent, // Color.fromRGBO(200, 100, 100, 0.4),
              width: 0.7,
            ),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        appearance_iconss[
                            widget.therapy.medicationInfo.appearanceIndex],
                        width: 10,
                        height: 10,
                      ),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Text(widget.therapy.name,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: textColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'last taken',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                    if (lastMessage != null)
                      Text(
                        lastMessage,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300),
                      ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "next",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                    if (nextMessage != null)
                      Text(
                        nextMessage,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getWindowMessage() {
    return (widget.therapy.schedule == null ||
            widget.therapy.schedule.window == null)
        ? Text(
            'none',
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          )
        : Text(
            prettyDuration(widget.therapy.schedule.window, abbreviated: false),
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          );
  }

  _getMinRestMessage() {
    return (widget.therapy.medicationInfo == null ||
            widget.therapy.medicationInfo.restDuration == null)
        ? Text(
            'none',
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          )
        : Text(
            prettyDuration(widget.therapy.medicationInfo.restDuration,
                abbreviated: false),
            style: TextStyle(
              fontSize: textSizeLargeMedium - 4,
              color: Colors.grey[700],
            ),
          );
  }

  _getStockMessage() {
    if (widget.therapy.stock == null ||
        widget.therapy.stock.currentLevel == null) {
      return Text(
        '',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else if (widget.therapy.stock.isOutOfStock) {
      return Text(
        'Out of Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else if (widget.therapy.stock.isLowOnStock) {
      return Text(
        'Low on Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    } else {
      return Text(
        widget.therapy.stock.currentLevel.toString() + ' in Stock',
        style: TextStyle(
          fontSize: textSizeLargeMedium - 4,
          color: Colors.grey[700],
        ),
      );
    }
  }

  Future showRefillDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: RefillDialog(
                  manager: widget.manager, therapyForm: widget.therapy),
            ) //TODO complete this modal
        );
  }

  Future showEditStockDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: EditStockDialog(
                  manager: widget.manager, therapyForm: widget.therapy),
            ) //TODO complete this modal
        );
  }

  Future showEditAlarmDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: EditAlarmDialog(
                  manager: widget.manager, therapyForm: widget.therapy),
            ) //TODO complete this modal
        );
  }

  //     Future showEditWindowPopUp2(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => EditStockDialog(
  //           manager: widget.manager,
  //           therapyForm: widget.therapy) //TODO complete this modal
  //       );
  // }

  Stack _icons({MaterialColor color}) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: true ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.circle_filled,
            color: Colors.black,
            size: 23,
          ),
        ),
        AnimatedOpacity(
          opacity: true ? 1 : 0,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.circle_filled,
            color: color,
            size: 23,
          ),
        )
      ],
    );
  }

  String getLastReminderMessage() {
    final dayManager = Provider.of<DayPlanManager>(context, listen: false);
    if (widget.therapy.schedule == null ||
        widget.therapy.schedule.reminderRules.isEmpty) return null;
    List userRemindersLast =
        List.of(dayManager.getFinalRemindersList(date: DateTime.now()))
            .where((element) => element.therapyId == widget.therapy.id)
            .toList();
    for (int i = 1; i < 7 && userRemindersLast.isEmpty; i++) {
      userRemindersLast.addAll(dayManager
          .getFinalRemindersList(
              date: DateTime.now().subtract(Duration(days: i)))
          .where((element) => element.therapyId == widget.therapy.id)
          .toList());
    }
    userRemindersLast.sort((a, b) => a.time.compareTo(b.time));
    if (userRemindersLast.isEmpty) return null;
    Reminder lastReminder = userRemindersLast.first;

    return ' ${lastReminder.time.shortenDayRepresent().toLowerCase()} ${lastReminder.time.formatTime().toLowerCase()} ';
  }

  String getNextReminderMessage() {
    final dayManager = Provider.of<DayPlanManager>(context, listen: false);
    if (widget.therapy.schedule == null ||
        widget.therapy.schedule.reminderRules.isEmpty) return null;
    List userRemindersNext =
        List.of(dayManager.getFinalRemindersList(date: DateTime.now()))
            .where((element) => element.therapyId == widget.therapy.id)
            .toList();
    for (int i = 1; i < 7 && userRemindersNext.isEmpty; i++) {
      userRemindersNext.addAll(dayManager
          .getFinalRemindersList(date: DateTime.now().add(Duration(days: i)))
          .where((element) => element.therapyId == widget.therapy.id)
          .toList());
    }

    userRemindersNext.sort((a, b) => a.time.compareTo(b.time));

    if (userRemindersNext.isEmpty) return null;
    Reminder nextReminder = userRemindersNext.first;

    return '${nextReminder.time.shortenDayRepresent().toLowerCase()} ${nextReminder.time.formatTime().toLowerCase()}';

    /***
     *? So this is an Example. When we have proper ReminderState checks, we can 
      always show the most important ones next or missed or 'now.
      and if none found intoday, check next day. 
    

    */
  }
}

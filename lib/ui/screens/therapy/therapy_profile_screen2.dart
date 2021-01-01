import 'dart:ui';

import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/sub_models/reminder_rule.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/column_builder.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/components/edit_alarm_dialog.dart';
import 'package:diabetty/ui/screens/therapy/components/profile_custom_textfield.dart';
import 'package:diabetty/ui/screens/therapy/components/therapy_profile_reminder.dart';
import 'package:diabetty/extensions/index.dart';
import 'package:diabetty/ui/screens/therapy/edit_therapy_screen.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';

class TherapyProfileScreen2 extends StatefulWidget {
  final Therapy therapy;
  final DayPlanManager dayManager;
  final TherapyManager therapyManager;
  TherapyProfileScreen2({this.therapy, this.dayManager, this.therapyManager});

  @override
  _TherapyProfileScreen2State createState() => _TherapyProfileScreen2State();
}

class _TherapyProfileScreen2State extends State<TherapyProfileScreen2>
    with EditTherapyModalsMixin {
  @override
  Therapy get therapy => widget.therapy;
  TherapyManager therapyManager; //* not altered yet for teams

  DayPlanManager dayManager;

  Color textColor = Colors.white;
  bool readOnly;
  initState() {
    dayManager = widget.dayManager;
    therapyManager = widget.therapyManager;
    readOnly = therapy.userId !=
        Provider.of<AppContext>(context, listen: false).user.uid;
    super.initState();
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _buildHeader(context),
        Expanded(
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: _buildBody(size))),
        if (!readOnly) _buildFooter(size),
      ],
    );
  }

  Widget build(BuildContext context) {
    therapyManager ??= Provider.of<TherapyManager>(context, listen: true);

    return Scaffold(
      body: Stack(children: [
        _body(context),
        SafeArea(
          child: IntrinsicHeight(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: SubPageHeader(
                      text: !readOnly ? 'edit' : '',
                      saveFunction: !readOnly
                          ? () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        EditTherapyScreen(therapy: therapy)),
                              )
                          : null,
                      color: Colors.white,
                      backFunction: () => Navigator.pop(context),
                    ),
                  ))),
        ),
      ]),
    );
  }

  Widget _buildBody(Size size) {
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    if (widget.therapy.schedule?.reminderRules != null &&
        widget.therapy.schedule.reminderRules.isNotEmpty) {
      widget.therapy.schedule.reminderRules
        ..sort((ReminderRule a, ReminderRule b) =>
            a.time.applyTimeOfDay().compareTo(b.time.applyTimeOfDay()));
    }

    List<Widget> reminderRulesList = (widget.therapy.schedule?.reminderRules ==
                null ||
            widget.therapy.schedule.reminderRules.isEmpty)
        ? List()
        : widget.therapy.schedule.reminderRules
            .map((e) => TherapyProfileReminder(rule: e, therapy: widget.therapy)
                as Widget)
            .toList();

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 25, bottom: 5),
            child: _buildStockField()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              "scheduled reminders",
              fontSize: 13.0,
              textColor: Colors.black54,
            )
          ],
        ),
        if (reminderRulesList != null || reminderRulesList.isNotEmpty)
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

        // Padding(
        //   padding: EdgeInsets.only(top: 10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       text(
        //         "more info",
        //         fontSize: 16.0,
        //         textColor: Colors.grey[600],
        //       )
        //     ],
        //   ),
        // ),
        // Padding(padding: EdgeInsets.only(top: 10), child: _buildWindowField()),
        // _buildMinRestField(),
      ],
    );
  }

  Widget _buildStockField() {
    return ProfileCustomTextField(
      stackIcons: null,
      onTap: () => readOnly ? () {} : showEditStockDialog2(context),
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
    );
  }

  Widget _buildFooter(Size size) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height * 0.18),
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
              Flexible(
                flex: 1,
                child: _buildSilentColumn(size),
              ),
              Flexible(
                flex: 1,
                child: _buildRefillColumn(size),
              ),
              Flexible(
                flex: 1,
                child: _buildTakeColumn(size),
              )
            ],
          ),
        )));
  }

  Column _buildTakeColumn(Size size) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showTakenModal(context),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange[800],
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Center(
          child: text('take', //reminder.name,
              fontFamily: 'Regular',
              fontSize: 15.0,
              overflow: TextOverflow.ellipsis,
              textColor: Colors.orange[800]),
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
                color: Colors.orange[800],
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
              textColor: Colors.orange[800]),
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
                color: Colors.orange[800],
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
                textColor: Colors.orange[800]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String nextMessage = getNextReminderMessage() ?? '-';
    String lastMessage = getLastTakenMessage() ?? '-';
    return IntrinsicHeight(
      child: Container(
        width: size.width,
        constraints: BoxConstraints(minHeight: size.height * 0.30),
        padding: EdgeInsets.only(bottom: 10),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.deepOrange[800], Colors.deepOrange[700]]),
            border: Border(
              bottom: BorderSide(
                color:
                    Colors.transparent, // Color.fromRGBO(200, 100, 100, 0.4),
                width: 0.7,
              ),
            )),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.dashboard,
                color: Colors.transparent,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2), //was 5
                          margin: EdgeInsets.only(bottom: 8, right: 8),
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 0.5,
                                blurRadius: 1.5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            appearance_iconss[
                                widget.therapy.medicationInfo.appearanceIndex],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(widget.therapy.name.capitalizeBegins(),
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: textColor,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 17),
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
        ]),
      ),
    );
  }

  _getWindowMessage() {
    return (widget.therapy.schedule?.reminderRules == null ||
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

  //   Future showRefillDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //             child:
  //                 RefillDialog(manager: manager, therapyForm: widget.therapy),
  //           ) //TODO complete this modal
  //       );
  // }

  // Future showRefillDialog2(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //             child:
  //                 RefillDialog(manager: manager, therapyForm: widget.therapy),
  //           ) //TODO complete this modal
  //       );
  // }

  // Future showEditStockDialog2(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //             child: EditStockDialog(
  //                 manager: manager, therapyForm: widget.therapy),
  //           ) //TODO complete this modal
  //       );
  // }

  Future showEditAlarmDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: EditAlarmDialog(
                  manager: therapyManager, therapyForm: widget.therapy),
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

  String getLastTakenMessage() {
    dayManager ??= Provider.of<DayPlanManager>(context, listen: false);
    if (widget.therapy.schedule?.reminderRules == null ||
        widget.therapy.schedule.reminderRules.isEmpty) return null;
    List userRemindersLast =
        List.of(dayManager.getFinalRemindersList(date: DateTime.now()))
            .where((element) =>
                element.therapyId == widget.therapy.id && element.isComplete)
            .toList();
    for (int i = 1; i < 7 && userRemindersLast.isEmpty; i++) {
      userRemindersLast.addAll(dayManager
          .getFinalRemindersList(
              date: DateTime.now().subtract(Duration(days: i)))
          .where((element) =>
              element.therapyId == widget.therapy.id && element.isComplete)
          .toList());
    }

    userRemindersLast.sort((a, b) =>
        (a.rescheduledTime ?? a.time).compareTo(b.rescheduledTime ?? b.time));

    if (userRemindersLast.isEmpty) return null;
    Reminder lastReminder = userRemindersLast.last;

    return '${(lastReminder.takenAt).shortenDayRepresent().toLowerCase()} ${(lastReminder.takenAt).formatTime().toLowerCase()} ';
  } //! it can return null!!!!!!!! Error handle it, for no last taken

  String getNextReminderMessage() {
    dayManager ??= Provider.of<DayPlanManager>(context, listen: false);
    if (widget.therapy.schedule?.reminderRules == null ||
        widget.therapy.schedule.reminderRules.isEmpty) return null;
    List userRemindersNext =
        List.of(dayManager.getFinalRemindersList(date: DateTime.now()))
            .where((element) => element.therapyId == widget.therapy.id)
            .toList()
              ..retainWhere((element) =>
                  (element.rescheduledTime ?? element.time)
                      .isSameDayAs(DateTime.now()) &&
                  !element.isComplete &&
                  !element.isSkipped);
    for (int i = 1; i < 7 && userRemindersNext.isEmpty; i++) {
      userRemindersNext.addAll(dayManager
          .getFinalRemindersList(date: DateTime.now().add(Duration(days: i)))
          .where((element) => element.therapyId == widget.therapy.id)
          .toList()
            ..retainWhere((element) =>
                (element.rescheduledTime ?? element.time)
                    .isSameDayAs(DateTime.now().add(Duration(days: i))) &&
                !element.isComplete &&
                !element.isSkipped));
    }

    userRemindersNext.sort((a, b) =>
        (a.rescheduledTime ?? a.time).compareTo(b.rescheduledTime ?? b.time));

    if (userRemindersNext.isEmpty) return null;
    Reminder nextReminder = userRemindersNext.first;

    return '${(nextReminder.rescheduledTime ?? nextReminder.time).shortenDayRepresent().toLowerCase()} ${(nextReminder.rescheduledTime ?? nextReminder.time).formatTime().toLowerCase()} ';

    /***
     *? So this is an Example. When we have proper ReminderState checks, we can 
      always show the most important ones next or missed or 'now.
      and if none found intoday, check next day. 
    

    */
  }
}

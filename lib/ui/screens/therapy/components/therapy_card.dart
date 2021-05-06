import 'dart:math';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/extensions/index.dart';

class TherapyCard extends StatefulWidget {
  final Therapy therapy;

  TherapyCard({
    this.therapy,
  });

  @override
  _TherapyCardState createState() => _TherapyCardState();
}

class _TherapyCardState extends State<TherapyCard>
    with AutomaticKeepAliveClientMixin {
  bool sound = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String nextMessage = widget.therapy.isNeeded
        ? getLastTakenMessage()
        : getNextReminderMessage();
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: min(70, size.height * 0.07),
              maxHeight: max(70, size.height * 0.08),
              minWidth: size.width * 0.8,
              maxWidth: size.width * 0.95),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                /* BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1, 
                  blurRadius: 4, 
                  offset: Offset(0, -1), 
                ),*/
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(12), //?was 12, also like 10, 11
              ),
              //border: Border.all(color: Colors.black54, width: 0.05),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      appearance_iconss[
                          widget.therapy.medicationInfo.appearanceIndex],
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: max(6, size.height * 0.02),
                    width: 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[800],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(widget.therapy.name,
                        textColor: Colors.black,
                        fontFamily: fontMedium,
                        fontSize: 17.0,
                        overflow: TextOverflow.ellipsis),
                    if (nextMessage != null)
                      text(nextMessage,
                          textColor: Colors.black87,
                          fontFamily: fontMedium,
                          maxLine: 2,
                          fontSize: 11.0,
                          overflow: TextOverflow.ellipsis),
                    if (widget.therapy.stock != null &&
                        widget.therapy.stock.remind &&
                        widget.therapy.stock.isOutOfStock)
                      text('Out of Stock',
                          textColor: Colors.redAccent[700],
                          fontFamily: fontMedium,
                          maxLine: 2,
                          fontSize: 11.0,
                          overflow: TextOverflow.ellipsis)
                    else if (widget.therapy.stock != null &&
                        widget.therapy.stock.remind &&
                        widget.therapy.stock.isLowOnStock)
                      text(
                          'Low on Stock (${widget.therapy.stock.currentLevel.toString()} left)',
                          textColor: Colors.orange[900],
                          fontFamily: fontMedium,
                          maxLine: 2,
                          fontSize: 11.0,
                          overflow: TextOverflow.ellipsis),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigation/essentials/next.svg',
                          height: 15,
                          width: 15,
                          color: Colors.orange[800],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String getLastTakenMessage() {
    final dayManager = Provider.of<DayPlanManager>(context, listen: false);
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

    return 'last taken: ${(lastReminder.takenAt).shortenDayRepresent().toLowerCase()} ${(lastReminder.takenAt).formatTime().toLowerCase()} ';
  } //! it can return null!!!!!!!! Error handle it, for no last taken

  String getNextReminderMessage() {
    final dayManager = Provider.of<DayPlanManager>(context, listen: false);
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

    return 'next: ${(nextReminder.rescheduledTime ?? nextReminder.time).shortenDayRepresent().toLowerCase()} ${(nextReminder.rescheduledTime ?? nextReminder.time).formatTime().toLowerCase()} ';

    /***
     *? So this is an Example. When we have proper ReminderState checks, we can 
      always show the most important ones next or missed or 'now.
      and if none found intoday, check next day. 
    

    */
  }

  @override
  bool get wantKeepAlive => true;
}

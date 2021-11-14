import 'dart:async';

import 'dart:core';
import 'package:diabetty/blocs/mixins/reminder_manager_mixin.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:collection/collection.dart';
import 'package:diabetty/services/reminder.service.dart';

import 'package:diabetty/ui/screens/today/components/date_picker_widget.dart';
import 'package:diabetty/utils/notifcation._service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

import 'package:diabetty/extensions/string_extension.dart';

class DayPlanManager extends Manager with ReminderManagerMixin {
  Function dateAnimateFunction;

  TherapyManager therapyManager;

  AnimationController pushAnimation;
  AnimationController fadeAnimation;
  AnimationController minController;

  TimeOfDay initalTime;
  TimeOfDay _choosenTime;

  TimeOfDay get choosenTime => _choosenTime ?? initalTime;
  set choosenTime(TimeOfDay time) =>
      (time ?? initalTime).hour == initalTime.hour ? null : time;
  void resetTime() {
    if (inTheNow) return;
    _choosenTime = null;
    updateListeners();
  }

  bool get inTheNow => _choosenTime == null;
  void forwardTime() {
    if (choosenTime.hour == 12) return;
    _choosenTime = TimeOfDay(hour: (choosenTime.hour + 6) % 24, minute: 0);
  }

  void backTime() {
    if (choosenTime.hour == 0) return;
    _choosenTime = TimeOfDay(hour: (choosenTime.hour - 6) % 24, minute: 0);
  }

  void refresh() {
    _currentDateStamp = null;
    _choosenTime = null;
    updateListeners();
  }

  DatePickerController dateController = DatePickerController();
  DateTime _currentDateStamp;
  StreamController<List<Reminder>> _dataController = BehaviorSubject();

  ///* user reminders is only fetched reminders/data from store
  List<Reminder> _usersReminders = [];
  get userTherapies => (therapyManager?.usersTherapies) ?? List();

  DateTime get currentDateStamp => _currentDateStamp ?? DateTime.now();

  Stream _reminderStream() => reminderService.localStream();
  Stream get reminderStream => this._reminderStream();
  StreamSubscription _reminderStreamSub;

  Function dayScreenSetState;
  bool firstInit = true;

  set currentDateStamp(DateTime value) {
    if (value.isSameDayAs(DateTime.now()))
      _currentDateStamp = null;
    else
      _currentDateStamp = value;
    //dateChanges?.sink?.add(_currentDateStamp);
    notifyListeners();
  }

  @override
  void dispose() {
    _dataController.close();
    _reminderStreamSub.cancel();
    super.dispose();
  }

  @override
  void updateListeners() {
    therapyManager?.updateListeners();
    super.updateListeners();
  }

  DateTime lastGetRemindersTimeStamp;

  Future<List<Reminder>> getRemindersWithDateStamp() async {
    lastGetRemindersTimeStamp = DateTime.now();
    //   print('updatedLastGetReminders');
    return await ReminderService().getReminders();
  }
  // for when new reminders are saved and need notification reset

  Future<void> init(TherapyManager therapyMang) async {
    therapyManager = therapyMang;
    currentDateStamp = DateTime.now();

    _usersReminders = await getRemindersWithDateStamp() ?? [];
    await removeOuteDatedReminders();
    print('running init');
    if (therapyManager != null) {
      print('scheduled notifications');
      await scheduleNotifications();
    }

    firstInit = false;

    _reminderStreamSub = this._reminderStream().listen((event) async {
      // print('listened');
      if (event != null && event['id'] != null) {
        if (_usersReminders.length > 0) {
          Reminder updatedReminder = _usersReminders
              .firstWhere((element) => element.id == event['id'], orElse: () {
            return null;
          });
          Reminder newReminder = Reminder.fromJson(event);
          // print(' updated reminder ' + updatedReminder.id);
          if (updatedReminder != null &&
              newReminder.updatedAt != null &&
              (updatedReminder?.updatedAt?.isBefore(newReminder.updatedAt) ??
                  true)) {
            print('code 3');
            updatedReminder.loadFromJson(event);
            if (updatedReminder.prominentScheduledTime
                .isAfter(DateTime.now())) if (therapyManager != null)
              await scheduleNotifications();
          }
        } else {
          print('code 4');
          _usersReminders = await getRemindersWithDateStamp();
          await scheduleNotifications();

          //  if (therapyManager != null) await scheduleNotifications();
        }
      } else {
        print('test010 else ran'); //event.toString()
        Reminder tempReminder = Reminder.fromJson(event);
        if (lastGetRemindersTimeStamp == null ||
            (tempReminder.updatedAt?.isAfter(lastGetRemindersTimeStamp) ??
                false)) {
          print('case 1');
          _usersReminders = await getRemindersWithDateStamp();
          await scheduleNotifications();
        } else {
          //   print(
          //     'case 2  ${tempReminder.updatedAt}  - $lastGetRemindersTimeStamp');
          // _usersReminders = await getRemindersWithDateStamp();
        }
        //if (therapyManager != null) await scheduleNotifications();

        //  await scheduleNotifications();
      }
      _usersReminders ??= [];
      updateListeners();
    }, onDone: () => print('done'), onError: (error) => print('error'));
  }

  Future<void> removeOuteDatedReminders() async {
    _usersReminders?.forEach((reminder) async {
      if ((reminder.rescheduledTime ?? reminder.time)
          .isBefore(DateTime.now().subtract(Duration(days: 244))))
        await reminderService.deleteReminder(reminder);
    });
  }

  List<Reminder> getFinalRemindersList({DateTime date}) {
    date = date ?? currentDateStamp;
    // print('hererere123');

    // // print(_usersReminders);
    List<Reminder> finalReminders = getProjectedReminders(date: date);
    List<Reminder> fetchedReminders = _usersReminders
        .where((element) =>
            (element.rescheduledTime ?? element.time).isSameDayAs(date))
        .toList();
    fetchedReminders ??= List();
    finalReminders.removeWhere((element) {
      if (fetchedReminders.isEmpty) return false;
      return fetchedReminders.any((e) =>
          element.reminderRuleId == e.reminderRuleId &&
          element.time.isSameDayAs(e.time));
    });
    finalReminders.addAll(fetchedReminders);
    finalReminders.removeWhere((element) => element.isDeleted);

    return finalReminders;
  }

  List<Reminder> getProjectedReminders({DateTime date}) {
    date ??= currentDateStamp;
    List<Therapy> therapies = therapyManager?.usersTherapies ?? [];

    //// print(therapies.length);
    List<Reminder> projectedReminders = List();
    therapies
        .where((therapy) =>
            therapy.mode == "planned" &&
            therapy.schedule != null &&
            therapy.schedule.startDate.compareTo(date) <= 0 &&
            (therapy.schedule.endDate == null ||
                therapy.schedule.endDate.isAfter(date)))
        .forEach((therapy) {
      therapy.schedule?.reminderRules?.forEach((rule) {
        if (rule.isActiveOn(date))
          projectedReminders.add(Reminder.generated(therapy, rule, date));
      });
    });
    //// print(projectedReminders);
    return projectedReminders;
  }

  List<TimeSlot> sortRemindersByTimeSlots({DateTime date}) {
    date = date ?? currentDateStamp;
    List<Reminder> tempReminders = List.of(getFinalRemindersList(date: date))
      ..retainWhere((element) => element.isToday(date: currentDateStamp));
    List<TimeSlot> timeSlots = new List();

    if (tempReminders == null || tempReminders.length == 0) {
      return List();
    }
    for (Reminder reminder in tempReminders) {
      DateTime time = reminder.time.toSimpleDateTime();
      DateTime rescheduledTime = reminder.rescheduledTime.toSimpleDateTime();
      TimeSlot timeSlot;
      int slotIndex = getTimeSlotIndex(timeSlots, rescheduledTime ?? time);
      if (slotIndex == null) {
        timeSlot = new TimeSlot(rescheduledTime ?? time);
        timeSlots.add(timeSlot);
        timeSlot.reminders.add(reminder);
      } else {
        timeSlots[slotIndex].reminders.add(reminder);
      }
    }
    return timeSlots = orderTimeSlots(timeSlots)
      ..forEach((element) =>
          element.reminders.sort((a, b) => a.name.compareTo(b.name)));
  }

  int getTimeSlotIndex(List<TimeSlot> timeSlots, DateTime time) {
    int index = 0;
    for (var slot in timeSlots) {
      if (slot.time == time) {
        return index;
      }
      index++;
    }
    return null;
  }

  List<TimeSlot> orderTimeSlots(List<TimeSlot> original) {
    List<TimeSlot> timeSlots = List.of(original);
    //* no real need to make a copy in our situation

    timeSlots.sort((TimeSlot a, TimeSlot b) => a.time.compareTo(b.time));
    return timeSlots;
  }

  Map<String, GlobalKey> reminderScrollKeys = {};

  DateTime get lastReminderDate {
    List<Reminder> reminders = List.of(_usersReminders);
    reminders.sort((Reminder a, Reminder b) =>
        (a.rescheduledTime ?? a.time).compareTo(b.rescheduledTime ?? b.time));
    if (reminders.isEmpty) return null;
    return reminders.first.rescheduledTime ?? reminders.first.time;
  }

  Map<String, List<Reminder>> generateDayHistory(DateTime d) {
    DateTime date = d.toSimpleDateTime();
    Map<String, List<Reminder>> history = {};

    getFinalRemindersList(date: date).forEach((element) {
      history[element.name.toLowerCase()] ??= List();
      history[element.name.toLowerCase()].add(element);
    });
    return history;
  }

  // LIMIT HOW MANY NOTIFICATIONS IT CAN SET

  scheduleNotifications() async {
    print('test021 running notification');
    var _notifcationService = NotificationService();
    await _notifcationService.clearScheduledNotfications();
    List<Reminder> orderedSoonReminders = [];
    DateTime now = DateTime.now();
    int limitByDays = 10; //! reminder to put to 10
    for (int i = 0; i < limitByDays && orderedSoonReminders.length < 20; i++) {
      orderedSoonReminders.addAll(getFinalRemindersList(
              date: now.add(Duration(days: i)))
          ?.where((element) => !element.prominentScheduledTime.isBefore(now))
          ?.where((element) => !element.isComplete && !element.isDeleted)
          ?.where((element) => element.prominentScheduledTime.isBefore(now.add(
              Duration(
                  days:
                      limitByDays)))) //* unneccessary line since we have limit in the forloop
          ?.sortedBy((element) => element.prominentScheduledTime));
    }
    print(
        ' length ${orderedSoonReminders.length}  ${orderedSoonReminders.length > 0 ? orderedSoonReminders?.first?.prominentScheduledTime : '0'}');

    //? works fine till here. It doesnt even run that many times. why does it mess up from here?
    print('notificationtest06: running from here');
    int i = 0;
    for (Reminder reminder in orderedSoonReminders) {
      print('notificationTest06: $i ' +
          reminder.prominentScheduledTime.toString());
      await scheduleReminderNotifications(reminder, i);
      print('notificationtest06: done 1');
      i += 2;
      print('notificationTest06: $i');
    }
    print('notificationtest06: done 2');
  }

  scheduleReminderNotifications(Reminder reminder, int index) async {
    var _notifcationService = NotificationService();

    //print('test031  + $index ${reminder.prominentScheduledTime.toString()}');
    /*
      * set 2 notifications. 1 for the time. and one to tell them to take it soon before it is considered late. 
      * First: Ibiphro, body: take 2 ibiphro for 12.00.
      * Second: Hurry, You  are Late!, body: take 2 ibiphro before meal for 12.00.
      */
    var title1 = reminder.name.capitalizeBegins();
    var title2 = "Hurry, You Are Late!";
    var body1 =
        "Take ${reminder.dose} ${unitTypes[reminder.doseTypeIndex].plurarlUnits(reminder.dose)} ${reminder.advice != 0 ? intakeAdvice[reminder.advice].toLowerCase() + ' ' : ''}for ${reminder.prominentScheduledTime.formatTime().toLowerCase().replaceAll(' ', '')}";
    var body2 =
        "Take ${reminder.dose} ${unitTypes[reminder.doseTypeIndex].plurarlUnits(reminder.dose)} ${reminder.name.capitalizeBegins()} ${reminder.advice != 0 ? intakeAdvice[reminder.advice].toLowerCase() + ' ' : ''}for ${reminder.prominentScheduledTime.formatTime().toLowerCase().replaceAll(' ', '')}";

    await _notifcationService.scheduleNotfication(
        id: index,
        scheduledDate: reminder.prominentScheduledTime,
        body: body1,
        title: title1);
    await _notifcationService.scheduleNotfication(
        id: index + 1,
        scheduledDate: reminder.prominentScheduledTime
            .add(reminder.window ?? Duration(minutes: 20)),
        body: body2,
        title: title2);
  }
}

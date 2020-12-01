import 'dart:async';
import 'dart:core';
import 'package:diabetty/blocs/mixins/reminder_manager_mixin.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/user.repository.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/screens/today/components/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:diabetty/models/timeslot.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/extensions/datetime_extension.dart';

class DayPlanManager extends Manager with ReminderManagerMixin {
  DayPlanManager({
    @required this.appContext,
  });

  final AppContext appContext;
  TherapyManager therapyManager;

  String get uid => this.appContext.user?.uid;

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
  List<Reminder> usersReminders = List();
  get userTherapies => (therapyManager?.usersTherapies) ?? List();

  DateTime get currentDateStamp => _currentDateStamp ?? DateTime.now();

  Stream<List<Reminder>> _reminderStream() =>
      reminderService.reminderStream(uid);
  Stream<List<Reminder>> get reminderStream => this._reminderStream();

  set currentDateStamp(DateTime value) {
    if (value.isSameDayAs(DateTime.now()))
      _currentDateStamp = null;
    else
      _currentDateStamp = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _dataController.close();

    super.dispose();
  }

  @override
  Future<void> init() async {
    super.init();
    currentDateStamp = DateTime.now();
    if (uid != null) {
      try {
        usersReminders = await reminderService.getReminders(uid, local: true);
      } catch (e) {}
      this._reminderStream().listen((event) async {
        // usersReminders = event ?? usersReminders;
        // if (event.isNotEmpty) updateListeners();
      });
    }
  }

  List<Reminder> getFinalRemindersList({DateTime date}) {
    date = date ?? currentDateStamp;
    List<Reminder> finalReminders = getProjectedReminders(date: date);
    List<Reminder> fetchedReminders = usersReminders
        .where((element) => element.time.isSameDayAs(date))
        .toList();
    finalReminders.removeWhere((element) {
      return fetchedReminders
          .any((e) => element.reminderRuleId == e.reminderRuleId);
    });
    finalReminders.addAll(fetchedReminders);
    return finalReminders;
  }

  List<Reminder> getProjectedReminders({DateTime date}) {
    date ??= currentDateStamp;
    List<Therapy> therapies = List.of(therapyManager.usersTherapies);
    //print(therapies.length);
    List<Reminder> projectedReminders = List();
    therapies
        .where((therapy) =>
            therapy.mode == "planned" &&
            therapy.schedule != null &&
            therapy.schedule.startDate.compareTo(DateTime.now()) <= 0 &&
            (therapy.schedule.endDate == null ||
                therapy.schedule.endDate.isAfter(DateTime.now())))
        .forEach((therapy) {
      therapy.schedule?.reminderRules?.forEach((rule) {
        if (rule.isActiveOn(date))
          projectedReminders.add(Reminder.generated(therapy, rule, date));
      });
    });
    //print(projectedReminders);
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
}

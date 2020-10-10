import 'dart:async';
import 'dart:core';
import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/screens/today/components/date_picker.widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:diabetty/models/timeslot.model.dart';

class DayPlanManager extends ChangeNotifier {
  DayPlanManager({
    @required this.appContext,
  });

  final AppContext appContext;

  StreamController<List<Reminder>> _dataController = BehaviorSubject();
  List<Reminder> usersReminders = List();

  AnimationController pushAnimation;

  DatePickerController dateController = DatePickerController();
  DateTime _currentDateStamp = DateTime.now();

  List<Therapy> therapies = List();

  DateTime get currentDateStamp => _currentDateStamp;

  set currentDateStamp(value) {
    _currentDateStamp = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _dataController.close();
    super.dispose();
  }

  Sink<List<Reminder>> get dataSink => _dataController.sink;
  Stream<List<Reminder>> get dataStream => _dataController.stream;

  void _getData() async {
    return;
  }

  void init() async {
    _currentDateStamp = DateTime.now();

    if (usersReminders == null) {
      return _getData();
    }
  }

  //First Fetch all Data

  List<Reminder> getFinalRemindersList({DateTime date}) {
    date = date ?? currentDateStamp;
    //* first we need project reminders
  }

  List<Reminder> getProjectedReminders({DateTime date}) {
    date = date ?? currentDateStamp;
    List<Therapy> therapies = List();

    List<Reminder> projectedReminders = List();
    therapies.map((therapy) {
      therapy.schedule.reminders.map((rule) {
        if (rule.activeOn(date))
          projectedReminders
              .add(Reminder.generated(therapy: therapy, rule: rule));
      });
    });
  }

  List<TimeSlot> getRemindersByTimeSlots({DateTime date}) {
    date = date ?? currentDateStamp;

    List<Reminder> tempReminders = List.from(usersReminders)
      ..retainWhere((element) => element.isToday(date: currentDateStamp));
    //** now we have a list of all the FETCHED Reminders for the current timestamp */

    List<TimeSlot> timeSlots = new List();

    print(usersReminders.length);
    if (tempReminders == null || tempReminders.length == 0) {
      return List();
    }
    for (Reminder reminder in tempReminders) {
      DateTime time = reminder.getDateTimeAs12hr;
      TimeSlot timeSlot;
      int slotIndex = getTimeSlotIndex(timeSlots, time);
      if (slotIndex == null) {
        timeSlot = new TimeSlot(time);
        timeSlots.add(timeSlot);
        timeSlot.reminders.add(reminder);
      } else {
        timeSlots[slotIndex].reminders.add(reminder);
      }
    }
    return timeSlots = orderTimeSlots(timeSlots);
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
    List<TimeSlot> timeSlots = List.from(original);
    //* no real need to make a copy in our situation

    timeSlots.sort((TimeSlot a, TimeSlot b) => a.time.compareTo(b.time));
    return timeSlots;
  }
}

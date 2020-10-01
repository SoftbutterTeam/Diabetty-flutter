import 'dart:async';
import 'dart:core';

import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayPlanManager {
  DayPlanManager({@required this.appContext, @required this.isLoading});

  final ValueNotifier<bool> isLoading;
  final AppContext appContext;

  StreamController<List<Reminder>> _dataController = StreamController();
  List<Reminder> usersReminders;
  List<Reminder> get uusersReminders =>
      null; //RemindersRepository.fetchRecentReminders(); 90daysback,50days ahead

  void dispose() {
    _dataController.close();
  }

  Sink<List<Reminder>> get dataSink => _dataController.sink;
  Stream<List<Reminder>> get dataStream => _dataController.stream;

  void _getData() async {
    //*mock data generation
    usersReminders = List();
    List<String> advice = List();
    advice.add('before a meal');
    for (var i = 0; i < 8; i++) {
      usersReminders.add(new Reminder(
          name: 'test',
          time: DateTime.now().add(Duration(hours: i)),
          dose: 2,
          advice: advice));
    }
    _dataController.add(usersReminders);
  }

  void init() async {
    if (usersReminders == null) {
      return _getData();
    }
  }

  Future<void> refresh() async {
    return _getData();
  }

  List<TimeSlot> getRemindersByTimeSlots() {
    List<Reminder> tempReminders = List.from(usersReminders);
    List<TimeSlot> timeSlots = new List();
    print(usersReminders.length);
    if (tempReminders == null || tempReminders.length == 0) {
      return List();
    }
    for (Reminder reminder in tempReminders) {
      DateTime time = reminder.getTime;
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

class TimeSlot {
  DateTime time;
  List<Reminder> reminders = new List();
  TimeSlot(this.time);
}
import 'dart:async';

import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';

class TherapyManager {
  TherapyManager({@required this.appContext});

  ValueNotifier<bool> isLoading;
  final AppContext appContext;

  StreamController<List<Therapy>> _dataController = StreamController();

  List<Therapy> usersTherapies;

  Therapy therapyForm;

  void resetForm() {
    therapyForm = new Therapy();
  }

  void dispose() {
    _dataController.close();
  }

  Sink<List<Therapy>> get dataSink => _dataController.sink;
  Stream<List<Therapy>> get dataStream => _dataController.stream;

  void init() async {
    if (usersTherapies == null) {
      return _getData();
    }
  }

  void _getData() async {
    var result = await this.appContext.getTherapies();
    if (result.isSuccess) {
      dataSink.add(result.data);
    } else {
      usersTherapies = [];
      _dataController.addError(result.exception, result.stackTrace);
    }
  }

  Future<void> refresh() async {
    return _getData();
  }

  Future<void> addTherapy(AddTherapyForm addForm) {}
}

class AddTherapyForm {
  String name;
  int strength;
  String units;
  List<String> intakeAdvice;
  String apperanceURL;
  Duration minRest;
  String mode;
  List<ReminderRule> reminderRules;
  AlarmSettings settings;
  int stock;

  AddTherapyForm(
      {this.name,
      this.strength,
      this.units,
      this.intakeAdvice,
      this.apperanceURL,
      this.minRest,
      this.mode,
      this.reminderRules,
      this.settings,
      this.stock});
}

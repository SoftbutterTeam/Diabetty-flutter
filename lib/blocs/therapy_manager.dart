import 'dart:async';

import 'package:diabetty/models/reminder.model.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';

class TherapyManager extends ChangeNotifier {
  TherapyManager({@required this.appContext});
  TheraphyService theraphyService = TheraphyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;

  StreamController<List<Therapy>> _dataController = StreamController();

  List<Therapy> usersTherapies;

  AddTherapyForm therapyForm;

  void resetForm() {
    therapyForm = new AddTherapyForm();
  }

  void updateListeners() {
    notifyListeners();
  }

  @override
  void dispose() {
    _dataController.close();
    super.dispose();
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

  Future<bool> sumbitAddTherapy(AddTherapyForm addForm) async {
    try {
      await theraphyService.addTherapy(addForm.toTherapy());
    } catch (e) {
      rethrow;
    }
  }
}

class AddTherapyForm {
  String name;
  int strength;
  String units;
  String intakeAdvice;
  int apperanceIndex;
  Duration minRest;
  String mode;
  List<ReminderRule> reminderRules = List();
  AlarmSettings settings;
  int stock;

  AddTherapyForm(
      {this.name,
      this.strength,
      this.units,
      this.intakeAdvice,
      this.apperanceIndex,
      this.minRest,
      this.mode,
      this.settings,
      this.stock});

  Therapy toTherapy() {
    return Therapy(
        mode: this.mode,
        stock: this.stock,
        name: this.name,
        medicationInfo: MedicationInfo(
            appearance: this.apperanceURL,
            intakeAdvice: List<String>()..add(this.intakeAdvice),
            name: this.name,
            strength: this.strength,
            unit: this.units,
            restDuration: this.minRest),
        schedule: Schedule(reminders: this.reminderRules));
  }

  //TODO settings
  //TODO intake advice should be a list
}

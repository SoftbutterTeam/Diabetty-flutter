import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class TherapyManager extends Manager {
  TherapyManager();
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  List<Therapy> usersTherapies = [];

  AddTherapyForm therapyForm;

  Therapy therapy;

  Stream _therapyStream() => therapyService.localStream();

  Stream get therapyStream => this._therapyStream();
  //Stream get therapyStream => therapyService.localStream();
  void resetForm() => therapyForm = new AddTherapyForm();
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    //// print('Therapy Init is runnning');
    try {
      usersTherapies = await therapyService.getTherapies(local: true);
    } catch (e) {}
    this._therapyStream().listen((event) async {
      usersTherapies = await therapyService.getTherapies();
//        updateListeners();
      usersTherapies.forEach((element) {
        // // print(element.toJson());
      });
      // updateListeners();
      // usersTherapies ??= List();
    });
  }

  Future<void> submitAddTherapy(AddTherapyForm addForm) async {
    try {
      Therapy therapy = addForm.toTherapy();
      //// print(therapy.userId);
      await therapyService.addTherapy(therapy);
    } catch (e) {
      // print(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTherapy(Therapy therapy) async {
    try {
      await therapyService.deleteTherapy(therapy);
      updateListeners();
    } catch (e) {
      // print(e.toString());
      rethrow;
    }
  }
}

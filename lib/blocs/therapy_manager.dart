import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class TherapyManager extends Manager {
  TherapyManager({@required this.appContext});
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  AuthService authService;
  List<Therapy> usersTherapies = [];
  String get uid => this.appContext.user?.uid;

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
    super.init();
    //print('Therapy Init is runnning');
    authService = appContext.authService;
    if (uid != null) {
      try {
        usersTherapies = await therapyService.getTherapies(uid, local: true);
      } catch (e) {}
      this._therapyStream().listen((event) async {
        usersTherapies = await therapyService.getTherapies(uid);
//        updateListeners();
        usersTherapies.forEach((element) {
          // print(element.toJson());
        });
        // updateListeners();
        // usersTherapies ??= List();
      });
    }
  }

  Future<void> submitAddTherapy(AddTherapyForm addForm) async {
    try {
      Therapy therapy = addForm.toTherapy();
      therapy.userId = uid;
      //print(therapy.userId);
      await therapyService.addTherapy(therapy);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}

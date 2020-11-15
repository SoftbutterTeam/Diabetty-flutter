import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class TherapyManager extends Manager {
  TherapyManager({@required this.appContext});
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  AuthService authService;
  List<Therapy> usersTherapies = List();
  String get uid => this.appContext.user?.uid;

  AddTherapyForm therapyForm;

  Stream<List<Therapy>> _therapyStream() => therapyService.therapyStream(uid);

  Stream<List<Therapy>> get therapyStream => this._therapyStream();
  void resetForm() => therapyForm = new AddTherapyForm();

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    super.init();
    //print('Therapy Init is runnning');
    authService = appContext.authService;
    if (uid != null) {
      usersTherapies = await therapyService.getTherapies(uid, local: true);
      this._therapyStream().listen((event) async {
        usersTherapies = event;
        usersTherapies ??= List();
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
      //print(e.toString());
      rethrow;
    }
  }
}

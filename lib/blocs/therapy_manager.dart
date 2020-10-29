import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/blocs/manager_abstract.dart';

class TherapyManager extends Manager {
  TherapyManager({@required this.appContext});
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  AuthService authService;
  List<Therapy> usersTherapies = List();
  String uid;

  StreamController<List<Therapy>> _dataController = StreamController();

  AddTherapyForm therapyForm;

  Stream<List<Therapy>> _therapyStream() =>
      therapyService.therapyStream(this.appContext.user.uid);

  Stream<List<Therapy>> get therapyStream => this._therapyStream();
  void resetForm() => therapyForm = new AddTherapyForm();
  void updateListeners() => notifyListeners();

  @override
  void dispose() {
    _dataController.close();
    super.dispose();
  }

  void init() async {
    super.init();
    print('Init is runnning');
    authService = appContext.authService;
    this.uid = appContext.user?.uid;
    //usertherapies = [therapyService.getTherapies(uid))
    this._therapyStream().listen((event) async {
      usersTherapies = event;
      usersTherapies ??= List();
      print('Listennn');
    });
  }

  Future<void> submitAddTherapy(AddTherapyForm addForm) async {
    try {
      Therapy therapy = addForm.toTherapy();
      therapy.userId = appContext.user.uid;
      print(therapy.userId);
      await therapyService.addTherapy(therapy);
    } catch (e) {
      print('herrrre');
      print(e.toString());
      rethrow;
    }
  }
}

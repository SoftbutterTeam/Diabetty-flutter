import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/medication_info.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/models/therapy/alarmsettings.model.dart';
import 'package:diabetty/models/therapy/reminder_rule.model.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';

class TherapyManager extends ChangeNotifier {
  TherapyManager({@required this.appContext, @required this.authService});
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  final AuthService authService;
  List<Therapy> usersTherapies;
  String uid;

  StreamController<List<Therapy>> _dataController = StreamController();

  AddTherapyForm therapyForm;

  Stream<List<Therapy>> _therapyStream() {
    return therapyService.therapyStream(this.appContext.user.uid);
  }

  Stream<List<Therapy>> get therapyStream {
    return this._therapyStream();
  }

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

  void init() async {
    this.uid = appContext.user.uid;
    this._therapyStream().listen((event) async {
      print('Listennn');
    });
  }

  Future<bool> sumbitAddTherapy(AddTherapyForm addForm) async {
    try {
      Therapy therapy = addForm.toTherapy();
      therapy.userId = appContext.user.uid;
      print(therapy.userId);
      await therapyService.addTherapy(therapy);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}

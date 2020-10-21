import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/material.dart';

class TherapyManager extends ChangeNotifier {
  TherapyManager({@required this.appContext, @required this.authService});
  TherapyService therapyService = TherapyService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  final AuthService authService;

  StreamController<List<Therapy>> _dataController = StreamController();

  List<Therapy> usersTherapies;

  AddTherapyForm therapyForm;

  Stream<List<Therapy>> get therapyStream {
    return therapyService.therapyStream;
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

  Sink<List<Therapy>> get dataSink => _dataController.sink;
  Stream<List<Therapy>> get dataStream => _dataController.stream;

  void init() async {
    if (usersTherapies == null) {
      await _getData();
    }
  }

//   StreamSubscription<T> listen (
// void onData(
// T event
// ),
// {Function? onError,
// void onDone(),
// bool? cancelOnError}
// )

  Future<void> _getData() async {
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
      await therapyService.addTherapy(addForm.toTherapy());
    } catch (e) {
      rethrow;
    }
  }
}

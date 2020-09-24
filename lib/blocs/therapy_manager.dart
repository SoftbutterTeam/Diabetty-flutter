import 'dart:async';

import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';

class TherapyManager {
  TherapyManager({@required this.appContext, @required this.isLoading});

  final ValueNotifier<bool> isLoading;
  final AppContext appContext;

  StreamController<List<Therapy>> _dataController = StreamController();

  List<Therapy> usersTherapies;

  void dispose() {
    _dataController.close();
  }

  Sink<List<Therapy>> get dataSink => _dataController.sink;
  Stream<List<Therapy>> get dataStream => _dataController.stream;

  void _getData() async {
    var result = await this.appContext.getTherapies();
    if (result.isSuccess) {
      // = result.data;
      dataSink.add(result.data);
    } else {
      usersTherapies = [];
      _dataController.addError(result.exception, result.stackTrace);
    }
  }

  void init() async {
    if (usersTherapies == null) {
      return _getData();
    }
  }

  Future<void> refresh() async {
    return _getData();
  }
}

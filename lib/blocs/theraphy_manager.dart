import 'dart:async';

import 'package:diabetty/models/theraphy.model.dart';
import 'package:diabetty/system/app_context.dart';

class TheraphyManager {
  final AppContext appContext;

  StreamController<List<Theraphy>> _dataController = StreamController();

  List<Theraphy> usersTheraphies;

  TheraphyManager(this.appContext);

  void dispose() {
    _dataController.close();
  }

  Sink<List<Theraphy>> get dataSink => _dataController.sink;
  Stream<List<Theraphy>> get dataStream => _dataController.stream;

  void _getData() async {
    var result = await this.appContext.getTheraphies();
    if (result.isSuccess) {
      // = result.data;
      dataSink.add(result.data);
    } else {
      usersTheraphies = [];
      _dataController.addError(result.exception, result.stackTrace);
    }
  }

  void init() async {
    if (usersTheraphies == null) {
      return _getData();
    }
  }

  Future<void> refresh() async {
    return _getData();
  }
}

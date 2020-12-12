import 'package:diabetty/blocs/app_context.dart';
import 'package:flutter/material.dart';

abstract class Manager extends ChangeNotifier {
  @protected
  get appContext;

  @mustCallSuper
  dynamic init() {
    if (!this.appContext.systemManagerBlocs.any((element) => element == this))
      this.appContext.systemManagerBlocs.add(this);
  }

  void updateListeners() => notifyListeners();
}

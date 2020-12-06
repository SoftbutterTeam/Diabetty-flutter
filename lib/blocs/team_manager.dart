import 'dart:async';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class TeamManager extends Manager {
  TeamManager({@required this.appContext});

  final AppContext appContext;
  AuthService authService;

  String get uid => this.appContext.user?.uid;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    super.init();

    authService = appContext.authService;
    if (uid != null) {
      try {} catch (e) {}
    }
  }
}

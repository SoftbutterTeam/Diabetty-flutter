import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/teams/relationship.dart';
import 'package:diabetty/models/user.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/authentication/auth_service/user.service.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/services/team.service.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:share/share.dart';

class TeamManager extends Manager {
  TeamManager({@required this.appContext});
  TeamService teamService = TeamService();

  final AppContext appContext;
  AuthService authService;

  String get uid => this.appContext.user?.uid;

  List<Contract> usersContracts = List();
  Stream<QuerySnapshot> get relationStream => teamService.relationsStream(uid);

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    super.init();

    authService = appContext.authService;

    if (uid != null) {
      try {
        usersContracts = await teamService.getContracts(uid, local: true);
        relationStream.listen((event) async {
          if (event == null || event.documents.isEmpty)
            return usersContracts = List();
          usersContracts = await teamService.getContracts(uid);
        });
      } catch (e) {}
    }
  }

  Future<void> cleanOutReminders() async {
    // delete ones without confirmation, created more than a week ago.
  }

  // Returns reason is fail ,null if pass
  Future<String> requestToSupport(String phoneno) async {
    String phoneStr = phoneno;
    String searchUserUid = await UserService().findUidByPhone(phoneStr);
    if (searchUserUid == null) return 'no user found';
    if (searchUserUid == uid) return 'you cannot support yourself';

    bool cond = usersContracts.any((e) {
      return e.supporteeId == searchUserUid;
    });
    if (cond) return 'already added';

    TeamService().createContract(uid, searchUserUid);
    return null;
  }

  void shareSupportInviteToApp() {
    Share.share('check out my website https://example.com',
        subject: 'Look what I made!');
  }
}

import 'dart:async';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/journal.service.dart';
import 'package:diabetty/services/therapy.service.dart';
import 'package:diabetty/system/app_context.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class DiaryBloc extends Manager {
  DiaryBloc({@required this.appContext});
  JournalService journalService = JournalService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  AuthService authService;
  List<Journal> usersJournals = List();
  String get uid => this.appContext.user?.uid;

  Stream<List<Journal>> get journalStream => journalService.journalStream(uid);
  Journal newJournal;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    super.init();
    //print('Diary Init is runnning');
    authService = appContext.authService;
    if (uid != null) {
      usersJournals = await journalService.getJournals(uid, local: true);
      this.journalStream.listen((event) async {
        usersJournals = event;
        usersJournals ??= List();
      });
    }
  }

  Future<void> submitNewJournal(Journal newJournal) async {
    try {
      newJournal.userId = uid;
      await journalService.addJournal(newJournal);
    } catch (e) {
      //print(e.toString());
      //rethrow;
    }
  }

  void resetAddJournalForm() => newJournal = new Journal();
}

import 'dart:async';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/journal.service.dart';
import 'package:diabetty/blocs/app_context.dart';
import 'package:diabetty/ui/screens/diary/mixins/journal_action.mixin.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class DiaryBloc extends Manager with JournalActionsMixin {
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

  @override
  // TODO: implement journal
  Journal get journal => throw UnimplementedError();

  Future<void> saveJournalEntry(JournalEntry journalNotes) async {
    //journalService.addJournal(journalNotes);
  }
}

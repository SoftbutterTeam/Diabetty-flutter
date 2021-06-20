import 'dart:async';
import 'package:diabetty/blocs/mixins/journalentry_manager.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:diabetty/services/journal.service.dart';
import 'package:diabetty/blocs/app_context.dart';

import 'package:flutter/material.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class DiaryBloc extends Manager with journalEntryManagerMixin {
  DiaryBloc({@required this.appContext});
  JournalService journalService = JournalService();

  ValueNotifier<bool> isLoading;
  final AppContext appContext;
  AuthService authService;
  List<Journal> usersJournals = List();
  String get uid => this.appContext.user?.uid;

  Stream get journalStream => journalService.localStream();
  Stream getJournalEntriesStream(Journal journal) =>
      journalEntryService.journalEntriesStream(uid, journal)
        ..listen((event) async {
          journal.journalEntries = await fetchJournalEntries(journal);
        });

  Journal newJournal;

  @override
  void dispose() {
    super.dispose();
  }

  updateListeners() => super.updateListeners();
  Future<void> init() async {
    super.init();
    //print('Diary Init is runnning');
    authService = appContext.authService;
    if (uid != null) {
      try {
        usersJournals = await journalService.getJournals(uid);
      } catch (e) {}
      this.journalStream.listen((event) async {
        if (event != null && event['id'] != null) {
          if (usersJournals.length > 0)
            usersJournals
                ?.firstWhere((element) =>
                    element.id == event['id'] && event['id'] != null)
                ?.loadFromJson(event);
        } else {
          usersJournals = await journalService.getJournals(uid);
        }
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

  Future<List<JournalEntry>> fetchJournalEntries(Journal journal) async {
    try {
      return await journalEntryService.getjournalEntrys(uid, journal.id,
          local: true);
    } catch (e) {
      print('je Errro');
      print(e);
    }
  }

  void deleteJournal(Journal journal) async {
    await journalService.deleteJournal(journal);

    updateListeners();
  }
}

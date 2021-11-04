import 'dart:async';
import 'package:diabetty/blocs/mixins/journalentry_manager.bloc.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/services/journal.service.dart';

import 'package:flutter/material.dart';
import 'package:diabetty/blocs/abstracts/manager_abstract.dart';

class DiaryBloc extends Manager with JournalEntryManagerMixin {
  DiaryBloc();
  JournalService journalService = JournalService();

  ValueNotifier<bool> isLoading;
  List<Journal> usersJournals = List();

  Stream get journalStream => journalService.localStream();
  Stream getJournalEntriesStream(Journal journal) =>
      journalEntryService.journalEntriesStream(journal)
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
    try {
      usersJournals = await journalService.getJournals();
    } catch (e) {}
    this.journalStream.listen((event) async {
      if (event != null && event['id'] != null) {
        if (usersJournals.length > 0)
          usersJournals
              ?.firstWhere(
                  (element) => element.id == event['id'] && event['id'] != null)
              ?.loadFromJson(event);
      } else {
        usersJournals = await journalService.getJournals();
      }
    });
  }

  Future<void> submitNewJournal(Journal newJournal) async {
    try {
      await journalService.addJournal(newJournal);
    } catch (e) {
      //// print(e.toString());
      //rethrow;
    }
  }

  void resetAddJournalForm() => newJournal = new Journal();

  Future<List<JournalEntry>> fetchJournalEntries(Journal journal) async {
    try {
      return await journalEntryService.getjournalEntries(journal.id,
          local: true);
    } catch (e) {
      // print('je Errro');
      // print(e);
      return null;
    }
  }

  void deleteJournal(Journal journal) async {
    await journalService.deleteJournal(journal);

    updateListeners();
  }
}

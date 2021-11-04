import 'package:diabetty/blocs/abstracts/manager_abstract.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabetty/services/journalEntry.service.dart';

abstract class JournalEntryManagerMixin<T extends Manager> {
  JournalEntryService journalEntryService = JournalEntryService();

  @protected
  void updateListeners();
  @protected
  TherapyManager therapyManager;

  Future<void> saveJournalEntry(JournalEntry journalEntry,
      {update = true}) async {
    journalEntry.createdAt ??= DateTime.now();
    journalEntry.date ??= DateTime.now();
    await journalEntryService.savejournalEntry(journalEntry);
    if (update) updateListeners();
  }

  Future<void> deletejournalEntry(JournalEntry journalEntry) async {
    await journalEntryService.deletejournalEntry(journalEntry);

    updateListeners();
  }
}

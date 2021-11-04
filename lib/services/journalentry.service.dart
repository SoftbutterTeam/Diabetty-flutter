import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/repositories/local_repositories/journalentry.local.repository.dart';

class JournalEntryService {
  JournalEntryRepository journalEntryRepo = JournalEntryRepository();

  Future<void> updatejournalEntry(JournalEntry journalEntry) async {
    try {
      journalEntryRepo.updateEntry(journalEntry);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> savejournalEntry(JournalEntry journalEntry) async {
    try {
      journalEntryRepo.setEntry(journalEntry);
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<void> deletejournalEntry(JournalEntry journalEntry) async {
    try {
      journalEntryRepo.deleteEntry(journalEntry);
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<List<JournalEntry>> getjournalEntries(String journalId,
      {bool local: false}) async {
    try {
      final journalEntrys =
          (await journalEntryRepo.getAllEntrys(journalId, local: local)).data;
      if (journalEntrys == null) {
        return List();
      }
      return journalEntrys.map<JournalEntry>((json) {
        JournalEntry journalEntry = JournalEntry();
        journalEntry.id = json['id'];
        return journalEntry..loadFromJson(json);
      }).toList();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Stream journalEntriesStream(Journal journal) {
    return journalEntryRepo.onStateChanged(journal.id);
  }
}

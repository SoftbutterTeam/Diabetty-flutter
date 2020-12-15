import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal_entry.model.dart';
import 'package:diabetty/repositories/journal.repository.dart';
import 'package:diabetty/repositories/journalEntry.repository.dart';

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
      print(e);
      return null;
    }
  }

  Future<void> deletejournalEntry(JournalEntry journalEntry) async {
    try {
      journalEntryRepo.deleteEntry(journalEntry);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<JournalEntry>> getjournalEntrys(String uid, String journalId,
      {bool local: false}) async {
    try {
      final journalEntrys =
          (await journalEntryRepo.getAllEntrys(uid, journalId, local: local))
              .data;
      if (journalEntrys == null) {
        return List();
      }
      return journalEntrys.map<JournalEntry>((json) {
        JournalEntry journalEntry = JournalEntry();
        journalEntry.id = json['id'];
        return journalEntry..loadFromJson(json);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<JournalEntry>> journalEntriesStream(String uid, journalId) {
    return journalEntryRepo
        .onStateChanged(uid, journalId)
        .map(_journalEntryListFromSnapshop);
  }

  List<JournalEntry> _journalEntryListFromSnapshop(QuerySnapshot snapshot) {
    return snapshot.documents.map<JournalEntry>((doc) {
      JournalEntry journalEntry = JournalEntry();
      journalEntry.id = doc.documentID;
      doc.data['id'] = journalEntry.id;
      journalEntry.loadFromJson(doc.data);

      return journalEntry;
    }).toList();
  }
}

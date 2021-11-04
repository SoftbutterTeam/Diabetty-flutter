import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/repositories/local_repositories/journal.local.repository.dart';

class JournalService {
  JournalRepository journalRepo = JournalRepository();

  Future<bool> addJournal(Journal journal) async {
    try {
      await journalRepo.createJournal(journal);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteJournal(Journal journal) async {
    try {
      await journalRepo.deleteJournal(journal);
      return true;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<List<Journal>> getJournals({bool local = false}) async {
    final journals = (await journalRepo.getAllJournals(local: local)).data;
    if (journals == null) {
      return List();
    }
    return journals.map<Journal>((json) {
      Journal journal = Journal();
      journal.id = json['id'];
      return journal..loadFromJson(json);
    }).toList();
  }

  Stream localStream() {
    return journalRepo.onStateChanged();
  }

  Future<void> saveJournal(Journal journal) async {
    try {
      await journalRepo.updateJournal(journal);
      return true;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}

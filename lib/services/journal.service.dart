import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/journal/journal.model.dart';
import 'package:diabetty/repositories/journal.repository.dart';

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

  Future<List<Journal>> getJournals(String uid, {bool local = false}) async {
    final journals = (await journalRepo.getAllJournals(uid, local: local)).data;
    if (journals == null) {
      return List();
    }
    return journals.map<Journal>((json) {
      Journal journal = Journal();
      journal.id = json['id'];
      return journal..loadFromJson(json);
    }).toList();
  }

  Stream<List<Journal>> journalStream(String uid) {
    return journalRepo.onStateChanged(uid).map(_journalListFromSnapshop);
  }

  List<Journal> _journalListFromSnapshop(QuerySnapshot snapshot) {
    //print('hera');
    //print(snapshot.documents.length);
    return snapshot.documents.map<Journal>((doc) {
      Journal journal = Journal();
      journal.id = doc.documentID;
      journal.loadFromJson(doc.data);
      return journal;
    }).toList();
  }
}

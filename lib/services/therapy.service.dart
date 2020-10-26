import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/therapy.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapyService {
  TherapyRepository therapyRepo = TherapyRepository();

  Future<bool> addTherapy(Therapy therapy) async {
    try {
      print(therapy.name);
      await therapyRepo.createTherapy(therapy);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Therapy>> therapyStream(String uid) {
    return therapyRepo.onStateChanged(uid).map(_therapyListFromSnapshop);
  }

  List<Therapy> _therapyListFromSnapshop(QuerySnapshot snapshot) {
    return snapshot.documents.map<Therapy>((doc) {
      Therapy therapy = Therapy();
      therapy.id = doc.documentID;
      therapy.loadFromJson(doc.data);

      return therapy;
    }).toList();
  }

  void dispose() {
    return null;
  }
}

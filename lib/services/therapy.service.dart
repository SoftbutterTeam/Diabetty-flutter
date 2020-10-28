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

  Future<List<Therapy>> getTherapies(String uid) async {
    final therapies = (await therapyRepo.getAllTherapies(uid)).data;
    if (therapies == null) {
      print('init null');
      return List();
    }
    print('init here');
    return therapies.map<Therapy>((json) {
      print('init map');
      Therapy therapy = Therapy();
      therapy.id = json['id'];
      print(therapy.id);
      return therapy..loadFromJson(json);
    }).toList();
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

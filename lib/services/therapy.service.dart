import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/therapy.repository.dart';

class TherapyService {
  TherapyRepository therapyRepo = TherapyRepository();

  Future<bool> addTherapy(Therapy therapy) async {
    try {
      //print(therapy.name);
      await therapyRepo.createTherapy(therapy);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Therapy>> getTherapies(String uid, {bool local: false}) async {
    try {
      final therapies =
          (await therapyRepo.getAllTherapies(uid, local: local)).data;
      if (therapies == null) {
        //print('init null');
        return List();
      }
      //print('init here');
      return therapies.map<Therapy>((json) {
        //print('init map');
        Therapy therapy = Therapy();
        therapy.id = json['id'];
        //print(therapy.id);
        return therapy..loadFromJson(json);
      }).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Stream<List<Therapy>> therapyStream(String uid) {
    return therapyRepo
        .onStateChanged(uid)
        .map((e) => _therapyListFromSnapshop(e, uid));
  }

  List<Therapy> _therapyListFromSnapshop(QuerySnapshot snapshot, String uid) {
    return snapshot.documents.map<Therapy>((doc) {
      Therapy therapy = Therapy();
      therapy.id = doc.documentID;
      therapy.userId = uid;
      therapy.loadFromJson(doc.data);

      return therapy;
    }).toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/therapy.repository.dart';

class TherapyService {
  TherapyRepository therapyRepo = TherapyRepository();

  Future<void> saveTherapy(Therapy therapy) async {
    try {
      therapyRepo.setTherapy(therapy);
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<bool> addTherapy(Therapy therapy) async {
    try {
      //print(therapy.name);
      print('HAHAEHUWRHUEHWRUHRH');
      print(therapy.medicationInfo.appearanceIndex);
      await therapyRepo.createTherapy(therapy);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTherapy(Therapy therapy) async {
    try {
      //print(therapy.name);
      if (therapy.id == null || therapy.userId == null) {
        throw Error();
      }
      await therapyRepo.deleteTherapy(therapy);
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

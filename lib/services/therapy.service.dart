import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/local_repositories/therapy.local.repository.dart';

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

      await therapyRepo.deleteTherapy(therapy);

      print('deleted seru=ruv');

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
      return therapies.map<Therapy>((json) {
        Therapy therapy = Therapy();
        therapy.id = json['id'];
        return therapy..loadFromJson(json);
      }).toList();
    } catch (e) {
      print('error21');
      print(e);
      throw e;
    }
  }

  Stream localStream() {
    return therapyRepo.onStateChanged('uid');
  }
}

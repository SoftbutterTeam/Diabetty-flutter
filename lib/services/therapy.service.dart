import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/therapy.repository.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart' as random;
import 'package:diabetty/models/user.model.dart' as UserModel;

class TherapyService {
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TherapyRepository therapyRepo = TherapyRepository();

  Future<bool> addTherapy(Therapy therapy) async {
    try {
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
      // Map<String, dynamic> values = doc.data;
      //print(values['schedule']);
      Therapy therapy = Therapy();
      therapy.uid = doc.documentID;
      therapy.loadFromJson(doc.data);
      // Json.decode(response.body).cast<ObjectName>();
      return therapy;
    }).toList();
  }

  void dispose() {
    return null;
  }
}

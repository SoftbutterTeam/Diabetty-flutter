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
  final AuthService authService;
  TherapyRepository therapyRepo =
      TherapyRepository("YDpBWyABH3ZluJ9sDKTCTGXCqzz1");

  Future<bool> addTherapy(Therapy therapy) async {
    try {
      await therapyRepo.createTherapy(therapy);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Therapy>> get therapyStream {
    return therapyRepo.onStateChanged.map(_therapyListFromSnapshop);
  }

  List<Therapy> _therapyListFromSnapshop(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      Therapy therapy = Therapy();
      therapy.uid = doc.documentID;
      therapy.loadFromJson(doc.data);
      return therapy;
    }).toList();
  }

  void dispose() {
    return null;
  }
}

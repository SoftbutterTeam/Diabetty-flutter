import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart' as random;
import 'package:diabetty/models/user.model.dart' as UserModel;

class TheraphyService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> addTherapy({AddTherapyForm form}) {}

  void dispose() {
    return null;
  }
}

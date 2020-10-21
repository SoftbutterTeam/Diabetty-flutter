import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/repositories/therapy.repository.dart';
import 'package:diabetty/services/authentication/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart' as random;
import 'package:diabetty/models/user.model.dart' as UserModel;

class TherapyService {
  TherapyRepository therapyRepo = TherapyRepository();

  Future<bool> addTherapy(Therapy therapy) async {
    try {
      await therapyRepo.createTherapy(therapy);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    return null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetttty/models/User.dart';
import 'package:diabetttty/system/AppContext.dart';
import 'data_results.dart';

class UserRepository {
  final AppContext appContext;
  Firestore db;

  UserRepository(
    this.appContext,
  ) {
    this.db = Firestore(app: appContext.fb);
  }

  Future<DataResult<dynamic>> fetch(String uid) async {
    User user;

    try {
      var result = await db.collection("users").document(uid).get();
      user = User.fromDocument(result);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
    return DataResult(data: user);
  }
}

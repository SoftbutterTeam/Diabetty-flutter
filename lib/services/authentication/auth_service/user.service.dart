import 'dart:async';
import 'package:diabetty/repositories/user.repository.dart';
import 'package:diabetty/models/user.model.dart';

class UserService {
  UserRepository _userRepository = UserRepository();

  Future<bool> createUser(user) async {
    try {
      _userRepository.createUser(user);
      return true;
    } catch (e) {
      //print('here x 3');
      //print(e);
      rethrow;
    }
  }

  Future<User> fetchUser(String uid) async {
    User user = User();
    try {
      DataResult dataResult = await _userRepository.getData(uid);
      var data = Map<String, dynamic>.from(dataResult.data);
      user.loadFromJson(data);
      user.uid = uid;

      return user;
    } catch (exception) {
      //print(exception);
      throw exception;
    }
  }

  Future<bool> isEmailUnique(email) async {
    return _userRepository.isEmailUnique(email);
  }

  Future<String> findUidByPhone(String phoneno) async {
    DataResult dataResult = await _userRepository.searchUserbyPhone(phoneno);
    if (dataResult == null) return null;
    User user = User();
    var data = Map<String, dynamic>.from(dataResult.data);
    user.loadFromJson(data);
    return user.uid;
  }

  Future<User> findUserByPhone(String phoneno) async {
    DataResult dataResult = await _userRepository.searchUserbyPhone(phoneno);
    if (dataResult == null) return null;
    User user = User();
    var data = Map<String, dynamic>.from(dataResult.data);
    user.loadFromJson(data);
    return user;
  }
}

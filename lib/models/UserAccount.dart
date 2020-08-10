import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserAccount {
  String _id;
  String status;
  String name;
  String email;
  bool emailVerified;
  String lastLogin;
  String phoneNumber;

  UserAccount();

  UserAccount.noEmail(this.name, this.phoneNumber) {
    this.status = "active";
    this.lastLogin = DateTime.now().toString();
  }
  UserAccount.newUser(this.name, this.email, this.phoneNumber) {
    this.status = "active";
    this.lastLogin = DateTime.now().toString();
  }
  UserAccount.fromAll(this._id, this.status, this.name, this.email,
      this.emailVerified, this.lastLogin, this.phoneNumber);

  UserAccount.fromUserAccount(UserAccount another) {
    this._id = another._id;
    this.status = another.status;
    this.name = another.name;
    this.email = another.email;
    this.lastLogin = another.lastLogin;
    this.emailVerified = another.emailVerified;
  }

  UserAccount.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        status = json['status'],
        name = json['name'],
        email = json['email'],
        emailVerified = json['emailVerified'],
        lastLogin = json['lastLogin'],
        phoneNumber = json['phoneBumber'];

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'name': this.name,
        'status': this.status,
        'email': this.email,
        'emailVerified': this.emailVerified,
        'lastLogin': this.lastLogin,
        'phoneNumner': this.phoneNumber
      };

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userAccount.txt');
  }

  Future<File> writeUserAccount() async {
    final file = await _localFile;
    String encodedUserAccount = jsonEncode(this);

    return file.writeAsString(encodedUserAccount);
  }

  Future<String> readUserAccount() async {
    try {
      final file = await _localFile;

      //read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return e;
    }
  }

  Future<bool> saveData() async {
    await writeUserAccount();
    return true;
  }

  Future<bool> restoreData() async {
    String encodedUser = await readUserAccount();
    Map<String, dynamic> decodedUser = jsonDecode(encodedUser);
    return loadFromJson(decodedUser);
  }

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      this._id = json['id'];
      this.status = json['status'];
      this.name = json['name'];
      this.email = json['email'];
      this.emailVerified = json['emailVerified'];
      this.lastLogin = json['lastLogin'];
      this.phoneNumber = json['phoneBumber'];
      return true;
    } catch (e) {
      return false;
    }
  }
}

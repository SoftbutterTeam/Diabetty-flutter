import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:diabetttty/models/forms/UserForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

//TODO add notifyListeners() to neccessary methods

class User with ChangeNotifier {
  String _id;
  String type;
  String status = "";
  bool _loggedIn = false;
  String name;
  String email;
  bool emailVerified;
  String lastLogin;
  String phoneNumber;
  String password;
  String age;
  String referralCode;

  User({this.name, this.email, this.password});
  bool get isLoggedIn => _loggedIn;
  set loggedIn(i) => _loggedIn = i;
  String get id => _id;
  set id(i) => _id = i;

  User.noEmail(this.name, this.phoneNumber) {
    this.status = "active";
    this.lastLogin = DateTime.now().toString();
  }
  User.newUser({this.name, this.email, this.phoneNumber}) {
    this.status = "active";
    this.lastLogin = DateTime.now().toString();
  }
  User.fromAll(
      {id,
      this.type,
      this.status,
      this.name,
      loggedIn = false,
      this.email,
      this.emailVerified,
      this.lastLogin,
      this.phoneNumber,
      this.age,
      this.referralCode});

  User.fromUserAccount(User another) {
    this._id = another._id;
    this.type = another.type;
    this.status = another.status;
    this.name = another.name;
    this.email = another.email;
    loggedIn = another._loggedIn;
    this.lastLogin = another.lastLogin;
    this.emailVerified = another.emailVerified;
    this.age = another.age;
    this.referralCode = another.referralCode;
  }

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        type = json['type'],
        status = json['status'],
        name = json['name'],
        email = json['email'],
        _loggedIn = json['loggedIn'],
        emailVerified = json['emailVerified'],
        lastLogin = json['lastLogin'],
        phoneNumber = json['phoneNumber'],
        age = json['age'],
        referralCode = json['referralCode'];

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'name': this.name,
        'type': this.type,
        'status': this.status,
        'email': this.email,
        'emailVerified': this.emailVerified,
        'loggedIn': isLoggedIn,
        'lastLogin': this.lastLogin,
        'phoneNumber': this.phoneNumber,
        'age': this.age,
        'referralCode': this.referralCode,
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
      print(e);
      return e;
    }
  }

  Future<bool> saveData() async {
    print('attempting to save info');
    await writeUserAccount();
    return true;
  }

  Future<bool> restoreData() async {
    //await saveData();
    try {
      print(1);
      String encodedUser = await readUserAccount();
      print(2);
      Map<String, dynamic> decodedUser = jsonDecode(encodedUser);
      print(decodedUser);
      print(loadFromJson(decodedUser));
      print(lastLogin);
      return loadFromJson(decodedUser);
    } catch (e) {
      print(e);
      print("failed to restore data.");
      return null;
    }
  }

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      this._id = json['id'];
      this.type = json['type'];
      this.status = json['status'];
      this.name = json['name'];
      this.email = json['email'];
      this.emailVerified = json['emailVerified'];
      loggedIn = json['loggedIn'];
      this.lastLogin = json['lastLogin'];
      this.phoneNumber = json['phoneNumber'];
      this.age = json['age'];
      this.referralCode = json['referralCode'];
      return true;
    } catch (e) {
      return false;
    }
  }

  /** TODO if the user saved is already a guest user. They should instead call loginAsGuest user 
   * to avoid refreshing the user.
  */

  Future<bool> initGuestUser({String name = "Friend"}) async {
    try {
      emptyAttributes(
        name: name,
        type: "GA",
        loggedIn: true,
        status: "no-intro",
      );
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUserA({
    String id,
    String status,
    String name,
    String email,
    bool emailVerfied,
    bool loggedIn = true,
    String lastLogin,
    String phoneNumber,
    String age,
  }) async {
    String type = "A";

    try {
      emptyAttributes(
        id: id,
        type: type,
        status: status,
        name: name,
        email: email,
        emailVerfied: emailVerfied,
        loggedIn: loggedIn,
        lastLogin: lastLogin,
        phoneNumber: phoneNumber,
        age: age,
      );
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUserA2({UserForm userform}) async {
    String type = "A";

    try {
      editAttributes(
          type: type,
          status: userform.status,
          name: userform.name,
          email: userform.email,
          password: userform.password,
          age: userform.age,
          loggedIn: true);
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUserB({
    String id,
    String status,
    String name,
    String email,
    bool emailVerfied,
    bool loggedIn = true,
    String lastLogin,
    String phoneNumber,
    String age,
  }) async {
    String type = "B";

    try {
      emptyAttributes(
        id: id,
        type: type,
        status: status,
        name: name,
        email: email,
        emailVerfied: emailVerfied,
        loggedIn: loggedIn,
        lastLogin: lastLogin,
        phoneNumber: phoneNumber,
        age: age,
        referralCode: referralCode,
      );
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUserB2({UserForm userform}) async {
    String type = "B";
    try {
      editAttributes(
          type: type,
          status: userform.status,
          name: userform.name,
          email: userform.email,
          password: userform.password,
          referralCode: userform.referralCode,
          loggedIn: true);
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserWithForm({UserForm userform}) async {
    try {
      editAttributes(
        loggedIn: true,
        status: userform.status,
        age: userform.age,
        referralCode: userform.referralCode,
      );
      print(userform.age);
      print(userform.referralCode);
      print(userform.status);
      await saveData();
      return true;
    } catch (e) {
      return false;
    }
  }

  void editAttributes({
    String id,
    String type,
    String status,
    String name,
    String email,
    bool emailVerfied,
    bool loggedIn,
    String lastLogin,
    String phoneNumber,
    String password,
    String age,
    String referralCode,
  }) {
    emptyAttributes(
      id: (id != null ? id : this._id),
      type: (type != null ? type : this.type),
      status: (status != null ? status : this.status),
      name: (name != null ? name : this.name),
      email: (email != null ? email : this.email),
      loggedIn: (loggedIn != null ? loggedIn : this._loggedIn),
      emailVerfied: (emailVerfied != null ? emailVerfied : this.emailVerified),
      lastLogin: (lastLogin != null ? lastLogin : this.lastLogin),
      phoneNumber: (phoneNumber != null ? phoneNumber : this.phoneNumber),
      age: (age != null ? age : this.age),
      referralCode: (referralCode != null ? referralCode : this.referralCode),
    );
  }

  void emptyAttributes(
      {String id,
      String type,
      String status,
      String name,
      String email,
      bool loggedIn,
      bool emailVerfied,
      String lastLogin,
      String phoneNumber,
      String age,
      String referralCode}) {
    this._id = id;
    this.type = type;
    this.status = status;
    this.name = name;
    this.email = email;
    this._loggedIn = loggedIn;
    this.emailVerified = emailVerfied;
    this.lastLogin = lastLogin;
    this.phoneNumber = phoneNumber;
    this.age = age;
    this.referralCode = referralCode;
  }
}

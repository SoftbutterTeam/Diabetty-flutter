import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String type;
  String status = "none";
  String name;
  String email;
  String lastLogin;
  bool loggedIn = false;
  String phoneNumber;
  String password;
  String age;
  String referralCode;
  String createdAt;

  User(
      {id,
      this.type,
      this.status = "none",
      this.name,
      loggedIn = false,
      this.email,
      this.lastLogin,
      this.phoneNumber,
      this.age,
      this.referralCode,
      this.createdAt});
  User.fromUserAccount(User another) {
    this.uid = another.uid;
    this.type = another.type;
    this.status = another.status;
    this.name = another.name;
    this.email = another.email;
    loggedIn = another.loggedIn;
    this.lastLogin = another.lastLogin;
    this.age = another.age;
    this.referralCode = another.referralCode;
    this.createdAt = another.createdAt;
  }

  factory User.fromDocument(DocumentSnapshot document) {
    var data = Map<String, dynamic>.from(document.data);
    data['id'] = document.documentID;

    return User.fromJson(data);
  }

  User.fromJson(Map<String, dynamic> json)
      : uid = json['id'],
        type = json['type'],
        status = json['status'],
        name = json['name'],
        email = json['email'],
        loggedIn = json['loggedIn'],
        lastLogin = json['lastLogin'],
        phoneNumber = json['phoneNumber'],
        age = json['age'],
        referralCode = json['referralCode'];

  Map<String, dynamic> toJson() => {
        'id': this.uid,
        'name': this.name,
        'type': this.type,
        'status': this.status,
        'email': this.email,
        'loggedIn': loggedIn,
        'lastLogin': this.lastLogin,
        'phoneNumber': this.phoneNumber,
        'age': this.age,
        'referralCode': this.referralCode,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      this.uid = json['id'];
      this.type = json['type'];
      this.status = json['status'];
      this.name = json['name'];
      this.email = json['email'];
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
    setAllAttributes(
      id: (id != null ? id : this.uid),
      type: (type != null ? type : this.type),
      status: (status != null ? status : this.status),
      name: (name != null ? name : this.name),
      email: (email != null ? email : this.email),
      loggedIn: (loggedIn != null ? loggedIn : this.loggedIn),
      lastLogin: (lastLogin != null ? lastLogin : this.lastLogin),
      phoneNumber: (phoneNumber != null ? phoneNumber : this.phoneNumber),
      age: (age != null ? age : this.age),
      referralCode: (referralCode != null ? referralCode : this.referralCode),
    );
  }

  void setAllAttributes(
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
    this.uid = id;
    this.type = type;
    this.status = status;
    this.name = name;
    this.email = email;
    this.loggedIn = loggedIn;
    this.lastLogin = lastLogin;
    this.phoneNumber = phoneNumber;
    this.age = age;
    this.referralCode = referralCode;
  }
}

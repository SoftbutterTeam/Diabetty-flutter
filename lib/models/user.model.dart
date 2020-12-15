import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String displayName;
  String email;
  String phoneNumber;

  User({
    this.uid,
    this.name,
    this.email,
    this.displayName,
    this.phoneNumber,
  });
  User.fromUserAccount(User another) {
    this.uid = another.uid;
    this.name = another.name;
    this.email = another.email;
    this.displayName = another.displayName;
  }

  factory User.fromDocument(DocumentSnapshot document) {
    var data = Map<String, dynamic>.from(document.data);
    data['uid'] = document.documentID;
    return User.fromJson(data);
  }

  User.fromJson(Map<String, dynamic> json) {
    loadFromJson(json);
  }

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'name': this.name,
        'email': this.email,
        'phoneNumber': this.phoneNumber,
        'displayName': this.displayName,
      };

  bool loadFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('uid')) this.uid ??= json['uid'];
      if (json.containsKey('displayName'))
        this.displayName = json['displayName'];
      // if (json.containsKey('id')) this.documentId = json['id'];
      if (json.containsKey('name')) this.name = json['name'];
      if (json.containsKey('email')) this.email = json['email'];
      if (json.containsKey('phone_number'))
        this.phoneNumber = json['phone_number'];
      if (json.containsKey('displayName'))
        this.displayName = json['displayName'];
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  void editAttributes({
    String uid,
    String type,
    String status,
    String name,
    String displayName,
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
      uid: (uid != null ? uid : this.uid),
      name: (name != null ? name : this.name),
      email: (email != null ? email : this.email),
      displayName: (displayName != null ? displayName : this.displayName),
      phoneNumber: (phoneNumber != null ? phoneNumber : this.phoneNumber),
    );
  }

  void setAllAttributes(
      {String uid,
      String name,
      String email,
      String phoneNumber,
      String displayName}) {
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.displayName = displayName;
  }

  void setDummy() {
    this.uid = "2kjnfksjdnfosdjnjn";
    this.name = "bob";
    this.displayName = "bobbyman1234";
    this.email = "randomemail@this.com";
    this.phoneNumber = "0123456789";
  }
}

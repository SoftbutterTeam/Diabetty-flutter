import 'package:flutter/material.dart';

class UserForm {
  String _id;
  String accountType = "";
  String type;
  String status = "no-intro";
  String name;
  String email;
  bool emailVerified;
  String lastLogin;
  String phoneNumber;
  String password;
  String age;
  String referralCode;
  
  
  UserForm({this.name, this.email, this.password, this.type, this.age, this.accountType, this.referralCode});

}
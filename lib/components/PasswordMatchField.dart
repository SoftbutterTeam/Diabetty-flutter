import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

Container PasswordMatchField(
    {var hintText, var controller, String Function(dynamic) validator, bool isPassword = true, var onChanged}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 40, right: 40),
    decoration:
        boxDecoration(radius: 40, showShadow: true, bgColor: Colors.white),
    child: TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
      ),
    ),
  );
}

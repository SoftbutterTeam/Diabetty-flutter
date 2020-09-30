import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final controller;
  final String placeholder;

  InputTextField({this.controller, this.placeholder});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: CupertinoTextField(
          controller: controller,
          decoration: BoxDecoration(
            color: appWhite,
            border: Border.all(
                color: Colors.black54, width: 0.1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0),
          ),
          prefix: Container(
            padding: EdgeInsets.only(left: 17),
            child: Icon(
              CupertinoIcons.heart,
              size: 23,
            ),
          ),
          placeholder: placeholder,
          maxLines: 1,
          maxLength: 30,
          padding: EdgeInsets.only(left: 16, top: 9.5, bottom: 9.5, right: 10),
          style: TextStyle(
              fontSize: textSizeLargeMedium - 1.5, fontFamily: 'Regular')),
    );
  }
}

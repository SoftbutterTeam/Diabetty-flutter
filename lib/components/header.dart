import 'package:diabetttty/theme/AppConstant.dart';
import 'package:diabetttty/theme/colors.dart';
import 'package:flutter/material.dart';

AppBar header(context, {String titleText, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading:
        removeBackButton ? false : true, //removes back button
    title: Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        titleText,
        style: TextStyle(
          fontFamily: fontBold,
          color: t3_textColorPrimary,
          fontSize: 22.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}

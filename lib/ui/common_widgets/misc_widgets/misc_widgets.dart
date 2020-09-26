import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/material.dart';

Text subHeadingText(var text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: fontBold, fontSize: 18.5, color: color),
  );
}

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
    textColor = appTextColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

showToast(BuildContext aContext, String caption) {
  Scaffold.of(aContext).showSnackBar(
      SnackBar(content: text(caption, textColor: appWhite, isCentered: true)));
}

void finish(context) {
  Navigator.pop(context);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

launchScreen(context, String tag, {Object arguments}) {
  if (arguments == null) {
    Navigator.pushNamed(context, tag);
  } else {
    Navigator.pushNamed(context, tag, arguments: arguments);
  }
}

void launchScreenWithNewTask(context, String tag) {
  Navigator.pushNamedAndRemoveUntil(context, tag, (r) => false);
}

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = appWhite,
    var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow
          ? [BoxShadow(color: appShadowColor, blurRadius: 5, spreadRadius: 1)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

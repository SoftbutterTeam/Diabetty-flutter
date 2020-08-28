import 'package:diabetttty/theme/index.dart';
import 'package:diabetttty/theme/widgets.dart';
import 'package:flutter/material.dart';

Container AddTextInput({var controller, var hinttext, context, TextInputType keyboardType, TextInputAction textInputAction, var onFieldSubmitted}) {
  return Container(
      child: TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    textCapitalization: TextCapitalization.words,
    style: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
    autofocus: false,
    onFieldSubmitted: onFieldSubmitted,
    decoration: formFieldDecoration(hinttext),
  ));
}

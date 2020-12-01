import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class ProfileCustomTextField extends StatelessWidget {
  final Stack stackIcons;
  final Widget singleIcon;
  final Function onTap;
  var placeholder;
  final Function onSubmitted;
  final String placeholderText;
  final bool showHeart;

  ProfileCustomTextField(
      {this.stackIcons,
      this.singleIcon,
      this.onTap,
      this.placeholder,
      this.placeholderText,
      this.onSubmitted,
      this.showHeart});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onTap: onTap,
      enableInteractiveSelection: false,
      onSubmitted: onSubmitted,
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
            color: Colors.black54, width: 0.1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(0),
      ),
      prefix: Container(
          padding: EdgeInsets.only(left: 18),
          child: stackIcons ?? singleIcon),
      suffix: Container(
        padding: EdgeInsets.only(right: 15),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 5, bottom: 2),
                child: (placeholder is String)
                    ? text((placeholder), fontSize: textSizeMedium2)
                    : placeholder),
          ],
        ),
      ),
      placeholder: placeholderText,
      readOnly: (placeholderText == "Set Strength & Units") ? false : true,
      maxLines: 1,
      maxLength: 30,
      padding: EdgeInsets.only(left: 18, top: 11, bottom: 11, right: 10),
      placeholderStyle: TextStyle(
        fontSize: textSizeLargeMedium - 3,
        color: Colors.grey[700],
      ),
    );
  }
}

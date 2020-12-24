import 'package:diabetty/ui/common_widgets/misc_widgets/animated_scale_button.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class CustomTextField extends StatelessWidget {
  final Stack stackIcons;
  final Widget singleIcon;
  final Function onTap;
  var placeholder;
  final Function onSubmitted;
  final String placeholderText;
  final bool showHeart;

  CustomTextField(
      {this.stackIcons,
      this.singleIcon,
      this.onTap,
      this.placeholder,
      this.placeholderText,
      this.onSubmitted,
      this.showHeart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        onTap: onTap,
        enableInteractiveSelection: false,
        onSubmitted: onSubmitted,
        decoration: BoxDecoration(
          color: appWhite,
          border: Border(
            bottom: BorderSide(
                color: Colors.grey[200], width: 1.2, style: BorderStyle.solid),
          ),
        ),
        prefix: Container(
            padding: EdgeInsets.only(left: 18),
            child: stackIcons ?? singleIcon),
       suffix: Container(
        padding: EdgeInsets.only(right: 33),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 5, bottom: 2),
                child: (placeholder is String)
                    ? text((placeholder), fontSize: textSizeMedium2)
                    : placeholder),
            AnimatedScaleButton(
              onTap: () {},
              size: 21,
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  (placeholderText == "Set Strength & Units")
                      ? Icons.arrow_drop_down
                      : CupertinoIcons.right_chevron,
                  size: 20,
                ),
              ),
            ),
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
      ),
    );
  }
}

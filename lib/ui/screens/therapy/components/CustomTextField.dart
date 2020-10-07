import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class CustomTextField extends StatelessWidget {
  final AnimatedBuilder icon;
  final Function onTap;
  var placeholder;
  final Function onSubmitted;
  final String placeholderText;
  final bool showHeart;

  CustomTextField(
      {this.icon,
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
          border: Border.all(
              color: Colors.black54, width: 0.1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(0),
        ),
        prefix: Container(
          height: 25,
          width: 40,
          padding: EdgeInsets.only(left: 18),
          child: icon,
        ),
        suffix: Container(
          padding: EdgeInsets.only(right: 15),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 2),
                  child: (placeholder is String)
                      ? text((placeholder), fontSize: textSizeMedium2)
                      : placeholder),
              Icon(
                (placeholderText == "Set Strength & Units")
                    ? Icons.arrow_drop_down
                    : CupertinoIcons.right_chevron,
                size: 20,
              ),
            ],
          ),
        ),
        placeholder: placeholderText,
        readOnly: (placeholderText == "Set Strength & Units") ? false : true,
        maxLines: 1,
        maxLength: 30,
        padding: EdgeInsets.only(left: 18, top: 9, bottom: 9, right: 10),
        placeholderStyle: TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

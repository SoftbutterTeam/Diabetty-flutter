import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrengthTextField extends StatelessWidget {
  final controller;
  final Stack stackIcons;

  final Function onTap;
  var placeholder;
  final Function onSubmitted;
  final String placeholderText;

  StrengthTextField(
      {this.stackIcons,
      this.onTap,
      this.placeholder,
      this.placeholderText,
      this.onSubmitted,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        controller: controller,
        enableInteractiveSelection: false,
        onSubmitted: onSubmitted,
        decoration: BoxDecoration(
          color: appWhite,
          border: Border.all(
              color: Colors.black54, width: 0.1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(0),
        ),
        prefix:
            Container(padding: EdgeInsets.only(left: 18), child: stackIcons),
        suffix: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 2),
                    child: text((placeholder), fontSize: textSizeMedium2)),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        placeholder: placeholderText,
        readOnly: (placeholder == 'none'),
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

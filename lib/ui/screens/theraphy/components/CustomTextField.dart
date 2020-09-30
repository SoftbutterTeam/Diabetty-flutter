import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final Function onTap;
  var placeholder;
  final String placeholderText;

  CustomTextField({this.icon, this.onTap, this.placeholder, this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        decoration: BoxDecoration(
          color: appWhite,
          border: Border.all(
              color: Colors.black54, width: 0.1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(0),
        ),
        prefix: Container(
          padding: EdgeInsets.only(left: 18),
          child: icon,
        ),
        suffix: Container(
          padding: EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 2),
                    child: (placeholder is String) ? text((placeholder), fontSize: textSizeMedium2) : placeholder),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        placeholder: placeholderText,
        readOnly: true,
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

import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Function onSubmitted;
  final Function validator;
  final Stack stackIcons;
  final String initalName;
  final ValueChanged<String> onChanged;
  final AnimatedOpacity icon;
  final AnimatedOpacity icon2;

  InputTextField(
      {this.controller,
      this.placeholder,
      this.stackIcons,
      this.onSubmitted,
      this.validator,
      this.onChanged,
      this.icon,
      this.initalName,
      this.icon2});

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.text = widget.initalName;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: CupertinoTextField(
          autofocus: true,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          controller: widget.controller,
          decoration: BoxDecoration(
            color: appWhite,
            border: Border(
              bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 1.2,
                  style: BorderStyle.solid),
            ),
          ),
          // r
          prefix: Container(
            padding: EdgeInsets.only(left: 17),
            child: this.widget.stackIcons,
          ),
          placeholder: widget.placeholder,
          maxLines: 1,
          maxLength: 30,
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 10),
          style: TextStyle(
              fontSize: textSizeLargeMedium - 1.5, fontFamily: 'Regular')),
    );
  }
}

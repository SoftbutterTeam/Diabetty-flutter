import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/constants/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.validator,
      this.onSaved,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        autofocus: true,
        cursorColor: kPrimaryColor,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

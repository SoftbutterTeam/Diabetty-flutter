import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  void initState() {
    _obscureText = true;
    super.initState();
  }

  bool _obscureText;

  // Toggles the password show status
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
        child: TextField(
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: "Password",
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: GestureDetector(
            onTap: _toggleObscureText,
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            )),
        border: InputBorder.none,
      ),
    ));
  }
}

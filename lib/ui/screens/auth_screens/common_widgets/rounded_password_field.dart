import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/auth_screens/common_widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Function onSaved;
  final GlobalKey<FormState> formKey;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.onSaved,
    this.formKey,
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

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String _formSave() {
    widget.formKey.currentState.save();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      cursorColor: kPrimaryColor,
      validator: (value) =>
          validator.isLength(value, 1) ? _formSave() : "please enter password",
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

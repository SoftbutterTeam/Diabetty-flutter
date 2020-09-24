import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/others/auth_screens/common_widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Function onSaved;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool isLoginForm;
  final Function validator;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.onSaved,
    this.formKey,
    this.hintText,
    this.validator,
    this.isLoginForm = false,
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
      validator: widget.validator == null
          ? (value) => validator.isLength(value, 6)
              ? _formSave()
              : validator.isLength(value, 1) && !widget.isLoginForm
                  ? "Password is too short"
                  : "Please enter a password"
          : widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Password",
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

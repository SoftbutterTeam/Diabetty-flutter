import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/animated_scale_button.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrengthTextField extends StatefulWidget {
  final TextEditingController controller;
  final AddTherapyForm therapyForm;
  final Stack stackIcons;
  final Function onChange;
  final Function onTap;
  var placeholder;
  final Function onSubmitted;
  final String placeholderText;
  final String initialText;

  StrengthTextField(
      {this.stackIcons,
      this.onTap,
      this.therapyForm,
      this.placeholder,
      this.placeholderText,
      this.onSubmitted,
      this.controller,
      this.onChange,
      this.initialText = ''});

  @override
  _StrengthTextFieldState createState() => _StrengthTextFieldState();
}

class _StrengthTextFieldState extends State<StrengthTextField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.text = widget.initialText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        onChanged: widget.onChange,
        controller: widget.controller,
        enableInteractiveSelection: false,
        onSubmitted: widget.onSubmitted,
        keyboardType: TextInputType.number,
        decoration: BoxDecoration(
          color: appWhite,
          border: Border(
            bottom: BorderSide(
                color: Colors.grey[200], width: 1.2, style: BorderStyle.solid),
          ),
        ),
        prefix: GestureDetector(
            child: Row(
          children: [
            Container(
                padding: EdgeInsets.only(left: 18), child: widget.stackIcons),
            Container(
              child: Text(
                'Set Strength',
              ),
              padding: EdgeInsets.only(
                left: 18,
              ),
            ),
          ],
        )),
        suffix: GestureDetector(
          onTap: widget.onTap,
          child: Container(
        padding: EdgeInsets.only(right: 33),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 5, bottom: 2),
                child: (widget.placeholder is String)
                    ? text((widget.placeholder), fontSize: textSizeMedium2)
                    : widget.placeholder),
            AnimatedScaleButton(
              onTap: () {},
              size: 21,
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  (widget.placeholderText == "Set Strength")
                      ? Icons.arrow_drop_down
                      : CupertinoIcons.right_chevron,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
        ),
        textAlign: TextAlign.right,
        readOnly: (widget.placeholder == 'none'),
        onTap:
            (widget.therapyForm.strengthUnitsIndex == 0) ? widget.onTap : null,
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

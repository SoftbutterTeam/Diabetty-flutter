import 'package:diabetty/models/therapy/therapy.model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.text = widget.initialText;
    });
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
          border: Border.all(
              color: Colors.black54, width: 0.1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(0),
        ),
        prefix: GestureDetector(
            onTap: () {
              print('hello');
              if (widget.therapyForm.strengthUnitsIndex == 0)
                widget.onTap.call();
            },
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 18),
                    child: widget.stackIcons),
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
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 2),
                    child:
                        text((widget.placeholder), fontSize: textSizeMedium2)),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        textAlign: TextAlign.right,
        readOnly: (widget.placeholder == 'none'),
        onTap: (widget.placeholder == 'none') ? widget.onTap : null,
        maxLines: 1,
        maxLength: 30,
        padding: EdgeInsets.only(left: 0, top: 9, bottom: 9, right: 10),
        placeholderStyle: TextStyle(
          fontSize: textSizeLargeMedium - 3,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

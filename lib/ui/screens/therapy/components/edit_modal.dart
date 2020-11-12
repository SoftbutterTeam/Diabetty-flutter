import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/screens/therapy/components/CustomTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:diabetty/ui/screens/therapy/components/StrengthTextField.dart';
import 'package:diabetty/ui/screens/therapy/mixins/add_therapy_modals.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditModal extends StatefulWidget {
  @override
  _EditModalState createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> with AddTherapyModalsMixin {
  TextEditingController medicationNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Center(child: Text('Edit Medication')),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.35,
        width: size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMedicationNameField(),
            _buildAppearanceField(context),
            _buildUnitField(context),
            Text('Save', style: TextStyle(color: Colors.indigo)),
          ],
        ),
      ),
    );
  }

  InputTextField _buildMedicationNameField() {
    return InputTextField(
      stackIcons: _stackedHeartIcons(true),
      controller: medicationNameController,
      placeholder: 'Medication Name..',
      initalName: null,
      onChanged: (val) {
        print(val);
        // or widget.manager.updateListeners();
      },
    );
  }

  Widget _buildAppearanceField(BuildContext context) {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => print('yeye'),
      placeholder: SvgPicture.asset(
        appearance_iconss[0],
        width: 25,
        height: 25,
      ),
      placeholderText: 'Appearance',
    );
  }

  Stack _stackedHeartIcons(bool cond) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: cond ? 0 : 1,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart,
            color: Colors.black,
            size: 23,
          ),
        ),
        AnimatedOpacity(
          opacity: cond ? 1 : 0,
          duration: Duration(milliseconds: 1000),
          child: Icon(
            CupertinoIcons.heart_solid,
            color: Colors.red,
            size: 23,
          ),
        )
      ],
    );
  }

  Widget _buildUnitField(BuildContext context) {
    return CustomTextField(
      stackIcons: _stackedHeartIcons(true),
      onTap: () => showUnitPopUp(context),
      placeholder: unitTypes[0],
      placeholderText: 'Type',
    );
  }
}

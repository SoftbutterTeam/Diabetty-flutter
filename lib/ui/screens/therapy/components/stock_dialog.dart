import 'dart:async';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockDialog extends StatefulWidget {
  final AddTherapyForm therapyForm;
  final TherapyManager manager;

  StockDialog({this.therapyForm, this.manager});
  @override
  _StockDialogState createState() => _StockDialogState();
}

class _StockDialogState extends State<StockDialog> {
  TextEditingController currentLevelController;
  TextEditingController flagLimitController;
  bool _isFilled;

  @override
  void initState() {
    super.initState();
    currentLevelController = TextEditingController(
        text: (widget.therapyForm.stock.currentLevel == null)
            ? ''
            : widget.therapyForm.stock.currentLevel.toString());
    flagLimitController = TextEditingController(
        text: (widget.therapyForm.stock.flagLimit == null)
            ? ''
            : widget.therapyForm.stock.flagLimit.toString());
    _isFilled = (currentLevelController.text.isNotEmpty) ? true : false;
  }

  @override
  void dispose() {
    currentLevelController?.dispose();
    flagLimitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: size.height * 0.36,
      width: size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStockLevelField(size),
          _buildNotifyWhenField(size),
          _buildButtons(),
        ],
      ),
    );
  }

  Container _buildStockLevelField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: size.width * 0.8,
      // color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Set current stock level at",
                  fontSize: 16.0, fontFamily: fontBold),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 15),
                height: size.height * 0.045,
                width: size.width * 0.4,
                child: CupertinoTextField(
                  onChanged: (val) {
                    handleBothFieldsFilled();
                  },
                  textAlign: TextAlign.center,
                  controller: currentLevelController,
                  enableInteractiveSelection: false,
                  placeholder: "",
                  placeholderStyle: TextStyle(
                    fontSize: textSizeLargeMedium - 3,
                    color: Colors.black26,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  maxLengthEnforced: true,
                  decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildNotifyWhenField(Size size) {
    return Container(
      width: size.width * 0.8,
      // color: Colors.blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Notify me when there are",
                  fontSize: 16.0, fontFamily: fontBold),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: size.height * 0.045,
                width: size.width * 0.4,
                child: CupertinoTextField(
                  onChanged: (val) {
                    handleBothFieldsFilled();
                  },
                  textAlign: TextAlign.center,
                  controller: flagLimitController,
                  placeholder: "",
                  placeholderStyle: TextStyle(
                    fontSize: textSizeLargeMedium - 3,
                    color: Colors.black26,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  maxLengthEnforced: true,
                  enableInteractiveSelection: false,
                  decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(unitTypes[widget.therapyForm.typeIndex] + " left",
                  fontSize: 12.0,
                  fontFamily: fontSemibold,
                  textColor: Colors.grey[700]),
            ],
          ),
        ],
      ),
    );
  }

  handleBothFieldsFilled() {
    if (currentLevelController.text.isNotEmpty) {
      _isFilled = true;
      setState(() {});
    } else {
      _isFilled = false;
      setState(() {});
    }
  }

  Expanded _buildButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
              child: Text(
                'cancel',
                style: TextStyle(
                  color: CupertinoColors.destructiveRed,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
              child: Text(
                'clear',
                style: TextStyle(
                  color: _isFilled ? Colors.indigo : Colors.black26,
                ),
              ),
              onPressed: () {
                if (_isFilled) {
                  _reset();
                  Navigator.pop(context);
                }
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
            child: Text(
              'save',
              style: TextStyle(
                color: _isFilled ? Colors.indigo : Colors.black26,
              ),
            ),
            onPressed: () {
              if (_isFilled) _handleSubmit();
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  _reset() {
    currentLevelController.clear();
    flagLimitController.clear();
    widget.therapyForm.stock.handleReset();
    _isFilled = false;
    setState(() {});
    widget.manager.updateListeners();
  }

  _handleSubmit() {
    int currentLevelControllerToInt = int.parse(currentLevelController.text);
    int flagLimitControllerToInt = int.parse(flagLimitController.text);
    widget.therapyForm.stock.currentLevel = currentLevelControllerToInt;
    widget.therapyForm.stock.flagLimit = flagLimitControllerToInt;

    widget.manager.updateListeners();
    Navigator.pop(context);
  }
}

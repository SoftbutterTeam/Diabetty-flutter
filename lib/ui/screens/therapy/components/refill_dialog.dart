import 'dart:async';

import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/constants/therapy_model_constants.dart';
import 'package:diabetty/models/therapy/sub_models/stock.model.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/mixins/edit_therapy_modals.mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefillDialog extends StatefulWidget {
  final Therapy therapyForm;

  RefillDialog({this.therapyForm});
  @override
  _RefillDialogState createState() => _RefillDialogState();
}

class _RefillDialogState extends State<RefillDialog>
    with EditTherapyModalsMixin {
  @override
  Therapy get therapy => widget.therapyForm;
  TextEditingController addStockController = TextEditingController();
  bool _isFilled = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.35,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStockLevelField(size),
              SizedBox(height: size.height * 0.04),
              _buildNotifyWhenField(size),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildStockLevelField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: size.width * 0.8,
      // color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(
                  "Current stock level: " +
                      ((widget.therapyForm.stock == null ||
                              widget.therapyForm.stock.currentLevel == null)
                          ? '0'
                          : widget.therapyForm.stock.currentLevel.toString()),
                  fontSize: 16.0,
                  fontFamily: fontBold),
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
              text("Add", fontSize: 16.0, fontFamily: fontBold),
            ],
          ),
          SizedBox(height: size.height * 0.004),
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
                  controller: addStockController,
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
        ],
      ),
    );
  }

  handleBothFieldsFilled() {
    if (addStockController.text.isNotEmpty) {
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
                'reset',
                style: TextStyle(
                  color: _isFilled ? Colors.indigo : Colors.black26,
                ),
              ),
              onPressed: () {
                if (_isFilled) _reset();
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              )),
          CupertinoButton(
            child: Text(
              'add',
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
    var manager = Provider.of<TherapyManager>(context, listen: false);
    addStockController.clear();
    _isFilled = false;
    setState(() {});
    manager.updateListeners();
  }

  _handleSubmit() {
    var manager = Provider.of<TherapyManager>(context, listen: false);
    int addStockControllerToInt = int.parse(addStockController.text);

    if (widget.therapyForm.stock != null) {
      widget.therapyForm.stock.refillAdd(addStockControllerToInt);
    } else {
      //// print('itsnull');
    }

    setState(() {});
    manager.updateListeners();
    Navigator.pop(context);
    // print('grgrg ----> ' + widget.therapyForm?.stock?.currentLevel.toString());
  }
}

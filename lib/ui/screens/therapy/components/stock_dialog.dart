import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:diabetty/ui/screens/therapy/forms/add_therapy_form.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockDialog extends StatefulWidget {
  @override
  _StockDialogState createState() => _StockDialogState();
}

class _StockDialogState extends State<StockDialog> {
  TextEditingController inventoryController;
  TextEditingController notifyController;
  bool _isFilled;
  final therapyForm = AddTherapyForm();

  @override
  void initState() {
    super.initState();
    inventoryController = TextEditingController();
    notifyController = TextEditingController();
    _isFilled = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.3,
        width: size.width * 0.8,
        child: Column(
          children: [
            _buildStockLevelField(size),
            _buildNotifyWhenField(size),
            _buildCancelAndSubmitButtons(),
          ],
        ),
      ),
    );
  }

  Container _buildStockLevelField(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: size.height * 0.12,
      width: size.width * 0.8,
      // color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Set current stock level at",
                  fontSize: 18.0, fontFamily: fontBold),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 15),
                height: size.height * 0.045,
                width: size.width * 0.4,
                child: CupertinoTextField(
                  onChanged: (val) {
                    areBothFieldsFilled();
                  },
                  textAlign: TextAlign.center,
                  controller: inventoryController,
                  enableInteractiveSelection: false,
                  placeholder: "",
                  placeholderStyle: TextStyle(
                    fontSize: textSizeLargeMedium - 3,
                    color: Colors.black26,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
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
      height: size.height * 0.12,
      width: size.width * 0.8,
      // color: Colors.blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Notify me when there are",
                  fontSize: 18.0, fontFamily: fontBold),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: size.height * 0.045,
                width: size.width * 0.4,
                child: CupertinoTextField(
                  onChanged: (val) {
                    areBothFieldsFilled();
                  },
                  textAlign: TextAlign.center,
                  controller: notifyController,
                  placeholder: "",
                  placeholderStyle: TextStyle(
                    fontSize: textSizeLargeMedium - 3,
                    color: Colors.black26,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
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
              text("pill(s) left",
                  fontSize: 12.0,
                  fontFamily: fontSemibold,
                  textColor: Colors.grey[700]),
            ],
          ),
        ],
      ),
    );
  }

  areBothFieldsFilled() {
    if (inventoryController.text.isNotEmpty &&
        notifyController.text.isNotEmpty) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }

  Expanded _buildCancelAndSubmitButtons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Text(
              'Cancel',
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
            ),
          ),
          AnimatedOpacity(
            opacity: _isFilled ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: CupertinoButton(
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
              onPressed: () {
                _validation();
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  _validation() {
    var inventoryControllerInt = int.parse(inventoryController.text);
    var notifyControllerInt = int.parse(notifyController.text);
    print(notifyControllerInt);
    (notifyControllerInt > inventoryControllerInt) ? print('cant do that son') : _handleSubmit(inventoryControllerInt);
  }

  _handleSubmit(inventoryControllerInt) {
    therapyForm.stock =  inventoryControllerInt;
    Navigator.pop(context);
  }
}

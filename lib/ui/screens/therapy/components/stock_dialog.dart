import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:diabetty/ui/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockDialog extends StatefulWidget {
  @override
  _StockDialogState createState() => _StockDialogState();
}

class _StockDialogState extends State<StockDialog> {
  TextEditingController inventoryController;

  @override
  void initState() {
    super.initState();
    inventoryController = TextEditingController();
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
            Container(
              height: size.height * 0.15,
              width: size.width * 0.8,
              color: Colors.red,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text("Set current stock levels"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 15),
                        height: size.height * 0.045,
                        width: size.width * 0.7,
                        child: CupertinoTextField(
                          padding: EdgeInsets.only(left: 15.0),
                          controller: inventoryController,
                          placeholder: "Inventory",
                          placeholderStyle: TextStyle(
                            fontSize: textSizeLargeMedium - 3,
                            color: Colors.grey[700],
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
            )
          ],
        ),
      ),
    );
  }
}

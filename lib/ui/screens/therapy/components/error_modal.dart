import 'package:diabetty/ui/common_widgets/misc_widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoResponseErrorModal extends StatelessWidget {
  final String errorDescription;
  const NoResponseErrorModal({Key key, this.errorDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: size.height * 0.18,
        width: size.width * 0.03,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            text(errorDescription,
                isCentered: true, maxLine: 3, fontSize: 18.0),
            SizedBox(height: size.height * 0.02),
            CupertinoButton(
              onPressed: () => Navigator.of(context).pop(context),
              child: text('OK', textColor: Colors.indigo, fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin CommonMixins {
  void areYouSurePopup(BuildContext context, Function func,
      {destructive: false}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text('Are you sure?'),
        actions: [
          CupertinoActionSheetAction(
            child: Text("Yes"),
            onPressed: () {
              func.call();
              Navigator.pop(context);
            },
            isDestructiveAction: destructive,
          ),
          CupertinoActionSheetAction(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Container(color: Colors.white, child: Text('Cancel')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

import 'package:diabetttty/theme/T2Colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  RoundedButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return RoundedButtonState();
  }
}

class RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: widget.onPressed,
        textColor: Colors.black,
        color: Color(0xFF494FFB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
          side: BorderSide(color: Colors.grey, width: 0.2), // border color
        ),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // box color
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

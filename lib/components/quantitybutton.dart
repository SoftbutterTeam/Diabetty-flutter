import 'package:diabetttty/theme/index.dart';
import 'package:flutter/material.dart';

class Quantitybtn extends StatefulWidget {
  @override
  QuantitybtnState createState() => QuantitybtnState();
}

class QuantitybtnState extends State<Quantitybtn> {
  bool visibility = false;
  var count = 1;

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: visibility,
      child: Container(
        height: width * 0.08,
        alignment: Alignment.center,
        width: width * 0.23,
        decoration: boxDecoration(color: Color(0xFF333333), radius: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: width * 0.08,
              height: width * 0.08,
              decoration: BoxDecoration(color: Color(0xFF333333), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4.0), topLeft: Radius.circular(4.0))),
              child: IconButton(
                icon: Icon(Icons.remove, color: Colors.white, size: 10),
                onPressed: () {
                  setState(() {
                    if (count == 1 || count < 1) {
                      count = 1;
                    } else {
                      count = count - 1;
                    }
                  });
                },
              ),
            ),
            text("$count"),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color(0xFF333333), borderRadius: BorderRadius.only(bottomRight: Radius.circular(4.0), topRight: Radius.circular(4.0))),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 10),
                onPressed: () {
                  setState(() {
                    count = count + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      replacement: GestureDetector(
        onTap: () {
          _changed();
        },
        child: Container(
          width: width * 0.22,
          height: width * 0.08,
          decoration: boxDecoration(color: Color(0xFF333333), radius: 4.0),
          alignment: Alignment.center,
          child: text("Quantity", isCentered: true),
        ),
      ),
    );
  }
}
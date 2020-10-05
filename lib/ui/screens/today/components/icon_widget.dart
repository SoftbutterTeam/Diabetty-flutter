import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatefulWidget {
  final String iconURL;
  final int index;

  IconWidget({this.iconURL, this.index});

  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
        ),
        child: SvgPicture.asset(
          widget.iconURL,
          color: widget.index.isOdd ? Colors.indigo[900] : null,
        ),
      ),
    );
  }
}

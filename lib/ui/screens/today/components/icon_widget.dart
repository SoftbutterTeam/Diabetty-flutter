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
      width: 40, //* was 35
      height: 40,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(60),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                widget.iconURL,
                color: widget.index.isOdd ? Colors.indigo[900] : null,
              ),
              Container(
                alignment: Alignment.topRight, // center bottom right
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[850], width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

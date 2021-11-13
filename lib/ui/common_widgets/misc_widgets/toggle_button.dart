import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final List<BoxShadow> shadows;
  final bool initialValue;

  AnimatedToggle({
    @required this.values,
    this.initialValue = false,
    @required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFFFFFFF), // Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.shadows = const [
      BoxShadow(
        color: const Color(0xFFFFFFFF),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    bool initialPosition = widget.initialValue;

    double width = MediaQuery.of(context).size.width;
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: width * 0.13, minWidth: width * 0.7),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  initialPosition = !initialPosition;
                  var index = 0;
                  if (!initialPosition) {
                    index = 1;
                  }
                  widget.onToggleCallback(index);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(blurRadius: 1.0, color: Colors.black26)
                    ],
                    color: widget.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      widget.values.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Text(
                          widget.values[index],
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors
                                .deepOrange[700], // const Color(0xFF918f95),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
                alignment: initialPosition
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: width * 0.35,
                  height: width * 0.13,
                  decoration: ShapeDecoration(
                    color: widget.buttonColor,
                    shadows: widget.shadows,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    initialPosition ? widget.values[0] : widget.values[1],
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 17,
                      color: widget.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

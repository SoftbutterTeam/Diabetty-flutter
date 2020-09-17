import 'package:diabetty/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  final double size;
  final double defaultsize = 20;
  final Color color;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = color != null ? color : Colors.lightBlue[700];
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding:
            EdgeInsets.all(size != null ? size - defaultsize + 6 : defaultsize),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          color: iconColor,
          height: size != null ? size : 22,
          width: size != null ? size : 22,
        ),
      ),
    );
  }
}

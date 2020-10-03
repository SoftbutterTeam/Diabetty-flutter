import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedBox extends AnimatedWidget {
  AnimatedBox({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final animation = listenable as Animation<double>;
    return SizedBox(height: size.height * animation.value // 0.165,

        );
  }
}

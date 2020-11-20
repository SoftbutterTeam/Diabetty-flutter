import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedTransformRotate extends AnimatedWidget {
  final double transformValue;
  final Widget child;
  AnimatedTransformRotate(
      {Key key, Animation<double> animation, this.transformValue, this.child})
      : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    print((-2 * pi - transformValue).toString() +
        'herer' +
        transformValue.toString());
    double angle = transformValue % (2 * pi);
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value *
          (angle.abs() < pi ? angle : (angle.sign * 2 * pi + angle.abs())),
      child: child,
    );
  }
}

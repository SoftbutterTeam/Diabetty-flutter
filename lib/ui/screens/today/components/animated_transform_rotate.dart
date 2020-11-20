import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedTransformRotate extends AnimatedWidget {
  final double transformValue;
  final Widget child;

  final bool reverse;
  AnimatedTransformRotate(
      {Key key,
      Animation<double> animation,
      this.transformValue,
      this.child,
      this.reverse = false})
      : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    double angle = transformValue.sign * (transformValue % (2 * pi));
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value *
          (reverse ? -1 : 1) *
          (angle.abs() < pi ? -angle : ((angle.sign * 2 * pi) - angle)),
      child: child,
    );

    // TODO just make it go to the right one
  }
}

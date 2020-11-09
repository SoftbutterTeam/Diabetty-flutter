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
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value * transformValue,
      child: child,
    );
  }
}

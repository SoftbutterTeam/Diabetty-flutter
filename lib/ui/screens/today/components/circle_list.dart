library circle_list;

import 'dart:math';

import 'package:circle_list/radial_drag_gesture_detector.dart';
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/screens/today/components/my_painter.dart';
export 'package:circle_list/radial_drag_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:diabetty/ui/screens/today/components/animated_transform_rotate.dart';

class CircleList extends StatefulWidget {
  final double innerRadius;
  final double outerRadius;
  final double listRadius;
  final double childrenPadding;
  final double initialAngle;
  final Color outerCircleColor;
  final Color innerCircleColor;
  final Gradient gradient;
  final Offset origin;
  final List<Widget> children;
  final bool isChildrenVertical;
  final RotateMode rotateMode;
  final bool innerCircleRotateWithChildren;
  final bool showInitialAnimation;
  final Widget centerWidget;
  final RadialDragStart onDragStart;
  final RadialDragUpdate onDragUpdate;
  final RadialDragEnd onDragEnd;
  final AnimationSetting animationSetting;
  final DragAngleRange dragAngleRange;
  final Color progressColor;
  final double progressAngle;

  final double progressCompletion;

  Animation<double> spinFactor;

  final double innerProgressCompletion;

  CircleList({
    this.innerRadius,
    this.outerRadius,
    this.listRadius,
    this.childrenPadding = 0,
    this.initialAngle = 0,
    this.progressAngle = 0,
    this.outerCircleColor,
    this.innerCircleColor,
    this.origin,
    this.spinFactor,
    @required this.children,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.gradient,
    this.centerWidget,
    this.isChildrenVertical = true,
    this.innerCircleRotateWithChildren = false,
    this.showInitialAnimation = false,
    this.animationSetting,
    this.rotateMode,
    this.dragAngleRange,
    this.progressColor,
    this.progressCompletion = 0,
    this.innerProgressCompletion,
  }) : assert(children != null);

  @override
  _CircleListState createState() => _CircleListState();
}

class _CircleListState extends State<CircleList>
    with SingleTickerProviderStateMixin {
  _DragModel dragModel = _DragModel();
  AnimationController _controller;
  Animation<double> _animationRotate;
  bool isAnimationStop = true;

  @override
  void initState() {
    //print('yo init');
    if (widget.showInitialAnimation) {
      _controller = AnimationController(
          vsync: this,
          duration: widget?.animationSetting?.duration ?? Duration(seconds: 1));
      _animationRotate = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: widget?.animationSetting?.curve ?? Curves.easeOutBack));
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isAnimationStop = true;
          });
        }
      });
      _controller.addListener(() {
        setState(() {
          isAnimationStop = false;
        });
      });
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outCircleDiameter = min(size.width, size.height);
    final double outerRadius = widget.outerRadius ?? outCircleDiameter / 2;
    final double innerRadius = widget.innerRadius ?? outerRadius / 2;
    final double listRadius = innerRadius * 1.03;
    final rotateMode = widget.rotateMode ?? RotateMode.onlyChildrenRotate;
    final dragAngleRange = widget.dragAngleRange;
    final progressColor = widget.progressColor;
    final progressCompletion = widget.progressCompletion;
    final innerProgressCompletion = widget.innerProgressCompletion;

    ///the origin is the point to left and top
    final Offset origin = widget.origin ?? Offset(0, -outerRadius);
    double backgroundCircleAngle = 0.0;
    if (rotateMode == RotateMode.allRotate)
      backgroundCircleAngle = dragModel.angleDiff + widget.initialAngle;

    return Container(
      width: outerRadius * 2,
      height: outerRadius * 2,
      child: AnimatedTransformRotate(
        animation: widget.spinFactor,
        transformValue: () {
          if (progressCompletion != 0) {
            return (progressCompletion / 100 * 2 * pi) + widget.progressAngle;
          } else
            return innerProgressCompletion / 100 * 2 * pi;
        }.call(),
        child: Stack(
          children: <Widget>[
            Positioned(
                left: origin.dx + outerRadius - innerRadius,
                top: -origin.dy + outerRadius - innerRadius,
                child: Transform.rotate(
                  angle: widget.innerCircleRotateWithChildren
                      ? dragModel.angleDiff + widget.progressAngle
                      : 0,
                  child: Container(
                      width: innerRadius * 2,
                      height: innerRadius * 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appWhite,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.2), // a 0.2 is dope
                            spreadRadius: 5,
                            blurRadius: 7,

                            offset: Offset(0, 1), // a 1 is dope
                          ),
                        ],
                      ),
                      child: new Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: new CustomPaint(
                              foregroundPainter: new MyPainter(
                                  completeColor: progressColor,
                                  completePercent: progressCompletion,
                                  width: 2.0),
                              child: Container(
                                  alignment: Alignment.center, child: null)))),
                )),
            Positioned(
              left: origin.dx,
              top: -origin.dy,
              child: RadialDragGestureDetector(
                stopRotate: rotateMode == RotateMode.stopRotate,
                onRadialDragUpdate: (PolarCoord updateCoord) {
                  if (widget.onDragUpdate != null) {
                    widget.onDragUpdate(updateCoord);
                  }
                  setState(() {
                    dragModel.getAngleDiff(updateCoord, dragAngleRange);
                  });
                },
                onRadialDragStart: (PolarCoord startCoord) {
                  if (widget.onDragStart != null) {
                    widget.onDragStart(startCoord);
                  }
                  setState(() {
                    dragModel.start = startCoord;
                  });
                },
                onRadialDragEnd: () {
                  if (widget.onDragEnd != null) {
                    widget.onDragEnd();
                  }
                  dragModel.end = dragModel.start;
                  dragModel.end.angle = dragModel.angleDiff;
                },
                child: Transform.rotate(
                  angle: backgroundCircleAngle,
                  child: Container(
                      width: outerRadius * 2,
                      height: outerRadius * 2,
                      decoration: BoxDecoration(
                          gradient: widget.gradient,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                widget.outerCircleColor ?? Colors.transparent,
                            width: outerRadius - innerRadius,
                          )),
                      child: widget.centerWidget),
                ),
              ),
            ),
            Positioned(
              left: origin.dx,
              top: -origin.dy,
              child: Container(
                width: outerRadius * 2,
                height: outerRadius * 2,
                child: RadialDragGestureDetector(
                  stopRotate: rotateMode == RotateMode.stopRotate,
                  onRadialDragUpdate: (PolarCoord updateCoord) {
                    if (widget.onDragUpdate != null) {
                      widget.onDragUpdate(updateCoord);
                    }
                    setState(() {
                      dragModel.getAngleDiff(updateCoord, dragAngleRange);
                    });
                  },
                  onRadialDragStart: (PolarCoord startCoord) {
                    if (widget.onDragStart != null) {
                      widget.onDragStart(startCoord);
                    }
                    setState(() {
                      dragModel.start = startCoord;
                    });
                  },
                  onRadialDragEnd: () {
                    if (widget.onDragEnd != null) {
                      widget.onDragEnd();
                    }
                    dragModel.end = dragModel.start;
                    dragModel.end.angle = dragModel.angleDiff;
                  },
                  child: Transform.rotate(
                    angle: isAnimationStop
                        ? (dragModel.angleDiff + widget.initialAngle)
                        : (-_animationRotate.value * pi * 2 +
                            widget.initialAngle),
                    child: Stack(
                      children: List.generate(widget.children.length, (ind) {
                        final index =
                            (ind - (widget.children.length - 1)).abs();
                        final double childrenDiameter =
                            2 * pi * listRadius / 12 - widget.childrenPadding;
                        Offset childPoint = getChildPoint(
                            index,
                            widget.children.length,
                            listRadius,
                            childrenDiameter);
                        return Positioned(
                          left: outerRadius + childPoint.dx,
                          top: outerRadius + childPoint.dy,
                          child: Transform.rotate(
                            angle: widget.isChildrenVertical
                                ? (-(dragModel.angleDiff) - widget.initialAngle)
                                : ((dragModel.angleDiff) + widget.initialAngle),
                            child: AnimatedTransformRotate(
                              animation: widget.spinFactor,
                              reverse: true,
                              transformValue: () {
                                if (progressCompletion != 0) {
                                  return (progressCompletion / 100 * 2 * pi) +
                                      widget.progressAngle;
                                } else
                                  return innerProgressCompletion / 100 * 2 * pi;
                              }.call(),
                              child: Container(
                                  width: childrenDiameter,
                                  height: childrenDiameter,
                                  alignment: Alignment.center,
                                  child: widget.children[index]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double reverseAngle(progressCompletion, innerProgressCompletion) {
    double angle = () {
      print(widget.progressAngle);
      if (progressCompletion != 0) {
        return (progressCompletion / 100 * 2 * pi) + widget.progressAngle;
      } else
        return innerProgressCompletion / 100 * 2 * pi;
    }.call();
    angle = angle.sign * (angle % (2 * pi));
    print('AAAA----------------+' + angle.toString());
    double result =
        -(angle.abs() <= pi ? angle : ((angle.sign * 2 * pi) - angle));
    print(result);
    return result;
  }

  Offset getChildPoint(
      int index, int length, double listRadius, double childrenDiameter) {
    double angel = 2 * pi * (index / length);
    double x = cos(angel) * listRadius - (childrenDiameter / 2);
    double y = sin(angel) * listRadius - (childrenDiameter / 2);
    return Offset(x, y);
  }
}

class _DragModel {
  PolarCoord start;
  PolarCoord end;
  double angleDiff = 0.0;

  double getAngleDiff(PolarCoord updatePolar, DragAngleRange dragAngleRange) {
    if (start != null) {
      angleDiff = updatePolar.angle - start.angle;
      if (end != null) {
        angleDiff += end.angle;
      }
    }
    angleDiff = limitAngle(angleDiff, dragAngleRange);
    return angleDiff;
  }

  double limitAngle(double angleDiff, DragAngleRange dragAngleRange) {
    if (dragAngleRange == null ||
        dragAngleRange.start == null ||
        dragAngleRange.end == null) return angleDiff;
    if (angleDiff > dragAngleRange.end) angleDiff = dragAngleRange.end;
    if (angleDiff < dragAngleRange.start) angleDiff = dragAngleRange.start;
    return angleDiff;
  }
}

class AnimationSetting {
  final Duration duration;
  final Curve curve;

  AnimationSetting({this.duration, this.curve});
}

import 'package:flutter/material.dart';

class AnimatedScaleButton extends StatefulWidget {
  const AnimatedScaleButton({
    Key key,
    this.onTap,
    this.child,
    this.size,
    this.padding = 20,
  }) : super(key: key);

  final Function onTap;
  final Widget child;
  final double size;
  final double padding;

  @override
  _AnimatedScaleButtonState createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> tween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller?.reverse();
    });

    tween = Tween(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _controller?.stop();
    this._controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _controller?.forward();
        widget.onTap?.call();
      },
      child: ScaleTransition(
        scale: tween != null && _controller != null ? tween : 1,
        child: Container(
            height: widget.size,
            width: widget.size,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            alignment: Alignment.centerRight,
            child: widget.child),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';

class ButtonBounceAnimation extends StatefulWidget {
  Widget child;
  double width;
  double height;
  double scale;
  int duration;
  double how;
  Function onTapCallBack;

  ButtonBounceAnimation(
      {this.child,
      this.width,
      this.height,
      this.scale,
      this.duration,
      this.how,
      this.onTapCallBack});

  @override
  _ButtonBounceAnimationState createState() => _ButtonBounceAnimationState();
}

class _ButtonBounceAnimationState extends State<ButtonBounceAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration,
      ),
      lowerBound: 0.0,
      upperBound: widget.how,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
//      onTap: ,
      child: Transform.scale(
        scale: widget.scale,
        child: widget.child,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    Timer(Duration(milliseconds: (widget.duration / 2).floor()), () {
      _controller.reverse();
      widget.onTapCallBack();
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }
}

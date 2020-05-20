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
  Function onTap;
  Function onDoubleTap;

  ButtonBounceAnimation(
      {this.child,
      this.width,
      this.height,
      this.scale,
      this.duration,
      this.how,
      this.onTap,
      this.onTapCallBack,
      this.onDoubleTap});

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
      onTap: _onTap,
      onDoubleTap: _onDoubleTap,
      onLongPress: _longPress,
      child: Transform.scale(
        scale: widget.scale,
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    if(widget.onTap!=null)
      widget.onTap();
  }
  void _longPress(){
    _controller.reverse();
  }

  void _onTapDown(TapDownDetails details) {
    Timer(Duration(milliseconds: (widget.duration / 2).floor()), () {
      _controller.reverse();
      if (widget.onTapCallBack != null) widget.onTapCallBack();
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }


  void _onDoubleTap() {
    if (widget.onDoubleTap != null) widget.onDoubleTap();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSeekBar extends StatefulWidget {
  final Function onDragUpdate;

  CustomSeekBar({this.onDragUpdate});

  @override
  _CustomSeekBarState createState() => _CustomSeekBarState();
}

class _CustomSeekBarState extends State<CustomSeekBar>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  double valueHolder;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.8,
    )..addListener(() {
        setState(() {});
      });

    valueHolder = 35;
    _scale = 0;
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Container(
      alignment: Alignment.centerLeft,
      width: 40,
      margin: EdgeInsets.only(left: 4),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onVerticalDragEnd: _onDragEnd,
        onHorizontalDragEnd: _onDragEnd,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                width: 10 + _scale * 30,
                height: 200,
              ),
            ),
             Container(
               width:10 + _scale * 30 ,
               height: 200,
               child: RotatedBox(
                quarterTurns: 1,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.transparent,
                    thumbColor: Colors.white,
                    inactiveTickMarkColor: Colors.grey.withOpacity(0.6),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                  ),
                  child: Slider(
                      inactiveColor: Colors.transparent,
                      value: valueHolder,
                      min: 10,
                      max: 90,
                      onChangeStart: (v) {
                        _controller.reverse();
                      },
                      onChangeEnd: (v) {
                        _controller.forward();
                      },
                      onChanged: (value) {
                        _onDragUpdate(value);
                        setState(() {
                          valueHolder = value;
                        });
                      }),
                ),
            ),
             ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    print("End");
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }

  void _onDragEnd(DragEndDetails d) {
    _controller.reverse();
    _controller.forward();
  }

  void _onDragUpdate(double d) {
    widget.onDragUpdate(d);
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);

    path.lineTo((size.width / 2), size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

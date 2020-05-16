import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:writogram/Modals/StoryData.dart';

class StoryPaintWidget extends StatefulWidget {
  final List<StoryData> storyData;
  final Function updateTransform;

  StoryPaintWidget({this.storyData, this.updateTransform});

  @override
  _StoryPaintWidgetState createState() => _StoryPaintWidgetState();
}

class _StoryPaintWidgetState extends State<StoryPaintWidget> {
  int index = 0;
  int prev = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: MatrixGestureDetector(
          onMatrixUpdate: (m, rs, ry, rx) {
            if (index != prev) {
              m.setFrom(widget.storyData[index].transform);
            }
            widget.updateTransform(m, index);
            prev = index;
          },
          child: Stack(
            children: <Widget>[
              Container(
                transform: widget.storyData[0].transform,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                    updateIndex();
                  },
                  child: Container(
                    color: widget.storyData[0].textStyle.backgroundColor != null
                        ? widget.storyData[0].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[0].text,
                      style: TextStyle(
                          fontSize: widget.storyData[0].textStyle.fontSize,
                          fontFamily: widget.storyData[0].textStyle.fontFamily,
                          color: widget.storyData[0].textStyle.color),
                    ),
                  ),
                ),
              ),
              Container(
                transform: widget.storyData[1].transform,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                    updateIndex();
                  },
                  child: Container(
                    color: widget.storyData[1].textStyle.backgroundColor != null
                        ? widget.storyData[1].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[1].text,
                      style: TextStyle(
                          fontSize: widget.storyData[0].textStyle.fontSize,
                          fontFamily: widget.storyData[1].textStyle.fontFamily,
                          color: widget.storyData[1].textStyle.color),
                    ),
                  ),
                ),
              ),
              Container(
                transform: widget.storyData[2].transform,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                    updateIndex();
                  },
                  child: Container(
                    color: widget.storyData[2].textStyle.backgroundColor != null
                        ? widget.storyData[2].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[2].text,
                      style: TextStyle(
                          fontSize: widget.storyData[2].textStyle.fontSize,
                          fontFamily: widget.storyData[2].textStyle.fontFamily,
                          color: widget.storyData[2].textStyle.color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void updateIndex() {
    setState(() {
      print("Tapped " + index.toString());
    });
  }
}

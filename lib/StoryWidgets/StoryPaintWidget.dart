import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:vibration/vibration.dart';
import 'package:writogram/Modals/StoryData.dart';

class StoryPaintWidget extends StatefulWidget {
  final List<StoryData> storyData;
  final Function updateTransform;
  final Function editCallback;
  StoryPaintWidget({this.storyData, this.updateTransform,this.editCallback});

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
              m.setZero();
              m.add(widget.storyData[index].transform);
              print("Index: " + index.toString() + " Prev: " + prev.toString());
              print("Index: " + index.toString() + " Prev: " + prev.toString());
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
                    Vibration.vibrate(duration: 100);
                    setState(() {
                      index = 0;
                    });
                    updateIndex();
                  },
                  onDoubleTap: () {
                    setState(() {
                      index = 0;
                    });
                    updateIndex();
                    editCallback(index);
                  },
                  child: Container(
                    color: widget.storyData[0].textStyle.backgroundColor != null
                        ? widget.storyData[0].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[0].text,
                      textAlign: TextAlign.center,
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
                    Vibration.vibrate(duration: 100);
                    setState(() {
                      index = 1;
                    });
                    updateIndex();
                  },
                  onDoubleTap: () {
                    setState(() {
                      index = 1;
                    });
                    updateIndex();
                    editCallback(index);
                  },
                  child: Container(
                    color: widget.storyData[1].textStyle.backgroundColor != null
                        ? widget.storyData[1].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[1].text,
                      textAlign: TextAlign.center,
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
                    Vibration.vibrate(duration: 100);
                    setState(() {
                      index = 2;
                    });
                    updateIndex();
                  },
                  onDoubleTap: () {
                    setState(() {
                      index = 2;
                    });
                    updateIndex();
                    editCallback(index);
                  },
                  child: Container(
                    color: widget.storyData[2].textStyle.backgroundColor != null
                        ? widget.storyData[2].textStyle.backgroundColor
                        : Colors.transparent,
                    child: Text(
                      widget.storyData[2].text,
                      textAlign: TextAlign.center,
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
    print("Tapped " + index.toString());
  }

  void editCallback(int index) {
    print("Double Tapped " + index.toString());
    widget.editCallback(index);
  }
}

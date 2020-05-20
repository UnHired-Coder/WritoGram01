import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:vibration/vibration.dart';
import 'package:writogram/Animations/ButtonBounceAnimation.dart';
import 'package:writogram/Modals/StoryData.dart';

class StoryPaintWidget extends StatefulWidget {
  final List<StoryData> storyData;
  final Function updateTransform;
  final Function updateEnded;
  final Function editCallback;

  StoryPaintWidget(
      {this.storyData,
      this.updateTransform,
      this.updateEnded,
      this.editCallback});

  @override
  _StoryPaintWidgetState createState() => _StoryPaintWidgetState();
}

class _StoryPaintWidgetState extends State<StoryPaintWidget> {
  int index = 0;
  int prev = 0;
  bool deleteButtonVisible = false;

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
            }
            deleteButtonVisible = true;
            widget.updateTransform(m, index);
            prev = index;
          },
          onMatrixUpdateEnd: (value) {
            widget.updateEnded(value);
            deleteButtonVisible = false;
          },
//    getNewWidgets()+
          child: Stack(
              children: getNewTexts() +
                  [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        maintainState: true,
                        visible: deleteButtonVisible,
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(bottom: 40),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ]),
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

  List<Widget> getNewTexts() {
    List<Widget> w = [];
    for (int i = 0; i < widget.storyData.length; i++) {
      w.add(getNew(i));
    }
    return w;
  }

//  List<Widget> getNewWidgets() {
//    List<Widget> w = [];
//    for (int i = 0; i <  widget.storyData.length; i++) {
//      w.add(getNewContainer(i));
//    }
//    return w;
//  }

  Widget getNew(int _index) {
    return Container(
      transform: widget.storyData[_index].transform,
      child: Container(
        color: widget.storyData[_index].textStyle.backgroundColor != null
            ? widget.storyData[_index].textStyle.backgroundColor
            : Colors.transparent,
        child: ButtonBounceAnimation(
          scale: 1,
          duration: 200,
          how: 0.6,
          onTap: () {
            Vibration.vibrate(duration: 100);
            setState(() {
              index = _index;
            });
            updateIndex();
          },
          onDoubleTap: () {
            setState(() {
              index = _index;
            });
            updateIndex();
            editCallback(index);
          },
          child: Text(
            widget.storyData[_index].text,
            textAlign: TextAlign.center,
            style: TextStyle(
//                backgroundColor: Colors.white,
//                decoration: TextDecoration.lineThrough,
//                decorationStyle: TextDecorationStyle.solid,
//                shadows: [Shadow(color: Colors.black,blurRadius: 10,offset: Offset(5,5))],
                fontSize: widget.storyData[_index].textStyle.fontSize,
                fontFamily: widget.storyData[_index].textStyle.fontFamily,
                color: widget.storyData[_index].textStyle.color

//                color: Colors.transparent
                ),
          ),
        ),
      ),
    );
  }

//  Widget getNewContainer(int _index) {
//    return Container(
//      transform: widget.storyData[_index].transform,
//      child: GestureDetector(
//        onTap: () {
//          Vibration.vibrate(duration: 100);
//          setState(() {
//            index = _index;
//          });
//          updateIndex();
//        },
//        onDoubleTap: () {
//          setState(() {
//            index = _index;
//          });
//          updateIndex();
//          editCallback(index);
//        },
//        child: Container(
//            color: widget.storyData[_index].textStyle.backgroundColor != null
//                ? widget.storyData[_index].textStyle.backgroundColor
//                : Colors.transparent,
//            child: Container(
//              width: 100,
//              height: 100,
//              decoration: BoxDecoration(
//                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
//            )),
//      ),
//    );
//  }
}

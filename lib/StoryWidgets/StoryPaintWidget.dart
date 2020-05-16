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
                    color: Colors.blue.withOpacity(0.5),
                    child: Text(
                      widget.storyData[0].text,
                      style: TextStyle(fontSize: 50),
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
                    color: Colors.blue.withOpacity(0.5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.storyData[1].text,
                      style: TextStyle(fontSize: 50),
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
                    color: Colors.blue.withOpacity(0.5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.storyData[2].text,
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
              Container(
                transform: widget.storyData[3].transform,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                    updateIndex();
                  },
                  child: Container(
                    color: Colors.blue.withOpacity(0.5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.storyData[3].text,
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ],
    );
  }

  void updateIndex() {
    setState(() {
//      index = 0;
      print("Tapped " + index.toString());
    });
  }
}

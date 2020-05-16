import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/StoryData.dart';
import 'StoryPaintWidget.dart';
import 'package:writogram/imported/Swatches.dart';

class StoryWidgetHandler extends StatefulWidget {
  final List<StoryData> storyData;
  final Function updateTransform;
  final Function stackSwitchCallback;




  StoryWidgetHandler(
      {this.storyData, this.updateTransform, this.stackSwitchCallback});

  @override
  _StoryWidgetHandlerState createState() => _StoryWidgetHandlerState();
}

class _StoryWidgetHandlerState extends State<StoryWidgetHandler> {
  Queue<Color> backgroundColors = new Queue();
  Color backgroundColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    backgroundColor = Colors.black;
    backgroundColors.add(Colors.black);
    for(int i=0;i<swatches.length;i+=10){
      backgroundColors.add(swatches[i].withOpacity(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (value) {
        debugPrint("Slide to Change backGround");
        updateBackground(value.globalPosition.dx);
      },
      onTap: () {
        widget.stackSwitchCallback();
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color:  backgroundColor,
          padding: EdgeInsets.all(10),
          child: StoryPaintWidget(
            storyData: widget.storyData,
            updateTransform: updateTransform,
          )),
    );
  }


  double prev;
  updateBackground(double value) {
    setState(() {
      print("Update Background "+ value.toString());
      if(value>400)
        {
          backgroundColors.addFirst(backgroundColors.last);
          backgroundColors.removeLast();
          backgroundColor = backgroundColors.first;
        }
      else if(value <50){
        backgroundColors.addLast(backgroundColors.first);
        backgroundColors.removeFirst();
        backgroundColor = backgroundColors.last;
      }
      });
  }

  void updateTransform(Matrix4 m, int index) {
    widget.updateTransform(m, index);
  }
}

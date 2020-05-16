import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/StoryData.dart';

import 'StoryPaintWidget.dart';

class StoryWidgetHandler extends StatefulWidget {

  final List<StoryData> storyData;
  final Function updateTransform;
  final Function stackSwitchCallback;

  StoryWidgetHandler({this.storyData, this.updateTransform, this.stackSwitchCallback});

  @override
  _StoryWidgetHandlerState createState() => _StoryWidgetHandlerState();
}

class _StoryWidgetHandlerState extends State<StoryWidgetHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){ widget.stackSwitchCallback();} ,
      child: Container(
        color: Colors.grey.withOpacity(0.4),
        padding: EdgeInsets.all(10),
        child: StoryPaintWidget(
          storyData: widget.storyData,
          updateTransform: updateTransform,
        )
      ),
    );
  }

  void updateTransform(Matrix4 m,int index){
    widget.updateTransform(m,index);
  }

}

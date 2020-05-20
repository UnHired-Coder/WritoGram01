import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/StoryData.dart';
import 'StoryPaintWidget.dart';

class StoryWidgetHandler extends StatefulWidget {
  final List<StoryData> storyData;
  final Function updateTransform;
  final Function updateEnded;
  final Function stackSwitchCallback;
  final Function editCallback;
  Color backgroundColor;

  StoryWidgetHandler(
      {this.storyData,
      this.updateTransform,
      this.updateEnded,
      this.stackSwitchCallback,
      this.editCallback,
      this.backgroundColor});

  @override
  _StoryWidgetHandlerState createState() => _StoryWidgetHandlerState();
}

class _StoryWidgetHandlerState extends State<StoryWidgetHandler> {
  bool disabled;
  TextStyle defaultTextStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultTextStyle =
        TextStyle(color: Colors.white, fontFamily: "DM_Mono", fontSize: 35);
    widget.backgroundColor = Colors.black;
    disabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.storyData
            .add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 0,TextAlign.center));
        widget.stackSwitchCallback();
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(color: widget.backgroundColor),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(40),
//              image: DecorationImage(
//                  image: AssetImage("images/back.jpg"), fit: BoxFit.cover)),
          padding: EdgeInsets.all(10),
          child: StoryPaintWidget(
            storyData: widget.storyData,
            updateTransform: updateTransform,
            updateEnded: updateEnded,
            editCallback: editCallback,
          )),
    );
  }

  void updateEnded(ScaleEndDetails details) {
    widget.updateEnded(details);
    print("Update Ended");
  }

  void updateTransform(Matrix4 m, int index) {
    widget.updateTransform(m, index);
  }

  void editCallback(int index) {
    print("Double Tapped  Edit Handeler");
    widget.editCallback(index);
  }
}

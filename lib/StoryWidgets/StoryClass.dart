import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/StoryData.dart';

import 'CreateTextWidget.dart';
import 'StoryWidgetHandeler.dart';

class StoryClass extends StatefulWidget {
  @override
  _StoryClassState createState() => _StoryClassState();
}

class _StoryClassState extends State<StoryClass> {
  List<StoryData> storyData = [];
  bool createTextVisible = false;
  bool paintStoryVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storyData.add(new StoryData(Matrix4.zero(), "", 0));
    storyData.add(new StoryData(Matrix4.identity(), "Again", 1));
    storyData.add(new StoryData(Matrix4.identity(), "How ", 2));
    storyData.add(new StoryData(Matrix4.identity(), "Come?", 3));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Visibility(
            visible: paintStoryVisible,
            child: Container(
              child: StoryWidgetHandler(
                storyData: storyData,
                updateTransform: updateTransform,
                stackSwitchCallback: switchStackCallback,
              ),
            ),
          ),
        ),
        Visibility(
          visible: createTextVisible,
          child: CreateTextStory(),
        )
      ],
    );
  }

  void updateTransform(Matrix4 m, int index) {
    setState(() {
      storyData[index].transform = m;
    });
  }

  void switchStackCallback() {
    setState(() {
      if (!createTextVisible) {
        createTextVisible = true;
        paintStoryVisible = false;
      } else {
        createTextVisible = false;
        paintStoryVisible = true;
      }
    });
  }
}

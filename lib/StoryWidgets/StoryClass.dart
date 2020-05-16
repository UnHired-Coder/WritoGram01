import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/StoryData.dart';
import 'package:writogram/Modals/TextCompleteData.dart';

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
  static int index;

  TextStyle defaultTextStyle;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    defaultTextStyle = TextStyle(color: Colors.white, fontFamily: "DM_Mono");

    storyData.add(new StoryData(Matrix4.zero(), "",defaultTextStyle, 0));
    storyData.add(new StoryData(Matrix4.zero(), "",defaultTextStyle, 1));
    storyData.add(new StoryData(Matrix4.zero(), "",defaultTextStyle, 2));
    storyData.add(new StoryData(Matrix4.zero(), "",defaultTextStyle, 3));
    index = 0;
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
          child: CreateTextStory(doneCallback: doneCallback,stackSwitchCallback: switchStackCallback,index: index,),
        )
      ],
    );
  }

  void doneCallback(TextCompleteData completeData) {
    print("DoneCallBack");
    setState(() {
      storyData[completeData.index].text = completeData.text;
      storyData[completeData.index].transform = completeData.position;
      storyData[completeData.index].textStyle = completeData.textStyle;
      switchStackCallback();
      index++;
    });

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

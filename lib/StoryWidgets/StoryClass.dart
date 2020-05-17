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
  bool actionButtonVisible = true;

  static int index;
  static int editIndex;
  static bool edit;
  TextStyle defaultTextStyle;
  StoryData editTextCompleteData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    defaultTextStyle =
        TextStyle(color: Colors.white, fontFamily: "DM_Mono", fontSize: 35);

    storyData.add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 0));
    storyData.add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 1));
    storyData.add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 2));
    storyData.add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 3));
    index = 0;
    editIndex = 0;
    edit = false;

    editTextCompleteData =
        new StoryData(Matrix4.zero(), "", defaultTextStyle, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Visibility(
              visible: actionButtonVisible,
              child: Container(
                  margin: EdgeInsets.all(2), child: getTopIcons(context)),
            ),
          ),
          body: Visibility(
            maintainState: true,
            visible: paintStoryVisible,
            child: Container(
              child: StoryWidgetHandler(
                storyData: storyData,
                updateTransform: updateTransform,
                stackSwitchCallback: switchStackCallback,
                editCallback: editCallback,
              ),
            ),
          ),
          persistentFooterButtons: <Widget>[
            Visibility(
                visible: actionButtonVisible, child: getBottomIcons(context))
          ],
        ),
        Visibility(
          visible: createTextVisible,
          child: CreateTextStory(
            doneCallback: doneCallback,
            editDoneCallback: editDoneCallback,
            stackSwitchCallback: switchStackCallback,
            index: index,
            edit: edit,
            completeData: editTextCompleteData,
          ),
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
    });
    index++;
  }

  void editCallback(index) {
    print("Double Tapped  Edit --Story Class  " + index.toString());
    switchStackCallback();
    setState(() {
      edit = true;
      editIndex = index;
      editTextCompleteData = storyData[index];
      createTextVisible = true;
    });
  }

  void editDoneCallback(TextCompleteData completeData) {
    print("Edit Done  Edit");
    setState(() {
      storyData[editIndex].text = completeData.text;
      storyData[editIndex].textStyle = completeData.textStyle;
      edit = false;
      switchStackCallback();
    });
  }

  void updateTransform(Matrix4 m, int index) {
    setState(() {
      storyData[index].transform = m;
      actionButtonVisible = false;
    });
  }

  void switchStackCallback() {
    setState(() {
      if (!createTextVisible) {
        createTextVisible = true;
//        paintStoryVisible = false;
      } else {
        createTextVisible = false;
        paintStoryVisible = true;
      }
    });
  }

  Widget getBottomIcons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.save_alt,
            color: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            margin: EdgeInsets.only(right: 15, left: 10),
            child: Icon(
              Icons.donut_large,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget getTopIcons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.save_alt,
            color: Colors.white,
          ),
        ),
        Container(
          width: 200,
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.format_paint,
            color: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.text_fields,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

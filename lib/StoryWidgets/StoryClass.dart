import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Animations/ButtonBounceAnimation.dart';
import 'package:writogram/Modals/StoryData.dart';
import 'package:writogram/Modals/TextCompleteData.dart';
import 'package:writogram/imported/Swatches.dart';



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
  Color backgroundColor = Colors.transparent;
  Queue<Color> backgroundColors = new Queue();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    defaultTextStyle =
        TextStyle(color: Colors.white, fontFamily: "DM_Mono", fontSize: 35);



    // HERE
    storyData.add(new StoryData(Matrix4.zero(), "", defaultTextStyle, 0,TextAlign.center));
    index = 0;
    editIndex = 0;
    edit = false;



    editTextCompleteData =
        new StoryData(Matrix4.zero(), "", defaultTextStyle, 0,TextAlign.center);



    backgroundColors.add(Colors.black);
    for (int i = 0; i < swatches.length; i += 5) {
      backgroundColors.add(swatches[i].withOpacity(1));
    }
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
                updateEnded: updateEnded,
                stackSwitchCallback: switchStackCallback,
                editCallback: editCallback,
                backgroundColor: backgroundColor,
              ),
            ),
          ),
          persistentFooterButtons: <Widget>[
            Visibility(
                visible: actionButtonVisible,
                child: Row(children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height/25,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backgroundColor,
                        border: Border.all(color: Colors.white, width: 2)),
                    width: MediaQuery.of(context).size.width - 250,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: GestureDetector(
                      onVerticalDragStart: (value) {
                        print("Dragged to change Background " +
                            value.localPosition.dx.toString());
                        updateBackground(value.localPosition.dx);
                      },
                    ),
                  ),
                  Container(width: MediaQuery.of(context).size.width/5,height: 30,),
                  Container(child: getBottomIcons(context))
                ])),
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
    switchStackCallback();
    setState(() {
      storyData[editIndex].text = completeData.text;
      storyData[editIndex].textStyle = completeData.textStyle;
      print(completeData.textStyle.fontSize.toString());
      edit = false;
    });
  }



  void updateTransform(Matrix4 m, int index) {
    setState(() {
      storyData[index].transform = m;
      actionButtonVisible = false;
    });
  }



  void updateEnded(ScaleEndDetails details) {
    setState(() {
      actionButtonVisible = true;
      print("Update Ended");
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
      mainAxisAlignment: MainAxisAlignment.end,

      children: <Widget>[
        ButtonBounceAnimation(
          scale: 1,
          duration: 300,
          how: 1,
          onTapCallBack: switchStackCallback,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.format_paint,
              color: Colors.white,
            ),
          ),
        ),
        ButtonBounceAnimation(
          scale: 1,
          duration: 300,
          how: 1,
          onTapCallBack: switchStackCallback,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.text_fields,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  updateBackground(double value) {
    setState(() {
      print("Update Background " + value.toString());
      if (value > 100) {
        backgroundColor = backgroundColors.last;
        backgroundColors.addFirst(backgroundColors.last);
        backgroundColors.removeLast();
      } else if (value < 100) {
        backgroundColor = backgroundColors.first;
        backgroundColors.addLast(backgroundColors.first);
        backgroundColors.removeFirst();
      }
    });
  }
}

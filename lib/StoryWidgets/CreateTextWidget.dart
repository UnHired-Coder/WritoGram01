import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Animations/ButtonBounceAnimation.dart';
import 'package:writogram/Modals/StoryData.dart';
import 'package:writogram/Modals/TextCompleteData.dart';
import 'package:writogram/Widgets/CustomTextStoryWodgets/CustomAlignmentWidget.dart';
import 'package:writogram/Widgets/CustomTextStoryWodgets/CustomFontChooserWidget.dart';
import 'package:writogram/Widgets/CustomTextStoryWodgets/CustomSeekBar.dart';
import 'package:writogram/imported/Swatches.dart';


class CreateTextStory extends StatefulWidget {
  final Function doneCallback;
  final Function editDoneCallback;
  final Function stackSwitchCallback;
  final int index;
  final bool edit;
  final StoryData completeData;

  CreateTextStory(
      {this.doneCallback,
      this.editDoneCallback,
      this.stackSwitchCallback,
      this.index,
      this.edit,
      this.completeData});

  @override
  _CreateTextStoryState createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  TextEditingController controller;
  TextStyle textStyle;
  Color color;
  Color boxColor;
  double size;
  TextAlign alignment;
  IconData fillBoxIcon;
  bool fillBox;
  double valueHolder;
  bool sliderVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit) {
      fillBoxIcon = Icons.check_box_outline_blank;
      textStyle = widget.completeData.textStyle;
      color = widget.completeData.textStyle.color;
      size = widget.completeData.textStyle.fontSize;
      alignment = widget.completeData.alignment;
      print(size);
      if (boxColor == null)
        fillBox = false;
      else
        fillBox = true;
      valueHolder = size;
      sliderVisible = true;
      controller = new TextEditingController();
      controller.text = widget.completeData.text;
    } else {
      fillBoxIcon = Icons.check_box_outline_blank;
      textStyle = TextStyle(color: Colors.white, fontFamily: "DM_Mono");
      color = Colors.white;
      size = 50;
      alignment = TextAlign.center;
      fillBox = false;
      valueHolder = 50;
      sliderVisible = true;
      controller = new TextEditingController();
      controller.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonBounceAnimation(
                  scale: 1,
                  duration: 500,
                  how: 1,
                  onTapCallBack: fillBoxSwitch,
                  child: Icon(
                    fillBoxIcon,
                    size: 25,
                  ),
                ),
                CustomAlignmentWidget(
                    onAlignmentChangedCallback: alignmentChangedCallback),
              ],
            ),
            CustomFontChooserWidget(
              fontChangedCallBack: fontChangedCallback,
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.black,
              onPressed: () {
                doneCallback();
              },
              child: Text(
                "Done",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: TextField(
                      controller: controller,
                      textAlign: alignment,
                      decoration: InputDecoration.collapsed(
                        hintText: "Text..",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: color,
                        fontSize: size,
                        backgroundColor: boxColor,
                        fontFamily: textStyle.fontFamily,
                      ),
                      cursorColor: Colors.grey,
                      scrollPadding: EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 9999,
                      minLines: 1,
                      autofocus: true,
                    )),
                GestureDetector(
                  onVerticalDragStart: (value) {
                    print("Make Slider Visible " + value.toString());
                    setState(() {});
                  },
                  onVerticalDragEnd: (value) {
                    setState(() {});
                  },
                  child: CustomSeekBar(
                    onDragUpdate: onFontScaledCallback,
                  ),
                ),
              ],
            ),
          ),
          //Swatches
          Container(
              height: 30,
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: swatches.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        color = swatches[index];
                      });
                    },
                    child: new Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: swatches[index]),
                      margin: EdgeInsets.only(left: 3, right: 3, top: 5),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  void onFontScaledCallback(double value) {
    setState(() {
      size = value;
      print("--------");
    });
  }

  void fontChangedCallback(TextStyle t) {
    debugPrint("FontChanged");
    setState(() {
      textStyle = t;
    });
  }

  void alignmentChangedCallback(TextAlign align) {
    setState(() {
      alignment = align;
    });
  }

  void doneCallback() {
    print("Edit Done");
    if (controller.text.toString().trim().isEmpty) {
      widget.stackSwitchCallback();
      return;
    }
    TextStyle t = new TextStyle(
        color: color,
        fontFamily: textStyle.fontFamily,
        fontSize: size,
        fontStyle: FontStyle.italic,
        backgroundColor: boxColor);
    TextCompleteData completeData = new TextCompleteData(
        text: controller.text.toString(),
        textStyle: t,
        position: Matrix4.identity(),
        index: widget.index);
    print("Complete Data Created");
    if (widget.edit)
      widget.editDoneCallback(completeData);
    else
      widget.doneCallback(completeData);
  }

  void fillBoxSwitch() {
    setState(() {
      if (!fillBox) {
        fillBoxIcon = Icons.indeterminate_check_box;
        fillBox = true;
        boxColor = Colors.white.withOpacity(0.2);
      } else {
        fillBoxIcon = Icons.check_box_outline_blank;
        fillBox = false;
        boxColor = null;
      }
    });
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/TextCompleteData.dart';
import 'package:writogram/Widgets/CustomTextStoryWodgets/CustomFontChooserWidget.dart';
import 'package:writogram/imported/Swatches.dart';

class CreateTextStory extends StatefulWidget {
  final Function doneCallback;
  final Function stackSwitchCallback;
  final int index;
  CreateTextStory({this.doneCallback,this.stackSwitchCallback,this.index});

  @override
  _CreateTextStoryState createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  TextEditingController controller;
  TextStyle textStyle;
  Color color;
  Color boxColor;
  double size;

  IconData fillBoxIcon;
  bool fillBox;
  double valueHolder;
  bool sliderVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillBoxIcon = Icons.check_box_outline_blank;
    textStyle = TextStyle(color: Colors.white, fontFamily: "DM_Mono");
    color = Colors.white;
    size = 30;
    boxColor = Colors.transparent;
    fillBox = false;
    valueHolder = 30;
    sliderVisible = true;
    controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                fillBoxSwitch();
              },
              child: Icon(
                fillBoxIcon,
                size: 25,
              ),
            ),
            Container(),
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
                    color: Colors.white.withOpacity(0.2),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                        hintText: "Text..",
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
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.height,
                      height: 10,
                      margin: EdgeInsets.only(
                          bottom: 12,
                          top: 12,
                          left: MediaQuery.of(context).size.height / 10,
                          right: MediaQuery.of(context).size.height / 20),
                      alignment: Alignment.center,
                      color: Colors.grey,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 0.0),
                        ),
                        child: Visibility(
                          visible: sliderVisible,
                          child: Slider(
                              inactiveColor: Colors.white,
                              activeColor: Colors.white,
                              value: valueHolder,
                              min: 5,
                              max: 100,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  valueHolder = value;
                                  size = valueHolder;
                                });
                              }),
                        ),
                      ),
                    ),
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

  void fontChangedCallback(TextStyle t) {
    debugPrint("FontChanged");
    setState(() {
      textStyle = t;
    });
  }

  void doneCallback() {

    if(controller.text.toString().trim().isEmpty)
      {
        widget.stackSwitchCallback();
        return;
      }

    TextStyle t = new TextStyle(color: color,fontFamily: textStyle.fontFamily,fontSize: size,fontStyle: FontStyle.italic,backgroundColor: boxColor);
    TextCompleteData completeData = new TextCompleteData(text: controller.text.toString(),textStyle: t,position: Matrix4.identity()+Matrix4.identity(),index: widget.index);
    print("Complete Data Created");
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

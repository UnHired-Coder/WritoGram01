import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Widgets/CustomTextStoryWodgets/CustomFontChooserWidget.dart';

class CreateTextStory extends StatefulWidget {
  @override
  _CreateTextStoryState createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  TextEditingController controller;
  IconData fillBoxIcon;
  bool fillBox = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillBoxIcon = Icons.check_box_outline_blank;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
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
            ),Container(),
            CustomFontChooserWidget(
              fontChangedCallBack: fontChangedCallback,
            ),
            RaisedButton(elevation: 0,color: Colors.black,onPressed: (){ doneCallback();},child: Text("Done",style: TextStyle(color: Colors.white,fontSize: 20),),)
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.withOpacity(0.2),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
              hintText: "Text..",
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
            cursorColor: Colors.grey,
            scrollPadding: EdgeInsets.all(20.0),
            keyboardType: TextInputType.multiline,
            maxLines: 99999,
            autofocus: true,
          )),
      persistentFooterButtons: <Widget>[],
    );
  }

  void fontChangedCallback() {
    debugPrint("FontChanged");
  }

  void doneCallback(){

  }

  void fillBoxSwitch() {
    setState(() {
      if (!fillBox) {
        fillBoxIcon = Icons.indeterminate_check_box;
        fillBox = true;
      } else {
        fillBoxIcon = Icons.check_box_outline_blank;
        fillBox = false;
      }
    });
  }
}

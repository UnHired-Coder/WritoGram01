import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writogram/Modals/FontTextStory.dart';

class CustomFontChooserWidget extends StatefulWidget {
  final Function fontChangedCallBack;

  CustomFontChooserWidget({this.fontChangedCallBack});

  @override
  _CustomFontChooserWidgetState createState() =>
      _CustomFontChooserWidgetState();
}

class _CustomFontChooserWidgetState extends State<CustomFontChooserWidget> {
  Queue<Widget> q = new Queue();
  Queue<int> index = new Queue();

  List<TextStyle> stylesText = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stylesText = [
      TextStyle(color: Colors.white, fontFamily: "DM_Mono"),
      TextStyle(color: Colors.white, fontFamily: "Pacifico"),
      TextStyle(color: Colors.white, fontFamily: "Oswald"),
      TextStyle(color: Colors.white, fontFamily: "DancingScript"),
      TextStyle(color: Colors.white, fontFamily: "ShadowsIntoLight"),
      TextStyle(color: Colors.white, fontFamily: "Fredoka_One"),
    ];

    q.addAll([
      createFontWidget( stylesText[0]),
      createFontWidget( stylesText[1]),
      createFontWidget( stylesText[2]),
      createFontWidget( stylesText[3]),
      createFontWidget( stylesText[4]),
      createFontWidget( stylesText[5]),
    ]);

    index.addAll([0,1,2,3,4,5]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () {
          updateQueue();
        },
        child: Stack(
          children: <Widget>[q.first],
        ),
      ),
    );
  }

  updateQueue() {
    setState(() {
      q.addFirst(q.last);
      q.removeLast();
      index.addFirst(index.last);
      index.removeLast();
      widget.fontChangedCallBack(stylesText[index.first]);
    });
  }

  Widget createFontWidget(TextStyle f) {
    Widget widget = Container(
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          border: Border.all(width: 1.0, color: Colors.white)),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        child: Center(
          child: Text(
            " Hello ",
            style: f,
          ),
        ),
      ),
    );
    return widget;
  }
}

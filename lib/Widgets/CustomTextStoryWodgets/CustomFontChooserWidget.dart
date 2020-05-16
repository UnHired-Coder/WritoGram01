import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFontChooserWidget extends StatefulWidget {
  final Function fontChangedCallBack;

  CustomFontChooserWidget({this.fontChangedCallBack});

  @override
  _CustomFontChooserWidgetState createState() =>
      _CustomFontChooserWidgetState();
}

class _CustomFontChooserWidgetState extends State<CustomFontChooserWidget> {
  Queue<Widget> q = new Queue();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    q.addAll([
      createFontWidget(TextStyle(color: Colors.white, fontFamily: "DM_Mono")),
      createFontWidget(TextStyle(color: Colors.white, fontFamily: "Pacifico")),
      createFontWidget(TextStyle(color: Colors.white, fontFamily: "Oswald")),
      createFontWidget(
          TextStyle(color: Colors.white, fontFamily: "DancingScript")),
      createFontWidget(
          TextStyle(color: Colors.white, fontFamily: "ShadowsIntoLight")),
      createFontWidget(
          TextStyle(color: Colors.white, fontFamily: "Fredoka_One")),
    ]);
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

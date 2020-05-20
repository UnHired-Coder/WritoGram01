import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:writogram/Animations/ButtonBounceAnimation.dart';

class CustomAlignmentWidget extends StatefulWidget {
  final Function onAlignmentChangedCallback;

  CustomAlignmentWidget({this.onAlignmentChangedCallback});

  @override
  _CustomAlignmentWidgetState createState() => _CustomAlignmentWidgetState();
}

class _CustomAlignmentWidgetState extends State<CustomAlignmentWidget> {
  Queue<Widget> q = new Queue();
  Queue<TextAlign> align = new Queue();
  int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    q.addAll([
      createAlignmentWidget(FontAwesomeIcons.alignCenter),
      createAlignmentWidget(FontAwesomeIcons.alignJustify),
      createAlignmentWidget(FontAwesomeIcons.alignLeft),
      createAlignmentWidget(FontAwesomeIcons.alignRight),
    ]);

    align.addAll(
        [ TextAlign.center, TextAlign.justify, TextAlign.left, TextAlign.right,] );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBounceAnimation(
        scale: 1,
        duration: 500,
        how: 1,
        onTapCallBack: () {
          alignmentChanged();
        },
        child: Container(
          padding: EdgeInsets.all(2),
          child: Stack(
            children: <Widget>[q.first],
          ),
        ));
  }

  Widget createAlignmentWidget(IconData iconData) {
    Widget widget = Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        child: Center(child: Icon(iconData, size: 20,)),
      ),
    );
    return widget;
  }

  void alignmentChanged() {
    setState(() {
      q.addFirst(q.last);
      q.removeLast();
      align.addFirst(align.last);
      align.removeLast();
      widget.onAlignmentChangedCallback(align.first);
    });
  }
}

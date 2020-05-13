import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:writogram/StoryWidgets/PainterWidgit.dart';

class TextStoryWidget extends StatefulWidget {
  final Function stackFunction;

  List<ValueNotifier<Matrix4>> notifiers;
  int current;
  int prev;
  List<Matrix4> prevPositions;
  Matrix4 prevPos;
  List<Container> widgets;
  List<String> texts;
  int widgetCount;

  TextStoryWidget(
      {this.stackFunction,
      this.notifiers,
      this.current,
      this.prev,
      this.prevPositions,
      this.widgets,
      this.texts,
      this.widgetCount});
  @override
  TextStoryWidgetState createState() => TextStoryWidgetState();
}

class TextStoryWidgetState extends State<TextStoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        setState(() {
          if (widget.widgets.length != 0 &&
              widget.widgets[widget.current] != null) {
            print(widget.current.toString() +
                " --gesture--  " +widget.notifiers.length.toString()+" "+
                widget.prev.toString());
            if (widget.current != widget.prev) {
              m.setIdentity();
              m.add(widget.prevPositions[widget.current]);
            }
            widget.notifiers[widget.current].value = m;
            widget.prev = widget.current;
          }
        });
      },
      child: Stack(
          children: [
                Container(
                  child: GestureDetector(
                      onTap: () {
                        widget.stackFunction();
                      },
                      child: new Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Text(
                              widget.notifiers[widget.current].value.toString()),Text(widget.current.toString()),Text(widget.widgets.length.toString())]
                        ),
                        color: Colors.blue,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )),
                )
              ] +
              widget.widgets),
    ));
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Backup/PainterWidgit.dart';
import 'Backup/TextStoryPaintWidget.dart';
import 'StoryWidgets/StoryClass.dart';

void main() => runApp(MaterialApp(
      home: StoryClass(),
    ));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool bottomVisible = false;
  bool topVisible = true;
  int textsCount = 0;
  List<TextEditingController> controllers = [];
  TextEditingController controller = new TextEditingController();

  List<ValueNotifier<Matrix4>> notifiers = [ValueNotifier(Matrix4.identity())];
  int current = 0;
  int prev = 0;
  List<Matrix4> prevPositions = [Matrix4.identity()];
  Matrix4 prevPos = Matrix4.identity();
  List<Container> widgets = [Container()];
  List<String> texts = [""];
  int widgetCount = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: topVisible,
          child: Scaffold(
            appBar: AppBar(
              elevation: 4,
              backgroundColor: Colors.black.withOpacity(0.5),
              title: Container(
                  margin: EdgeInsets.all(2), child: getTopIcons(context)),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: TextStoryWidget(
                stackFunction: stackSwitcher,
                current: current,
                prev: prev,
                notifiers: notifiers,
                prevPositions: prevPositions,
                widgets: widgets,
                widgetCount: widgetCount,
                texts: texts,
                updateTransform: updateTransform,
              ),
            ),
            persistentFooterButtons: <Widget>[
              Container(
                color: Colors.black,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: getBottomIcons(context),
              )
            ],
          ),
        ),
        Visibility(
            visible: bottomVisible,
            child: Scaffold(
              backgroundColor: Colors.grey.withOpacity(0.2),
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Top"),
                    RaisedButton(
                        child: Text("Done"),
                        onPressed: () {
                          setState(() {
                            //print
                            addNewTextWidget(controller.text.toString());
                          });
                        }),
                  ],
                ),
              ),
              body: Container(
                color: Colors.grey.withOpacity(0.2),
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  onEditingComplete: () => controller.clear(),
                ),
              ),
            ))
      ],
    );
  }

  void stackSwitcher() {
    setState(() {
      if (!topVisible) {
        topVisible = true;
        bottomVisible = false;
      } else {
        topVisible = false;
        bottomVisible = true;
        controller.clear();
      }
    });
  }

  void addNewTextWidget(String text) {
    print("Add New Text");

    if (text.trim().isEmpty) {
      stackSwitcher();
      return;
    }

    setState(() {
      notifiers.add(new ValueNotifier(Matrix4.identity()));
      prevPositions.add(Matrix4.identity());
      texts.add(text);

      current++;
      widgetCount++;

      widgets.add(new Container(
          child: PainterWidget(
        notifiers: notifiers,
        text: texts[current],
        current: current,
        update: updateCurrentState,
      )));
    });
    stackSwitcher();
  }

  void updateTransform(Matrix4 m, int index) {
    setState(() {
      notifiers[index - 1].value = m;
      print("Move" + index.toString());
    });
  }

  void updateCurrentState(int index) {
    setState(() {
      current = index;
    });
  }

  void stateFunction(Matrix4 m, int index) {
    setState(() {
      print("Called");
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
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Icon(
            Icons.save_alt,
            color: Colors.white,
          ),
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

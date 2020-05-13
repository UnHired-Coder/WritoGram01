//import 'package:flutter/cupertino.dart';
//import 'package:vibration/vibration.dart';
//
//import 'TextStoryPaintWidget.dart';
//
//class CommonWidgets extends StatefulWidget {
//  static int selected = 0;
//
//
//  @override
//  _CommonWidgetsState createState() => _CommonWidgetsState();
//
//
//  Widget newTextPaint(
//      ValueNotifier<Matrix4> notifier,
//      List<ValueNotifier<Matrix4>> notifiers,
//      List<Matrix4> prevPosn,
//      String text,
//      int index) {
//    return Positioned.fill(
//      child: Container(
//        transform: notifiers[index].value,
//        child: FittedBox(
//            fit: BoxFit.contain,
//            child: GestureDetector(
//                onTap: () {
//                  selected = index;
//                  print("Edit+" + index.toString());
//                  Vibration.vibrate(duration: 200);
//                  TextStoryWidget.met(index, selected);
//                },
//                child: Container(
//                    decoration: BoxDecoration(
//                        color: Color.fromARGB(index * 1000, 1212, 1212, 2121)),
//                    padding: EdgeInsets.only(left: 10, right: 10),
//                    margin: EdgeInsets.all(10),
//                    child: Text(
//                      text,
//                      style: TextStyle(fontSize: 12),
//                    )))),
//      ),
//    );
//  }
//}
//
//class _CommonWidgetsState extends State<CommonWidgets> {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}

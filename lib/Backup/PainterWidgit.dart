import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';

class PainterWidget extends StatefulWidget {
  final List<ValueNotifier<Matrix4>> notifiers;
  final String text;
  final int current;
  final Function update;

  PainterWidget({this.notifiers, this.text, this.current, this.update});

  @override
  _PainterWidgetState createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {


  @override
  Widget build(BuildContext context) {

    print(widget.current.toString() +" _paint");
    return Positioned.fill(
      child: Container(
        transform: widget.notifiers[widget.current].value,
        child: FittedBox(
            fit: BoxFit.contain,
            child: GestureDetector(
                onTap: () {
                  print("Edit -> " + widget.notifiers[widget.current].value.toString());
                  Vibration.vibrate(duration: 200);
                  widget.update(widget.current);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(1, 500, 500, 100)),
                  child: Text(widget.text),
                ))),
      ),
    );
  }

  void transformThis(){

  }

}

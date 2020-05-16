import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTextStory extends StatefulWidget {
  @override
  _CreateTextStoryState createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.withOpacity(0.2),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
              hintText: "Text...",
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white,fontSize: 30),
            cursorColor: Colors.grey,
            scrollPadding: EdgeInsets.all(20.0),
            keyboardType: TextInputType.multiline,
            maxLines: 99999,
            autofocus: true,
          )),
      persistentFooterButtons: <Widget>[],
    );
  }
}

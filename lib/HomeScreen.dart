import 'package:flutter/material.dart';

class SomethingElse extends StatelessWidget {
  static const String id = "somethingElse";
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
//      color: Colors.black54,
      home: SafeArea(child: Scaffold(
        backgroundColor: Colors.black,
//        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Center(child: Text("TBD",style: TextStyle(color: Colors.blueAccent),),),],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';

class SomethingElse extends StatelessWidget {
  static const String id = "somethingElse";
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SafeArea(child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Center(child: Text("TBD")),],
        ),
      )),
    );
  }
}

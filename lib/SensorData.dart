import 'package:flutter/material.dart';

class SensorData extends StatefulWidget {
  static const String id = "sensorDataScreen";
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Center(child: Text("Call sensor data here")),],
    ),
      )),
    );
  }
}

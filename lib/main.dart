import 'package:flutter/material.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/SomethingElse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: Login.id,
      routes: {
      Login.id : (context) => Login(),
        MainCommon.id : (context) => MainCommon(),
        SensorData.id:(context)=>SensorData(),
        SomethingElse.id : (context) => SomethingElse(),
      },

    );

  }
}

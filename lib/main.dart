import 'package:flutter/material.dart';
import 'package:iot_j_comp/WelcomeScreen.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/SomethingElse.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/RegistrationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: WelcomeScreen.id,
      routes: {
      WelcomeScreen.id : (context) => WelcomeScreen(),
    Login.id:(context)=> Login(),
        RegistrationScreen.id:(context) =>RegistrationScreen(),
        MainCommon.id : (context) => MainCommon(),
        SensorData.id:(context)=>SensorData(),
        SomethingElse.id : (context) => SomethingElse(),
      },

    );

  }
}

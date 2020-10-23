import 'package:flutter/material.dart';
import 'package:iot_j_comp/Affected.dart';
import 'package:iot_j_comp/ResetPassword.dart';
import 'package:iot_j_comp/WelcomeScreen.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/RegistrationScreen.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';

void main() {

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
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
      theme: ThemeData.dark(),
    initialRoute: WelcomeScreen.id,
      routes: {
      WelcomeScreen.id : (context) => WelcomeScreen(),
    Login.id:(context)=> Login(),
        RegistrationScreen.id:(context) =>RegistrationScreen(),
        MainCommon.id : (context) => MainCommon(),
        SensorData.id:(context)=>SensorData(),
        ResetPass.id : (context)=> ResetPass(),
        SomethingElse.id : (context) => SomethingElse(),
        Affected.id : (context) => Affected(),
      },

    );

  }
}

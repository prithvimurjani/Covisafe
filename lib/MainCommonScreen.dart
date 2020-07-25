import 'package:flutter/material.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/SomethingElse.dart';

class MainCommon extends StatefulWidget {
  static const String id = "maincommonscreen";
  @override
  _MainCommonState createState() => _MainCommonState();
}

class _MainCommonState extends State<MainCommon> {

  int _selectedIndex =0 ;



  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      SomethingElse(),
      SensorData(),

    ];

    return MaterialApp(
      home: SafeArea(child: Scaffold(
        body: _pageOptions[_selectedIndex],
      //  bottomNavigationBar: BottomNavigationBar(items: const<Widget>[]),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iot_j_comp/Affected.dart';
import 'package:iot_j_comp/InfoGraphics.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/HomeScreen.dart';
import 'package:iot_j_comp/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainCommon extends StatefulWidget {
  static const String id = "maincommonscreen";
  @override
  _MainCommonState createState() => _MainCommonState();
}

class _MainCommonState extends State<MainCommon> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      SomethingElse(),
      SensorData(),
      Affected(),
      InfoGraphics(),
    ];

    return MaterialApp(
      color: Colors.black,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.black,
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                (Icons.dashboard),
              ),
              title: Text("Dashboard"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                (MaterialIcons.healing),
              ),
              title: Text("Affected"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                (Icons.bar_chart_outlined),
              ),
              title: Text("Affected"),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPinkColor,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      )),
    );
  }
}

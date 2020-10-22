import 'package:flutter/material.dart';
import 'package:iot_j_comp/Affected.dart';
import 'package:iot_j_comp/SensorData.dart';
import 'package:iot_j_comp/HomeScreen.dart';

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
      Affected(),

    ];

    return MaterialApp(
      color: Colors.black,
      home: SafeArea(child: Scaffold(
        backgroundColor: Colors.black,
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon((Icons.dashboard),),
            title: Text("Dashboard"),
            ),
            BottomNavigationBarItem(
              icon: Icon((Icons.dashboard),),
            title: Text("Affected"),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: (int index){
            setState(() {
              _selectedIndex=index;
            });
          },
        ),
      )),
    );
  }
}

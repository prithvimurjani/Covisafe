import 'package:flutter/material.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';

class Login extends StatelessWidget {
  static const String id ="login_screen";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, MainCommon.id);
                    },
                    child: Icon(Icons.add)),
              ),
              Text("Add the default google sign in button above this ")
            ],
          ),
        ),
      ),
    );
  }
}

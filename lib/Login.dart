import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String id ="login_screen";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Center(
                child: GestureDetector(
                    onTap: (){

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

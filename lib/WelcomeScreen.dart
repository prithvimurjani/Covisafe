import 'package:flutter/material.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/RegistrationScreen.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcomescreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text('IOT J COMP',style: TextStyle(color: Colors.white),)),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(buttonColor: Colors.purple, title: 'LOG IN',onPressed:(){ Navigator.pushNamed(context, Login.id);},),

            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: RoundedButton(buttonColor: Colors.white, title: 'REGISTER',onPressed:(){ Navigator.pushNamed(context, RegistrationScreen.id);},),
            ),
          ],
        ),
      ),
    );
  }
}

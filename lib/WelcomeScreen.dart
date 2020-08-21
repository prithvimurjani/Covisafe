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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('IOT J COMP'),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(buttonColor: Colors.lightBlueAccent, title: 'Log in',onPressed:(){ Navigator.pushNamed(context, Login.id);},),

            RoundedButton(buttonColor: Colors.blueAccent, title: 'Register',onPressed:(){ Navigator.pushNamed(context, RegistrationScreen.id);},),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/RegistrationScreen.dart';
import 'constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcomescreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text('WELCOME TO SCDAA.',style: TextStyle(color: Colors.blue,fontSize: 32.0),)),

            Center(child: Text('ECE 3026',style: TextStyle(color: Colors.white,fontSize:16.0),)),
            SizedBox(
              height: 270.0,
            ),
            RoundedButton(colour: Colors.blue, title: 'LOGIN',onPressed:(){ Navigator.pushNamed(context, Login.id);},),

            RoundedButton(colour: Colors.white, title: 'SIGN UP',onPressed:(){ Navigator.pushNamed(context, RegistrationScreen.id);},),
            Padding(
              padding: const EdgeInsets.only(top:25.0),
              child: Center(child: Text('HERE FOR YOU.',style: TextStyle(color: Colors.blue,fontSize:20.0,fontStyle: FontStyle.italic),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Icon(FontAwesome.life_saver,color: Colors.blue,size: 75.0,),
            ),
          ],
        ),
      ),
    );
  }
}

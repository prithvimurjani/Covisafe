import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Login extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool showSpinner= false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: SpinKitFadingGrid(
          color: Colors.white,
          size: 50.0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),

              RoundedButton(colour: Colors.lightBlueAccent,title: 'Log in',onPressed: () async{
                setState(() {
                  showSpinner=true;
                });
                try{
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                if(user!=null){
                  Navigator.pushNamed(context, MainCommon.id);
                }
                setState(() {
                  showSpinner=false;
                });
                }catch(err){
                  print(err);
                }


              },)
            ],
          ),
        ),
      ),
    );
  }
}

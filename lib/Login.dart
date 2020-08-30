import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:iot_j_comp/RegistrationScreen.dart';
import 'package:iot_j_comp/ResetPassword.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

//  void showToast() {
//    FlutterFlexibleToast.showToast(
//      message: "Login failed",
//      toastLength: Toast.LENGTH_LONG,
//      toastGravity: ToastGravity.BOTTOM,
//      elevation: 10,
//      textColor: Colors.blue,
//      backgroundColor: Colors.white,
//    );
//  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: SpinKitFadingGrid(
            color: Colors.blue,
            size: 50.0,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
             padding: EdgeInsets.only(top:120,left: 8,right: 8),
                children: <Widget>[
                  Text('Welcome Back!',style: TextStyle(color: Colors.blue,fontSize: 32.0),),
                  //Icon(FontAwesome.smile_o,color: Colors.blue,),
                  SizedBox(
                    height: 90.0,
                  ),
                  Column(
                    children: <Widget>[

                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          email = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email',hintStyle: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          password=value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.white)),
                      ),

                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:40.0),
                            child: RoundedButton(colour: Colors.blue,title: 'Login',onPressed: () async{
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


                            },),
                          ),

                          GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, RegistrationScreen.id);
                              },
                              child: Center(child: Text("I WANT TO SIGN UP!",style: TextStyle(color: Colors.blue,fontSize: 16,fontStyle: FontStyle.italic),))),
                          Padding(
                            padding: const EdgeInsets.only(top:18.0),
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, ResetPass.id);
                                },
                                child: Center(child: Text("FORGOT PASSWORD?",style: TextStyle(color: Colors.blue,fontSize: 16,fontStyle: FontStyle.italic),))),
                          ),


                        ],
                      ),
                      Column(
                        children: <Widget>[
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

                    ],
                  ),



                ],
              ),
            ),
          ),
        ),
    );
  }
}

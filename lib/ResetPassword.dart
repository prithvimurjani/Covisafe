import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RegistrationScreen.dart';

class ResetPass extends StatefulWidget {
  static const String id = 'reset pass';
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

  String email;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
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
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('We\'ve got you back!',style: TextStyle(color: Colors.blue,fontSize: 32.0),),
                  //Icon(FontAwesome.smile_o,color: Colors.blue,),
                  SizedBox(
                    height: 50.0,
                  ),
                  Column(
                    children: <Widget>[

                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          email = value;
                          print(email);
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email',hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:40.0),
                            child: RoundedButton(colour: Colors.blue,title: 'Reset!',onPressed: () async {
                              setState(() {
                                showSpinner=true;
                              });
                              print(email);

                              try{
                                final resetPass = await _auth.sendPasswordResetEmail(email: email);
                                setState(() {
                                  showSpinner=false;
                                });
                              }catch(err){
                                print(err);
                              }

                              print('Reset pressed');

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

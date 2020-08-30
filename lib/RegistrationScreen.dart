import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot_j_comp/Login.dart';
import 'package:iot_j_comp/MainCommonScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final DBRef = FirebaseDatabase.instance.reference();
  String email;
  String password;
  double temp=0.0;
  double distance=35.0;
  String areaReside='';
  String alertLevel = "HIGH";

//  Future<void> initialDetails(String email) async {
//    final confirmData = await
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              Text('Get on board!',style: TextStyle(color: Colors.blue,fontSize: 32.0),),

              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email',hintStyle: TextStyle(color: Colors.blue)),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.blue)),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(colour: Colors.blueAccent,title: 'Register',onPressed: ()async{
                setState(() {
                  showSpinner=true;
                });
                print(email);
                print(password);
                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser!=null)
                    {
                      DBRef.child("Users").push().set({
                        'email' : email,
                        'temp' : temp,
                        'distance' : distance,
                        'area' : areaReside,
                        'alertLevel' : alertLevel,
                      }).then((_) {
                        setState(() {
                          showSpinner=false;
                        });

                        Navigator.pushNamed(context, MainCommon.id);
                      }).catchError((onError){
                        print(onError);
                      });
                       }
                }catch(err){
                  print(err);
                }

              },),
            GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, Login.id);
                },
                child: Center(child: Text("EXISTING USER!",style: TextStyle(color: Colors.blue,fontSize: 16,fontStyle: FontStyle.italic),))),

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
        ),
      ),
    );
  }
}


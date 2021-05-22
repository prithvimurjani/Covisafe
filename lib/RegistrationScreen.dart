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
  String phoneNumber;
  String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: SpinKitFadingGrid(
            color: Colors.white,
            size: 50.0,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              padding: EdgeInsets.only(top: 100, left: 8, right: 8),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Get on board!',
                  style: TextStyle(color: Colors.black, fontSize: 32.0),
                ),
                SizedBox(
                  height: 80.0,
                ),
                Card(
                  // margin: const EdgeInsets.only(top: 10.0),
                  // margin: EdgeInsetsGeometry.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        'For essential workers only.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          //textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            name = value;
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              //fillColor: Colors.white,
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          // textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            email = value;
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          obscureText: true,
                          //  textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            password = value;
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          obscureText: true,
                          //  textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            phoneNumber = value;
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 34.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Submit!",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    highlightColor: kPinkColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      print(email);
                      print(password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          DBRef.child("Government Database").push().set({
                            'employee email': email,
                            'employee phone number': phoneNumber,
                            'employee name': name,
                          }).then((_) {
                            setState(() {
                              showSpinner = false;
                            });

                            Navigator.pushNamed(context, MainCommon.id);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      } catch (err) {
                        print(err);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Center(
                        child: Text(
                      "EXISTING USER?",
                      style: TextStyle(
                        color: kPinkColor,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
//      ),
//    );
  }
}

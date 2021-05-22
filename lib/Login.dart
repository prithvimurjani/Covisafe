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
  bool showSpinner = false;
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
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: SpinKitFadingGrid(
            color: kPinkColor,
            size: 50.0,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              padding: EdgeInsets.only(top: 100, left: 8, right: 8),
              children: <Widget>[
                Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.black, fontSize: 32.0),
                ),
                //Icon(FontAwesome.smile_o,color: Colors.blue,),
                SizedBox(
                  height: 90.0,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: Column(
                    children: <Widget>[
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
                          //textAlign: TextAlign.center,
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
                        padding: const EdgeInsets.only(top: 18.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, ResetPass.id);
                            },
                            child: Center(
                                child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                            ))),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 65.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Login >>>",
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
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, MainCommon.id);
                        }
                        showToast('Welcome back.');
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (err) {
                        print(err);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    child: Center(
                        child: Text(
                      "SIGN UP?",
                      style: TextStyle(
                          color: kPinkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

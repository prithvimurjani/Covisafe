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
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'We\'ve got your back!',
                  style: TextStyle(color: Colors.black, fontSize: 32.0),
                ),
                //Icon(FontAwesome.smile_o,color: Colors.blue,),
                SizedBox(
                  height: 150.0,
                ),
                Card(
                  color: kPinkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          // textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            email = value;
                            print(email);
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MaterialButton(
                    color: Colors.black,
                    child: Text(
                      "Reset",
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

                      try {
                        final resetPass =
                            await _auth.sendPasswordResetEmail(email: email);
                        setState(() {
                          showSpinner = false;
                        });
                        showToast('Reset option has been sent to $email');
                      } catch (err) {
                        print(err);
                      }

                      print('Reset pressed');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

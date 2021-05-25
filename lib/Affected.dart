import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iot_j_comp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Affected extends StatefulWidget {
  static const String id = 'affected_screen';
  @override
  _AffectedState createState() => _AffectedState();
}

class _AffectedState extends State<Affected> {
  DatabaseReference ref =
      FirebaseDatabase.instance.reference().child('Affected Units');
  List lists = [];
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: showSpinner,
                progressIndicator: SpinKitFadingGrid(
                  color: kPinkColor,
                  size: 50.0,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    FutureBuilder(
                        future: ref.once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            //  print(snapshot.data.value);
                            lists.clear();

                            Map<dynamic, dynamic> values = snapshot.data.value;
                            values.forEach((k, v) {
                              lists.add(values[k]);
                              print(k);
                              print(v);
                            });

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: lists.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 340.0,
                                    height: 250.0,
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 0.0),
                                    decoration: BoxDecoration(
                                      //   boxShadow: [BoxShadow(color: Colors.white,spreadRadius: 1.0,)],
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: kPinkColor,
                                          width: 2.0,
                                          style: BorderStyle.solid),
                                    ),
                                    // color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        )),
                                        Text(
                                          'Sub Locality : ' +
                                              lists[index]['Sub Locality'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Admin Area : ' +
                                              lists[index]['Admin Area'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Locality : ' +
                                              lists[index]['Locality'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Postal code : ' +
                                              lists[index]['Postal Code'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Age : ' +
                                              lists[index]['Age'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Gender : ' +
                                              lists[index]['Gender'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 250.0),
                            child: Center(
                              child: SpinKitFadingGrid(
                                color: kPinkColor,
                                size: 50.0,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ))),
    );
  }
}

class FitCardBig extends StatelessWidget {
  FitCardBig({this.parameter, this.concurrentdata, this.iconparam});

  final String parameter;
  final String concurrentdata;
  final Icon iconparam;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              concurrentdata.toString(),
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      width: 340.0,
      height: 355.0,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(color: Colors.white,spreadRadius: 1.0,)],
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
      ),
    );
  }
}

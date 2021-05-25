import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:iot_j_comp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';

class SensorData extends StatefulWidget {
  static const String id = "sensorDataScreen";
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child('/TODAY');
  final DBRef = FirebaseDatabase.instance.reference();
  bool valueMale = false;
  bool valueFemale = false;
  int _valueSlider = 6;
//  DatabaseReference ref = FirebaseDatabase.instance.reference().child('MFxzpxpDiU0VdfkphsS');

  List lists = [];
  double latitude = 85;
  double longitude = 21;
  var distanceData = 20;
  var temperatureData = 20;
  bool showSpinner = false;

  void checker() async {
    temperatureData = await lists[0];
    distanceData = await lists[1];
    if (temperatureData < 50 && distanceData > 100) {
      print('safe');
    }
    if (temperatureData > 50 && distanceData < 100) {
      print('unsafe');
      print('adding data to database.....');
      Vibration.vibrate();

      getLocation();
    }
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    print(longitude);
    print(latitude);
    final coordinates = Coordinates(position.latitude, position.longitude);
    final address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    String addressLine = first.addressLine;
    String locality = first.locality;
    String adminArea = first.adminArea;
    String subLocality = first.subLocality;

    String postalCode = first.postalCode;

    DBRef.child("Affected Units").push().set({
      'Address': addressLine,
      'Sub Locality': subLocality,
      'Locality': locality,
      'Admin Area': adminArea,
      'Postal Code': postalCode,
      'Gender': valueMale ? 'Male' : 'Female',
      'Age': _valueSlider,
    }).then((_) {
      setState(() {
        showSpinner = false;
      });
      showToast('Data successfully added!');
    }).catchError((onError) {
      print(onError);
      showToast('RETRY!');
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: kPinkColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                              'Patient data',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            FitCardBig(
                                              parameter: 'TEMPERATURE',
                                              concurrentdata:
                                                  lists[0].toString(),
                                              iconparam: Icon(Icons.healing),
                                            ),
                                            FitCardBig(
                                              parameter: 'DISTANCE',
                                              concurrentdata:
                                                  lists[1].toString(),
                                              iconparam: Icon(Icons.alarm_on),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Male',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Checkbox(
                                                      checkColor:
                                                          Colors.greenAccent,
                                                      activeColor: Colors.black,
                                                      value: this.valueMale,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          if (valueFemale)
                                                            valueFemale =
                                                                !valueFemale;
                                                          this.valueMale =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Female',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Checkbox(
                                                      checkColor:
                                                          Colors.greenAccent,
                                                      activeColor: Colors.black,
                                                      value: this.valueFemale,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          if (valueMale)
                                                            valueMale =
                                                                !valueMale;
                                                          this.valueFemale =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Age',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Slider(
                                                  value:
                                                      _valueSlider.toDouble(),
                                                  min: 1.0,
                                                  max: 135.0,
                                                  divisions: 135,
                                                  activeColor: Colors.white,
                                                  inactiveColor: Colors.black,
                                                  label: '$_valueSlider',
                                                  onChanged: (double newValue) {
                                                    setState(() {
                                                      _valueSlider =
                                                          newValue.round();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                          ],
                                        ),
                                      ),
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
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: MaterialButton(
                          color: Colors.black,
                          child: Text(
                            "Push data",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          highlightColor: kPinkColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            checker();
                          }),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: MaterialButton(
                        color: Colors.black,
                        child: Text(
                          "Tap to refresh",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        highlightColor: kPinkColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          setState(() {
                            this.widget;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
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
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              parameter.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              concurrentdata.toString(),
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Icon(
              iconparam.icon,
              color: kPinkColor,
              size: 24.0,
            ),
          ),
        ],
      ),
      width: 340.0,
      height: 145.0,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(color: Colors.white,spreadRadius: 1.0,)],
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: Colors.blueAccent, width: 0.0, style: BorderStyle.solid),
      ),
    );
  }
}

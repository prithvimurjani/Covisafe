import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';




class SensorData extends StatefulWidget {
  static const String id = "sensorDataScreen";
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  DatabaseReference ref=FirebaseDatabase.instance.reference().child('/TODAY');
  final DBRef = FirebaseDatabase.instance.reference();
//  DatabaseReference ref = FirebaseDatabase.instance.reference().child('MFxzpxpDiU0VdfkphsS');

  List lists = [];
  double latitude=85;
  double longitude=21;
  var distanceData=20;
  var temperatureData=20.67;
   bool showSpinner = false;

  void checker() async {
    temperatureData=await lists[0];
       distanceData= await lists[1];
    if(temperatureData<50&&distanceData>100){
         print('safe');
       }
    if(temperatureData>50&&distanceData<100){
      print('unsafe');
      print('adding data to database......');
      Vibration.vibrate();

       getLocation();
    }
    
  }
  
  void getLocation() async{
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude=position.latitude;
    longitude=position.longitude;
    print(longitude);
    print(latitude);
    final coordinates =  Coordinates(position.latitude,position.longitude);
    final address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    String addressLine = first.addressLine;
    String locality=first.locality;
    String adminArea=first.adminArea;
    String subLocality=first.subLocality;

    String postalCode=first.postalCode;
    
 
    
     
   
    DBRef.child("Affected Units").push().set({
                          'Address' : addressLine,
                          'Sub Locality' : subLocality,
                          'Locality' : locality,
                          'Admin Area': adminArea,
                          'Postal Code' : postalCode,

                          
                        }).then((_) {
                          setState(() {
                            showSpinner = false;
                          });

                          
                        }).catchError((onError) {
                          print(onError);
                        });
  }

  

  @override
 void initState(){
   super.initState();
  
 }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              body:  ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: SpinKitFadingGrid(
            color: Colors.white,
            size: 50.0,
          ),
                              child: Column(
                  children: <Widget>[
                    
                    FutureBuilder(
                        future: ref.once(),
                        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
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
                                  return Card(
                                    color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                        FitCardBig(parameter: 'TEMPERATURE',concurrentdata: lists[0].toString(),iconparam: Icon(Icons.healing), ),
                                        FitCardBig(parameter: 'DISTANCE',concurrentdata: lists[1].toString(),iconparam: Icon(Icons.alarm_on), ),
                                        
                                        ],
                                      ),

                                  );
                                });
                          }
                          return CircularProgressIndicator();
                        }),
                        SizedBox(height: 50.0,),
                        Container(
                          height: 75.0,
                          width: 200.0,
                          child: RaisedButton(
                            
                            color: Colors.blueAccent,
                            child: Text('PUSH LOCATION',style: TextStyle(color:Colors.black,fontSize: 20),),
                      onPressed: (){
                           checker();
                         
                      },
                    ),
                        ),
                  ],
                ),
              ))),
    );
  }
}

class FitCardBig extends StatelessWidget {
  FitCardBig({this.parameter, this.concurrentdata,this.iconparam});

  final String parameter;
  final String concurrentdata;
  final Icon iconparam;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(parameter.toUpperCase(),style: TextStyle(fontSize: 15,color: Colors.blueAccent, fontWeight: FontWeight.bold,),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(concurrentdata.toString(),style: TextStyle(fontSize :50,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Icon(iconparam.icon,color: Colors.blueAccent,size: 36.0,),
          ),

        ],
      ),
      width: 340.0,
      height: 175.0,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      decoration: BoxDecoration(
     //   boxShadow: [BoxShadow(color: Colors.white,spreadRadius: 1.0,)],
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.blueAccent,width: 2.0,style : BorderStyle.solid),
      ),

    );
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';



class SensorData extends StatefulWidget {
  static const String id = "sensorDataScreen";
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  DatabaseReference ref=FirebaseDatabase.instance.reference().child('/TODAY');
//  DatabaseReference ref = FirebaseDatabase.instance.reference().child('MFxzpxpDiU0VdfkphsS');

  List lists = [];
  double latitude=85;
  double longitude=89;
  void getLocation() async{
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude=position.latitude;
    longitude=position.longitude;
    print(longitude);
    print(latitude);

  }

  @override
//  void initState(){
//    super.initState();
//    getLocation();
//  }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
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
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FitCardBig(parameter: 'TEMPERATURE',concurrentdata: lists[0],iconparam: Icon(Icons.healing), ),
                                      FitCardBig(parameter: 'DISTANCE',concurrentdata: lists[1],iconparam: Icon(Icons.alarm_on), ),
                                      
                                      ],
                                    ),

                                );
                              });
                        }
                        return CircularProgressIndicator();
                      }),
                      SizedBox(height: 100.0,),
                      Container(
                        height: 75.0,
                        width: 200.0,
                        child: RaisedButton(
                          
                          color: Colors.blueAccent,
                          child: Text('Push Location'),
                    onPressed: (){
                        getLocation();
                    },
                  ),
                      ),
                ],
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


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class SensorData extends StatefulWidget {
  static const String id = "sensorDataScreen";
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  DatabaseReference ref=FirebaseDatabase.instance.reference().child('/Users');
//  DatabaseReference ref = FirebaseDatabase.instance.reference().child('MFxzpxpDiU0VdfkphsS');
  List lists = [];

  @override
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
                          lists.clear();
                          Map<dynamic, dynamic> values = snapshot.data.value;
//              var email=jsonDecode(values)['MFyIaXlWI5uWv6garzz']['email'];

//              values.forEach((k, v) => lists.add(Data));
                          values.forEach((k, v) {
                            lists.add(values[k]);
                          });
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: lists.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: Colors.white10,
                                  child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("email : " +
                                            lists[index]['email'].toString(),style: TextStyle(color: Colors.blueAccent),),
                                        Text("temp : " +
                                            lists[index]['temp'].toString(),style: TextStyle(color: Colors.blueAccent)),
                                        Text("distance: " +
                                            lists[index]['distance'].toString(), style: TextStyle(color: Colors.blueAccent)),
                                        Text("area : " +
                                            lists[index]['area'].toString(),style: TextStyle(color: Colors.blueAccent)),
                                        Text("Alert : " +
                                            lists[index]['alertLevel']
                                                .toString(),style: TextStyle(color: Colors.blueAccent)),
                                      ],
                                    ),

                                );
                              });
                        }
                        return CircularProgressIndicator();
                      }),
                ],
              ))),
    );
  }
}

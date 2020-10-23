import 'package:flutter/material.dart';

class SomethingElse extends StatelessWidget {
  static const String id = "somethingElse";
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
//      color: Colors.black54,
      home: SafeArea(child: Scaffold(
        backgroundColor: Colors.black,
//        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: <Widget>[
            SizedBox(height: 20.0,),
            Text("GUIDELINES FOR OFFICIALS",style: TextStyle(color: Colors.blueAccent),textAlign: TextAlign.center,),
            SizedBox(height: 20.0,),
            FitCardBig(parameter:'Always ensure suit is worn.'),
            FitCardBig(parameter:'Ensure patient is 1 meter away.'),
            FitCardBig(parameter:'Ensure patient is wearing mask.'),
            FitCardBig(parameter:'Do not ask patient for personal details.'),
            FitCardBig(parameter:'Advise quarantine, if neccessary.'),
            FitCardBig(parameter:'Alert neighbours.'),
            FitCardBig(parameter:'Report to area office at 2 pm post scan.'),
            FitCardBig(parameter:'Re-check status everyday.'),
            FitCardBig(parameter:'Provide overview report'),
            ],
        ),
      )),
    );
  }
}


class FitCardBig extends StatelessWidget {
  FitCardBig({this.parameter});

  final String parameter;
  


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

        ],
      ),
      width: 340.0,
      height: 45.0,
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

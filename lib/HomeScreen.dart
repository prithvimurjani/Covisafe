import 'package:flutter/material.dart';
import 'package:iot_j_comp/constants.dart';

class SomethingElse extends StatelessWidget {
  static const String id = "somethingElse";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      color: Colors.black54,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
//        backgroundColor: Colors.black,
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              "GUIDELINES FOR OFFICIALS",
              style: TextStyle(
                  color: kPinkColor, fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            FitCardBig(parameter: 'Always ensure suit is worn.'),
            FitCardBig(parameter: 'Ensure patient is 1 meter away.'),
            FitCardBig(parameter: 'Ensure patient is wearing mask.'),
            FitCardBig(parameter: 'Do not ask patient for personal details.'),
            FitCardBig(parameter: 'Advise quarantine, if neccessary.'),
            FitCardBig(parameter: 'Alert neighbours.'),
            FitCardBig(parameter: 'Report to area office at 2 pm post scan.'),
            FitCardBig(parameter: 'Re-check status everyday.'),
            FitCardBig(parameter: 'Provide overview report.'),
            FitCardBig(parameter: 'Make sure to charge device always.'),
            FitCardBig(parameter: 'Do not forget to wear suit.'),
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
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              parameter,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      width: 340.0,
      height: 45.0,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(color: Colors.white,spreadRadius: 1.0,)],
        color: kPinkColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: Colors.black, width: 1.0, style: BorderStyle.solid),
      ),
    );
  }
}

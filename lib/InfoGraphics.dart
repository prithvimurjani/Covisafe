import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:iot_j_comp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_database/firebase_database.dart';

class InfoGraphics extends StatefulWidget {
  static const String id = "infoGraphicsScreen";
  @override
  _InfoGraphicsState createState() => _InfoGraphicsState();
}

class _InfoGraphicsState extends State<InfoGraphics> {
  DatabaseReference ref =
      FirebaseDatabase.instance.reference().child('/Analytics');

  DatabaseReference refNumbers =
      FirebaseDatabase.instance.reference().child('/Analytics');
  //  DatabaseReference ref =
  //     FirebaseDatabase.instance.reference().child('/Analytics').once();
  bool showSpinner = false;
  List lists = [];

  List listGen = [];
  List listNumbers = [];

  //[156, 252, 254, 36, 304, 166, 1, 51, 96];

  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    refNumbers.child("Numbers").once().then((DataSnapshot data) {
      print(data.value);
      print(data.key);
      setState(() {
        listNumbers.add(data.value);
        print(listNumbers);
      });
    });
    //var totalFemaleCount = ref
    // print(totalFemaleCount);
    super.initState();
  }

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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Information Tab',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
                ListView(
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

                              // print(lists);
                              // print(k);
                              // print(v);
                            });

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 340.0,
                                    height: 130.0,
                                    margin: EdgeInsets.fromLTRB(
                                        05.0, 10.0, 05.0, 0.0),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              'State wise distribution',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Karnataka : ' +
                                                lists[7]['Karnataka']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            'Tamil Nadu : ' +
                                                lists[7]['Tamil Nadu']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            'Kerala : ' +
                                                lists[7]['Kerala'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),

                                          // Text(
                                          //   'Gender : ' +
                                          //       lists[index]['Gender'].toString(),
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 20),
                                          // ),
                                        ],
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
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    FutureBuilder(
                        future: ref.once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            //  print(snapshot.data.value);
                            listGen.clear();

                            Map<dynamic, dynamic> values = snapshot.data.value;
                            values.forEach((k, v) {
                              listGen.add(values[k]);

                              // print(listGen);
                              // print(k);
                              // print(v);
                            });

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 340.0,
                                    height: 130.0,
                                    margin: EdgeInsets.fromLTRB(
                                        5.0, 10.0, 5.0, 0.0),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              'General trends since 24 hours',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Male cases : ' +
                                                listGen[6].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            'Female cases : ' +
                                                listGen[4].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            'Max Affected Age : ' +
                                                listGen[1].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ],
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
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: SfCircularChart(
                      // Initialize category axis
                      //primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Gender distribution'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: _tooltipBehavior,
                      series: <PieSeries<GenderData, String>>[
                        PieSeries<GenderData, String>(
                          strokeColor: Colors.black,
                          explode: true,
                          explodeIndex: 0,
                          // Bind data source
                          dataSource: <GenderData>[
                            GenderData('Male', listNumbers[0][2] + .0),
                            GenderData('Female', listNumbers[0][1] + .0),
                          ],
                          xValueMapper: (GenderData genderData, _) =>
                              genderData.gender,
                          yValueMapper: (GenderData genderData, _) =>
                              genderData.count,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'State distribution'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      // borderColor: Colors.green,
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<StateData, String>>[
                        BarSeries<StateData, String>(
                          color: Colors.black,
                          // Bind data source
                          dataSource: <StateData>[
                            StateData('Karnataka', listNumbers[0][5]),
                            StateData(
                              'Tamil Nadu',
                              listNumbers[0][4],
                            ),
                            StateData(
                              'Kerala',
                              listNumbers[0][3],
                            ),
                          ],

                          xValueMapper: (StateData stateData, _) =>
                              stateData.state.toString(),
                          yValueMapper: (StateData stateData, _) =>
                              stateData.caseCount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'City distribution'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<LocalityData, String>>[
                        BarSeries<LocalityData, String>(
                          color: Colors.black,
                          // Bind data source
                          dataSource: <LocalityData>[
                            LocalityData('Bengaluru', listNumbers[0][5]),
                            LocalityData(
                              'Kochi',
                              listNumbers[0][3],
                            ),
                            LocalityData(
                              'Chennai',
                              listNumbers[0][4],
                            ),
                          ],

                          xValueMapper: (LocalityData localityData, _) =>
                              localityData.locality.toString(),
                          yValueMapper: (LocalityData localityData, _) =>
                              localityData.caseCount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPinkColor,
                  child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Chennai city analysis'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      // borderColor: Colors.green,
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<TNData, String>>[
                        BarSeries<TNData, String>(
                          color: Colors.black,
                          // Bind data source
                          dataSource: <TNData>[
                            TNData('Sachinanda puram', listNumbers[0][0]),
                            TNData(
                              'Egmore',
                              listNumbers[0][8],
                            ),
                            TNData(
                              'Perungundi',
                              listNumbers[0][7],
                            ),
                            TNData(
                              'Thiruvanmiyur',
                              listNumbers[0][6],
                            ),
                          ],

                          xValueMapper: (TNData tndata, _) =>
                              tndata.locality.toString(),
                          yValueMapper: (TNData tnData, _) => tnData.caseCount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
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
          ),
        ),
      ),
    );
  }
}

class GenderData {
  GenderData(this.gender, this.count);
  final String gender;
  final double count;
}

class StateData {
  StateData(this.state, this.caseCount);
  final String state;
  final int caseCount;
}

class LocalityData {
  LocalityData(this.locality, this.caseCount);
  final String locality;
  final int caseCount;
}

class TNData {
  TNData(this.locality, this.caseCount);
  final String locality;
  final int caseCount;
}

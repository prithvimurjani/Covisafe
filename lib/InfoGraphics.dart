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

  final DBRef = FirebaseDatabase.instance.reference();
  bool showSpinner = false;

  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    //var totalFemaleCount = ref
    // print(totalFemaleCount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: SpinKitFadingGrid(
              color: kPinkColor,
              size: 50.0,
            ),
            child: ListView(
              children: [
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
                            GenderData('Male', 35),
                            GenderData('Female', 28),
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
                            StateData('Karnataka', 35),
                            StateData(
                              'Kerala',
                              28,
                            ),
                            StateData(
                              'Tamil Nadu',
                              28,
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
                      title: ChartTitle(text: 'Locality distribution'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: _tooltipBehavior,
                      series: <BarSeries<LocalityData, String>>[
                        BarSeries<LocalityData, String>(
                          color: Colors.black,
                          // Bind data source
                          dataSource: <LocalityData>[
                            LocalityData('Bengaluru', 35),
                            LocalityData(
                              'Kochi',
                              28,
                            ),
                            LocalityData(
                              'Chennai',
                              28,
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
                      title: ChartTitle(text: 'State distribution'),
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
                            TNData('Sachinanda puram', 35),
                            TNData(
                              'Egmore',
                              28,
                            ),
                            TNData(
                              'Perungundi',
                              28,
                            ),
                            TNData(
                              'Thiruvanmiyur',
                              28,
                            ),
                          ],

                          xValueMapper: (TNData tndata, _) =>
                              tndata.locality.toString(),
                          yValueMapper: (TNData tnData, _) => tnData.caseCount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ]),
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

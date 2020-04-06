import 'package:flutter/material.dart';
import 'package:pesu_io_project/model/model.dart';
import 'package:pie_chart/pie_chart.dart';

class ParticularState extends StatelessWidget {
  final States stateDetails;

  ParticularState({Key key, this.stateDetails}) : super(key: key);

  final Map<String, double> myDataMap = new Map();

  void initialize() {
    myDataMap.putIfAbsent("Confirmed Cases", () => stateDetails.confirmedCases.toDouble());
    myDataMap.putIfAbsent("Cured", () => stateDetails.cured.toDouble());
    myDataMap.putIfAbsent("Deaths", () => stateDetails.deaths.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text(stateDetails.stateName),
      ),
      body: Column(
        children: <Widget>[
          Material(
            elevation: 3,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Confirmed Cases: ${stateDetails.confirmedCases}"),
                  Text("Cured: ${stateDetails.cured}"),
                  Text("Deaths: ${stateDetails.deaths}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 120),
          Container(
            child: PieChart(
              dataMap: myDataMap,
              animationDuration: Duration(milliseconds: 1500),
              chartType: ChartType.disc,
              chartRadius: 200,
              showLegends: true,
              showChartValues: true,
            ),
          ),
        ],
      ),
    );
  }
}

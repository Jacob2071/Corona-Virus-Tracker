import 'package:flutter/material.dart';
import 'package:pesu_io_project/model/model.dart';
import 'package:pie_chart/pie_chart.dart';

class AllStatesGraph extends StatefulWidget {
  final Model model;

  const AllStatesGraph({Key key, this.model}) : super(key: key);

  @override
  _AllStatesGraphState createState() => _AllStatesGraphState();
}

class _AllStatesGraphState extends State<AllStatesGraph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 14);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: widget.model.getTotalCount(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Material(
                  elevation: 3,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Confirmed Cases: ${snapshot.data["Confirmed Cases"].toInt()}",
                          style: style,
                        ),
                        Text(
                          "Cured: ${snapshot.data["Cured"].toInt()}",
                          style: style,
                        ),
                        Text(
                          "Deaths: ${snapshot.data["Deaths"].toInt()}",
                          style: style,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 120),
                PieChart(
                  dataMap: snapshot.data,
                  animationDuration: Duration(milliseconds: 1500),
                  chartType: ChartType.disc,
                  chartRadius: 200,
                  showLegends: true,
                  showChartValues: true,
                ),
              ],
            );
          } else {
            return Center(
              child: Container(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

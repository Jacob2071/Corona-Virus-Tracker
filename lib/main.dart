import 'package:flutter/material.dart';
import 'package:pesu_io_project/model/model.dart';
import 'package:pesu_io_project/views/all_states_details.dart';
import 'package:pesu_io_project/views/all_states_graph.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Model model = new Model();

  @override
  void initState() {
    super.initState();
    model.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          AllStatesGraph(model: model),
          AllStatesDetails(model: model),
        ],
      ),
    );
  }
}

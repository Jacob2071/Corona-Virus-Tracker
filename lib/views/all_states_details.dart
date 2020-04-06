import 'package:flutter/material.dart';
import 'package:pesu_io_project/model/model.dart';
import 'package:pesu_io_project/views/particular_state.dart';

class AllStatesDetails extends StatefulWidget {
  final Model model;

  AllStatesDetails({this.model, Key key}) : super(key: key);

  @override
  _AllStatesDetailsState createState() => _AllStatesDetailsState();
}

class _AllStatesDetailsState extends State<AllStatesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("States Details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: widget.model.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 3,
                    child: ListTile(
                      title: Text(snapshot.data[index].stateName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "Confirmed Cases: ${snapshot.data[index].confirmedCases}"),
                          Text("Cured: ${snapshot.data[index].cured}"),
                          Text("Deaths: ${snapshot.data[index].deaths}"),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParticularState(
                              stateDetails: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
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

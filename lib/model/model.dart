import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Model {
  List<States> states = [];
  String url = "https://new-io-app.herokuapp.com/api/data";

  Future getData() async {
    if (states.isEmpty) {
      final response = await http.get(url);
      if (states.isEmpty) {
        if (response.statusCode == 200) {
          for (int i = 0; i < json.decode(response.body).length; i++) {
            states.add(States.fromJson(json.decode(response.body)[i]));
          }
          return states;
        } else {
          throw Exception("Failed to load data");
        }
      } else {
        return states;
      }
    } else {
      return states;
    }
  }

  Future getTotalCount() async {
    int totalConfirmedCases = 0;
    int totalCured = 0;
    int totalDeaths = 0;
    List<States> states = await getData() as List<States>;
    for (int i = 0; i < states.length; i++) {
      totalCured += states[i].cured;
      totalDeaths += states[i].deaths;
      totalConfirmedCases += states[i].confirmedCases;
    }
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent(
      "Confirmed Cases",
      () => totalConfirmedCases.toDouble(),
    );
    dataMap.putIfAbsent(
      "Cured",
      () => totalCured.toDouble(),
    );
    dataMap.putIfAbsent(
      "Deaths",
      () => totalDeaths.toDouble(),
    );
    return dataMap;
  }
}

class States {
  final String stateName;
  final int confirmedCases;
  final int cured;
  final int deaths;

  States({
    @required this.stateName,
    @required this.confirmedCases,
    @required this.cured,
    @required this.deaths,
  });

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      stateName: json['State Name'],
      confirmedCases: int.parse(json["Confirmed Cases"]),
      cured: int.parse(json["Cured"]),
      deaths: int.parse(json["Deaths"]),
    );
  }
}

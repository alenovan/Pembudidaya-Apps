// To parse this JSON data, do
//
//     final chartKematianModel = chartKematianModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<ChartKematianModel> chartKematianModelFromJson(String str) =>
    List<ChartKematianModel>.from(json.decode(str).map((x) => ChartKematianModel.fromJson(x)));

String chartKematianModelToJson(List<ChartKematianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartKematianModel {
  ChartKematianModel({
    this.x,
    this.y,
  });

  DateTime x;
  int y;

  factory ChartKematianModel.fromJson(Map<String, dynamic> json) => ChartKematianModel(
    x: DateTime.parse(json["x"].substring(0,10) + ' ' + json["x"].substring(11,19)),
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}

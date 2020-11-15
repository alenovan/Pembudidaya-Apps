// To parse this JSON data, do
//
//     final provinsiModel = provinsiModelFromJson(jsonString);

import 'dart:convert';

List<ProvinsiModel> provinsiModelFromJson(String str) => List<ProvinsiModel>.from(json.decode(str).map((x) => ProvinsiModel.fromJson(x)));

String provinsiModelToJson(List<ProvinsiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinsiModel {
  ProvinsiModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) => ProvinsiModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  String toString() {
    return '${name}'.toUpperCase();
  }
}

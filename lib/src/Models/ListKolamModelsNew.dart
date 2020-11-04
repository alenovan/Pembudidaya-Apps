// To parse this JSON data, do
//
//     final listKolamModelsNew = listKolamModelsNewFromJson(jsonString);

import 'dart:convert';

List<ListKolamModelsNew> listKolamModelsNewFromJson(String str) => List<ListKolamModelsNew>.from(json.decode(str).map((x) => ListKolamModelsNew.fromJson(x)));

String listKolamModelsNewToJson(List<ListKolamModelsNew> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListKolamModelsNew {
  ListKolamModelsNew({
    this.id,
    this.tag,
    this.name,
    this.status,
  });

  int id;
  String tag;
  String name;
  int status;

  factory ListKolamModelsNew.fromJson(Map<String, dynamic> json) => ListKolamModelsNew(
    id: json["id"],
    tag: json["tag"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "name": name,
    "status": status,
  };
}

// To parse this JSON data, do
//
//     final listKolamModels = listKolamModelsFromJson(jsonString);

import 'dart:convert';

List<ListKolamModels> listKolamModelsFromJson(String str) => List<ListKolamModels>.from(json.decode(str).map((x) => ListKolamModels.fromJson(x)));

String listKolamModelsToJson(List<ListKolamModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListKolamModels {
  ListKolamModels({
    this.id,
    this.userId,
    this.tag,
    this.name,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int userId;
  String tag;
  String name;
  dynamic photo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory ListKolamModels.fromJson(Map<String, dynamic> json) => ListKolamModels(
    id: json["id"],
    userId: json["user_id"],
    tag: json["tag"],
    name: json["name"],
    photo: json["photo"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "tag": tag,
    "name": name,
    "photo": photo,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

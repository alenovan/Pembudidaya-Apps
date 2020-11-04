// To parse this JSON data, do
//
//     final listPakanModels = listPakanModelsFromJson(jsonString);

import 'dart:convert';

List<ListPakanModels> listPakanModelsFromJson(String str) => List<ListPakanModels>.from(json.decode(str).map((x) => ListPakanModels.fromJson(x)));

String listPakanModelsToJson(List<ListPakanModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPakanModels {
  ListPakanModels({
    this.id,
    this.name,
    this.price,
    this.description,
    this.photo,
    this.manufacturer,
  });

  int id;
  String name;
  int price;
  String description;
  String photo;
  Manufacturer manufacturer;

  factory ListPakanModels.fromJson(Map<String, dynamic> json) => ListPakanModels(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    photo: json["photo"],
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "photo": photo,
    "manufacturer": manufacturer.toJson(),
  };
}

class Manufacturer {
  Manufacturer({
    this.id,
    this.name,
    this.address,
  });

  int id;
  String name;
  String address;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}

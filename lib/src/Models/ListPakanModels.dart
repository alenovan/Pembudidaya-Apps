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
    this.type,
    this.size,
    this.price,
    this.stock,
    this.description,
    this.photo,
    this.manufacturer,
  });

  int id;
  String name;
  String type;
  String size;
  int price;
  double stock;
  String description;
  String photo;
  Manufacturer manufacturer;

  factory ListPakanModels.fromJson(Map<String, dynamic> json) => ListPakanModels(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    size: json["size"],
    price: json["price"],
    stock: json["stock"] == null ? null : json["stock"].toDouble(),
    description: json["description"],
    photo: json["photo"],
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "size": size,
    "price": price,
    "stock": stock == null ? null : stock,
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

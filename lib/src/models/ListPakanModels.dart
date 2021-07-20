
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
  int stock;
  String description;
  String photo;
  Manufacturer manufacturer;

  factory ListPakanModels.fromJson(Map<String, dynamic> json) => ListPakanModels(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    size: json["size"] == null ? null : json["size"],
    price: json["price"] == null ? null : int.parse(json["price"]),
    stock: json["stock"] == null ? null : int.parse(json["stock"]),
    description: json["description"] == null ? null : json["description"],
    photo: json["photo"] == null ? null : json["photo"],
    manufacturer: json["manufacturer"] == null ? null : Manufacturer.fromJson(json["manufacturer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "size": size == null ? null : size,
    "price": price == null ? null : price,
    "stock": stock == null ? null : stock,
    "description": description == null ? null : description,
    "photo": photo == null ? null : photo,
    "manufacturer": manufacturer == null ? null : manufacturer.toJson(),
  };
}

class Manufacturer {
  Manufacturer({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.address,
    this.coverages,
  });

  int id;
  String name;
  String photo;
  String description;
  String address;
  List<Coverage> coverages;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    description: json["description"] == null ? null : json["description"],
    address: json["address"] == null ? null : json["address"],
    coverages: json["coverages"] == null ? null : List<Coverage>.from(json["coverages"].map((x) => Coverage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "photo": photo == null ? null : photo,
    "description": description == null ? null : description,
    "address": address == null ? null : address,
    "coverages": coverages == null ? null : List<dynamic>.from(coverages.map((x) => x.toJson())),
  };
}

class Coverage {
  Coverage({
    this.cityId,
    this.cityName,
  });

  int cityId;
  String cityName;

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
    cityId: json["city_id"] == null ? null : json["city_id"],
    cityName: json["city_name"] == null ? null : json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId == null ? null : cityId,
    "city_name": cityName == null ? null : cityName,
  };
}

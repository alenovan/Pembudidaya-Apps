// To parse this JSON data, do
//
//     final listSellModels = listSellModelsFromJson(jsonString);

import 'dart:convert';

List<ListSellModels> listSellModelsFromJson(String str) => List<ListSellModels>.from(json.decode(str).map((x) => ListSellModels.fromJson(x)));

String listSellModelsToJson(List<ListSellModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSellModels {
  ListSellModels({
    this.id,
    this.userId,
    this.productPhoto,
    this.name,
    this.description,
    this.price,
    this.sold,
    this.stock,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  int id;
  int userId;
  String productPhoto;
  String name;
  String description;
  int price;
  int sold;
  int stock;
  int weight;
  DateTime createdAt;
  DateTime updatedAt;
  int status;

  factory ListSellModels.fromJson(Map<String, dynamic> json) => ListSellModels(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    productPhoto: json["product_photo"] == null ? null : json["product_photo"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    sold: json["sold"] == null ? null : json["sold"],
    stock: json["stock"] == null ? null : json["stock"],
    weight: json["weight"] == null ? null : json["weight"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "product_photo": productPhoto == null ? null : productPhoto,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "sold": sold == null ? null : sold,
    "stock": stock == null ? null : stock,
    "weight": weight == null ? null : weight,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "status": status == null ? null : status,
  };
}

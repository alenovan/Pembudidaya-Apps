
import 'dart:convert';

List<ListSellModels> listOrdersFeedModelsFromJson(String str) => List<ListSellModels>.from(json.decode(str).map((x) => ListSellModels.fromJson(x)));

String listOrdersFeedModelsToJson(List<ListSellModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSellModels {
  ListSellModels({
    this.id,
    this.categoryId,
    this.productPhoto,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.weight,
    this.sellerId,
    this.nameSeller,
    this.addressSeller,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int categoryId;
  String productPhoto;
  String name;
  String description;
  int price;
  int stock;
  int weight;
  int sellerId;
  String nameSeller;
  String addressSeller;
  DateTime createdAt;
  DateTime updatedAt;

  factory ListSellModels.fromJson(Map<String, dynamic> json) => ListSellModels(
    id: json["id"] == null ? null : json["id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    productPhoto: json["product_photo"] == null ? null : json["product_photo"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    stock: json["stock"] == null ? null : json["stock"],
    weight: json["weight"] == null ? null : json["weight"],
    sellerId: json["seller_id"] == null ? null : json["seller_id"],
    nameSeller: json["name_seller"] == null ? null : json["name_seller"],
    addressSeller: json["address_seller"] == null ? null : json["address_seller"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category_id": categoryId == null ? null : categoryId,
    "product_photo": productPhoto == null ? null : productPhoto,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "stock": stock == null ? null : stock,
    "weight": weight == null ? null : weight,
    "seller_id": sellerId == null ? null : sellerId,
    "name_seller": nameSeller == null ? null : nameSeller,
    "address_seller": addressSeller == null ? null : addressSeller,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
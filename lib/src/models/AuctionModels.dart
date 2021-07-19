// To parse this JSON data, do
//
//     final auctionModels = auctionModelsFromJson(jsonString);

import 'dart:convert';

List<AuctionModels> auctionModelsFromJson(String str) => List<AuctionModels>.from(json.decode(str).map((x) => AuctionModels.fromJson(x)));

String auctionModelsToJson(List<AuctionModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuctionModels {
  AuctionModels({
    this.id,
    this.comodityId,
    this.winnerId,
    this.description,
    this.startBid,
    this.endBid,
    this.bidPhoto,
    this.createdAt,
    this.updatedAt,
    this.weight,
    this.highPrice,
    this.firstPrice,
    this.userId,
    this.idHarvest,
    this.quantity,
    this.bidName,
    this.fishperkg,
  });

  int id;
  dynamic comodityId;
  dynamic winnerId;
  String description;
  DateTime startBid;
  DateTime endBid;
  String bidPhoto;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic weight;
  dynamic highPrice;
  int firstPrice;
  int userId;
  String idHarvest;
  String quantity;
  String bidName;
  String fishperkg;

  factory AuctionModels.fromJson(Map<String, dynamic> json) => AuctionModels(
    id: json["id"] == null ? null : json["id"],
    comodityId: json["comodity_id"],
    winnerId: json["winner_id"],
    description: json["description"] == null ? null : json["description"],
    startBid: json["start_bid"] == null ? null : DateTime.parse(json["start_bid"]),
    endBid: json["end_bid"] == null ? null : DateTime.parse(json["end_bid"]),
    bidPhoto: json["bid_photo"] == null ? null : json["bid_photo"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    weight: json["weight"],
    highPrice: json["high_price"],
    firstPrice: json["first_price"] == null ? null : json["first_price"],
    userId: json["user_id"] == null ? null : json["user_id"],
    idHarvest: json["id_harvest"] == null ? null : json["id_harvest"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    bidName: json["bid_name"] == null ? null : json["bid_name"],
    fishperkg: json["fishperkg"] == null ? null : json["fishperkg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "comodity_id": comodityId,
    "winner_id": winnerId,
    "description": description == null ? null : description,
    "start_bid": startBid == null ? null : startBid.toIso8601String(),
    "end_bid": endBid == null ? null : endBid.toIso8601String(),
    "bid_photo": bidPhoto == null ? null : bidPhoto,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "weight": weight,
    "high_price": highPrice,
    "first_price": firstPrice == null ? null : firstPrice,
    "user_id": userId == null ? null : userId,
    "id_harvest": idHarvest == null ? null : idHarvest,
    "quantity": quantity == null ? null : quantity,
    "bid_name": bidName == null ? null : bidName,
    "fishperkg": fishperkg == null ? null : fishperkg,
  };
}

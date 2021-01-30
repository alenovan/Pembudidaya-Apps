
import 'dart:convert';

List<AuctionModels> auctionModelsFromJson(String str) => List<AuctionModels>.from(json.decode(str).map((x) => AuctionModels.fromJson(x)));

String auctionModelsToJson(List<AuctionModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuctionModels {
  AuctionModels({
    this.id,
    this.firstPrice,
    this.quantity,
    this.fishermanId,
    this.bidName,
    this.sellerId,
    this.fishperkg,
    this.description,
    this.idHarvest,
    this.startBid,
    this.endBid,
    this.bidPhoto,
    this.createdAt,
    this.updatedAt,
    this.winnerId,
  });

  int id;
  int firstPrice;
  int quantity;
  int fishermanId;
  String bidName;
  int sellerId;
  int fishperkg;
  String description;
  int idHarvest;
  DateTime startBid;
  DateTime endBid;
  dynamic bidPhoto;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic winnerId;

  factory AuctionModels.fromJson(Map<String, dynamic> json) => AuctionModels(
    id: json["id"] == null ? null : json["id"],
    firstPrice: json["first_price"] == null ? null : json["first_price"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    fishermanId: json["fisherman_id"] == null ? null : json["fisherman_id"],
    bidName: json["bid_name"] == null ? null : json["bid_name"],
    sellerId: json["seller_id"] == null ? null : json["seller_id"],
    fishperkg: json["fishperkg"] == null ? null : json["fishperkg"],
    description: json["description"] == null ? null : json["description"],
    idHarvest: json["id_harvest"] == null ? null : json["id_harvest"],
    startBid: json["start_bid"] == null ? null : DateTime.parse(json["start_bid"]),
    endBid: json["end_bid"] == null ? null : DateTime.parse(json["end_bid"]),
    bidPhoto: json["bid_photo"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    winnerId: json["winner_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_price": firstPrice == null ? null : firstPrice,
    "quantity": quantity == null ? null : quantity,
    "fisherman_id": fishermanId == null ? null : fishermanId,
    "bid_name": bidName == null ? null : bidName,
    "seller_id": sellerId == null ? null : sellerId,
    "fishperkg": fishperkg == null ? null : fishperkg,
    "description": description == null ? null : description,
    "id_harvest": idHarvest == null ? null : idHarvest,
    "start_bid": startBid == null ? null : startBid.toIso8601String(),
    "end_bid": endBid == null ? null : endBid.toIso8601String(),
    "bid_photo": bidPhoto,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "winner_id": winnerId,
  };
}
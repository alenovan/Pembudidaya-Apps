
import 'dart:convert';

List<BidderModels> BidderModelsFromJson(String str) =>
    List<BidderModels>.from(
        json.decode(str).map((x) => BidderModels.fromJson(x)));

String BidderModelsToJson(List<BidderModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class BidderModels {
  BidderModels({
    this.id,
    this.auctionId,
    this.auctionName,
    this.bid,
    this.bidderName,
    this.bidTime,
  });

  int id;
  int auctionId;
  dynamic auctionName;
  int bid;
  String bidderName;
  String bidTime;

  factory BidderModels.fromJson(Map<String, dynamic> json) => BidderModels(
    id: json["id"] == null ? null : json["id"],
    auctionId: json["auction_id"] == null ? null : json["auction_id"],
    auctionName: json["auction_name"],
    bid: json["bid"] == null ? null : int.parse(json["bid"]),
    bidderName: json["bidder_name"] == null ? null : json["bidder_name"],
    bidTime: json["bid_time"] == null ? null : json["bid_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "auction_id": auctionId == null ? null : auctionId,
    "auction_name": auctionName,
    "bid": bid == null ? null : bid,
    "bidder_name": bidderName == null ? null : bidderName,
    "bid_time": bidTime == null ? null : bidTime,
  };
}

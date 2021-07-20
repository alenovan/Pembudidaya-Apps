
import 'dart:convert';

List<ListOrdersFeedModels> listOrdersFeedModelsFromJson(String str) => List<ListOrdersFeedModels>.from(json.decode(str).map((x) => ListOrdersFeedModels.fromJson(x)));

String listOrdersFeedModelsToJson(List<ListOrdersFeedModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOrdersFeedModels {
  ListOrdersFeedModels({
    this.orderId,
    this.pondName,
    this.orderedAt,
    this.feedName,
    this.feedType,
    this.feedPhoto,
    this.feedPrice,
    this.orderAmount,
    this.totalPayment,
    this.status,
  });

  int orderId;
  String pondName;
  DateTime orderedAt;
  String feedName;
  String feedType;
  String feedPhoto;
  String feedPrice;
  String orderAmount;
  String totalPayment;
  String status;

  factory ListOrdersFeedModels.fromJson(Map<String, dynamic> json) => ListOrdersFeedModels(
    orderId: json["order_id"] == null ? null : json["order_id"],
    pondName: json["pond_name"] == null ? null : json["pond_name"],
    orderedAt: json["ordered_at"] == null ? null : DateTime.parse(json["ordered_at"]),
    feedName: json["feed_name"] == null ? null : json["feed_name"],
    feedType: json["feed_type"] == null ? null : json["feed_type"],
    feedPhoto: json["feed_photo"] == null ? null : json["feed_photo"],
    feedPrice: json["feed_price"] == null ? null : json["feed_price"],
    orderAmount: json["order_amount"] == null ? null : json["order_amount"],
    totalPayment: json["total_payment"] == null ? null : json["total_payment"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId == null ? null : orderId,
    "pond_name": pondName == null ? null : pondName,
    "ordered_at": orderedAt == null ? null : orderedAt.toIso8601String(),
    "feed_name": feedName == null ? null : feedName,
    "feed_type": feedType == null ? null : feedType,
    "feed_photo": feedPhoto == null ? null : feedPhoto,
    "feed_price": feedPrice == null ? null : feedPrice,
    "order_amount": orderAmount == null ? null : orderAmount,
    "total_payment": totalPayment == null ? null : totalPayment,
    "status": status == null ? null : status,
  };
}

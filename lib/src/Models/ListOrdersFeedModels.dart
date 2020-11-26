// To parse this JSON data, do
//
//     final listOrdersFeedModels = listOrdersFeedModelsFromJson(jsonString);

import 'dart:convert';

List<ListOrdersFeedModels> listOrdersFeedModelsFromJson(String str) => List<ListOrdersFeedModels>.from(json.decode(str).map((x) => ListOrdersFeedModels.fromJson(x)));

String listOrdersFeedModelsToJson(List<ListOrdersFeedModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOrdersFeedModels {
  ListOrdersFeedModels({
    this.orderId,
    this.pondName,
    this.feedName,
    this.feedPrice,
    this.orderAmount,
    this.totalPayment,
    this.status,
  });

  int orderId;
  String pondName;
  String feedName;
  String feedPrice;
  String orderAmount;
  String totalPayment;
  int status;

  factory ListOrdersFeedModels.fromJson(Map<String, dynamic> json) => ListOrdersFeedModels(
    orderId: json["order_id"],
    pondName: json["pond_name"],
    feedName: json["feed_name"],
    feedPrice: json["feed_price"],
    orderAmount: json["order_amount"],
    totalPayment: json["total_payment"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "pond_name": pondName,
    "feed_name": feedName,
    "feed_price": feedPrice,
    "order_amount": orderAmount,
    "total_payment": totalPayment,
    "status": status,
  };
}

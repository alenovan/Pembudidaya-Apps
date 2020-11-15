// To parse this JSON data, do
//
//     final kotaModel = kotaModelFromJson(jsonString);

import 'dart:convert';

List<KotaModel> kotaModelFromJson(String str) => List<KotaModel>.from(json.decode(str).map((x) => KotaModel.fromJson(x)));

String kotaModelToJson(List<KotaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KotaModel {
  KotaModel({
    this.cityId,
    this.cityName,
    this.postalCode,
  });

  int cityId;
  String cityName;
  String postalCode;

  factory KotaModel.fromJson(Map<String, dynamic> json) => KotaModel(
    cityId: json["city_id"],
    cityName: json["city_name"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city_name": cityName,
    "postal_code": postalCode,
  };

  @override
  String toString() {
    return '${cityName}'.toUpperCase();
  }
}

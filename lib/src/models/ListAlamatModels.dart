import 'dart:convert';

List<ListAlamatModels> listAlamatModelsFromJson(String str) =>
    List<ListAlamatModels>.from(
        json.decode(str).map((x) => ListAlamatModels.fromJson(x)));

String listAlamatModelsToJson(List<ListAlamatModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListAlamatModels {
  ListAlamatModels({
    this.id,
    this.isMain,
    this.name,
    this.phoneNumber,
    this.address,
    this.province,
    this.city,
    this.district,
    this.postalCode,
  });

  int id;
  int isMain;
  String name;
  String phoneNumber;
  String address;
  City province;
  City city;
  City district;
  String postalCode;

  factory ListAlamatModels.fromJson(Map<String, dynamic> json) => ListAlamatModels(
    id: json["id"] == null ? null : json["id"],
    isMain: json["is_main"] == null ? null : json["is_main"],
    name: json["name"] == null ? null : json["name"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    address: json["address"] == null ? null : json["address"],
    province: json["province"] == null ? null : City.fromJson(json["province"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    district: json["district"] == null ? null : City.fromJson(json["district"]),
    postalCode: json["postal_code"] == null ? null : json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "is_main": isMain == null ? null : isMain,
    "name": name == null ? null : name,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "address": address == null ? null : address,
    "province": province == null ? null : province.toJson(),
    "city": city == null ? null : city.toJson(),
    "district": district == null ? null : district.toJson(),
    "postal_code": postalCode == null ? null : postalCode,
  };
}

class City {
  City({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

// To parse this JSON data, do
//
//     final profileModels = profileModelsFromJson(jsonString);

import 'dart:convert';

ProfileModels profileModelsFromJson(String str) => ProfileModels.fromJson(json.decode(str));

// List<ProfileModels> profileModelsFromJson(String str) {
//   final jsonData = json.decode(str);
//   return new List<ProfileModels>.from(jsonData.map((x) => ProfileModels.fromJson(x)));
// }
String profileModelsToJson(ProfileModels data) => json.encode(data.toJson());

class ProfileModels {
  ProfileModels({
    this.status,
    this.data,
  });

  int status;
  Data data;

  factory ProfileModels.fromJson(Map<String, dynamic> json) => ProfileModels(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.phoneNumber,
    this.ktpNumber,
    this.ktpPhoto,
    this.selfiePhoto,
    this.address,
    this.province,
    this.city,
    this.district,
    this.region,
    this.postalCode,
    this.role,
    this.phoneLastVerified,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String phoneNumber;
  String ktpNumber;
  String ktpPhoto;
  String selfiePhoto;
  String address;
  String province;
  String city;
  String district;
  String region;
  String postalCode;
  String role;
  dynamic phoneLastVerified;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    ktpNumber: json["ktp_number"],
    ktpPhoto: json["ktp_photo"],
    selfiePhoto: json["selfie_photo"],
    address: json["address"],
    province: json["province"],
    city: json["city"],
    district: json["district"],
    region: json["region"],
    postalCode: json["postal_code"],
    role: json["role"],
    phoneLastVerified: json["phone_last_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "ktp_number": ktpNumber,
    "ktp_photo": ktpPhoto,
    "selfie_photo": selfiePhoto,
    "address": address,
    "province": province,
    "city": city,
    "district": district,
    "region": region,
    "postal_code": postalCode,
    "role": role,
    "phone_last_verified": phoneLastVerified,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

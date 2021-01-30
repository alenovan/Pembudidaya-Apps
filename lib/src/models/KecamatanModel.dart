
import 'dart:convert';

List<KecamatanModel> kecamatanModelFromJson(String str) => List<KecamatanModel>.from(json.decode(str).map((x) => KecamatanModel.fromJson(x)));

String kecamatanModelToJson(List<KecamatanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KecamatanModel {
  KecamatanModel({
    this.districtId,
    this.districtName,
  });

  int districtId;
  String districtName;

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
    districtId: json["district_id"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId,
    "district_name": districtName,
  };

  @override
  String toString() {
    return '${districtName}'.toUpperCase();
  }
}

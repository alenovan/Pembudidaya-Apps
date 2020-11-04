import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';

class ApiProvider {
  Client client = Client();
  final String _url = "https://pembudidaya.lelenesia.panen-panen.com/v0";

  Future login(String nohp) async {
    final response =
        await client.post("$_url/login", body: {'phone_number': nohp});
    return response;
  }

  Future register(String nama, String nohp) async {
    var response = await client.post("$_url/user/register",
        body: {'name': nama, 'phone_number': nohp});
      return response;
  }

  Future UpdateBiodataProfile(String address, String province, String city,
      String district, String region, String postal_code) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.put("$_url/user/change/profile", headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'address': address,
      'province': province,
      'city': city,
      'district': district,
      'region': region,
      'postal_code': postal_code
    });
    return response;
  }

  Future UpdateKtpProfile(
      String noKtp, String ktp_photo, String selfie_photo) async {
    dynamic token = await FlutterSession().get("token");
    var response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "_method": "PUT",
      "ktp_number": noKtp,
      "ktp_photo": await MultipartFile.fromFile(ktp_photo, filename: "ktp"),
      "selfie_photo":
          await MultipartFile.fromFile(selfie_photo, filename: "ktp"),
    });
    response = await dio.post(
      "$_url/user/change/ktp",
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    print(response.data);
    return response;
  }

  getProfile() async {
    dynamic token = await FlutterSession().get("token");
    final response = await client
        .get("$_url/user/me", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }

  getDetailKolam(String idKolam) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client
        .get("$_url/ponds/${idKolam}", headers: {'Authorization': 'Bearer $token'});

      return response.body;
  }

  Future insertKolam(String count) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/ponds/bulk",
        headers: {'Authorization': 'Bearer $token'}, body: {'count': count});
    return response;
  }

  Future fetchKolamList() async {
    dynamic token = await FlutterSession().get("token");
    // print('panggil data Kolam');
    final response = await client
        .get("$_url/ponds/", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future insertPententuanPakan(
      String pond_id,
      String sow_date,
      String seed_amount,
      String seed_weight,
      String seed_price,
      String survival_rate,
      String feed_conversion_ratio,
      String feed_price,
      String target_fish_count,
      String target_price) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/harvests/init", headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'pond_id': pond_id.toString(),
      'sow_date': sow_date,
      'seed_amount': seed_amount.toString(),
      'seed_weight': seed_weight.toString(),
      'seed_price': seed_price.toString(),
      'survival_rate': survival_rate.toString(),
      'feed_conversion_ratio': feed_conversion_ratio.toString(),
      'feed_price': feed_price.toString(),
      'target_fish_count': target_fish_count.toString(),
      'target_price': target_price.toString(),
    });

    return response;
  }

  Future activasiKolam(
      String idKolam,String kolamPath) async {
    dynamic token = await FlutterSession().get("token");
    var response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "_method": "PUT",
      "pond_id": idKolam,
      "photo": await MultipartFile.fromFile(kolamPath, filename: "kolam"),
    });
    response = await dio.post(
      "$_url/ponds/activate",
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }

  Future fetchPakanList() async {
    dynamic token = await FlutterSession().get("token");
    // print('panggil data Kolam');
    final response = await client
        .get("$_url/feeds", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }
}

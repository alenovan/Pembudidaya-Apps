import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' show Client;
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';

class ApiProvider {
  Client client = Client();
  final String _url = "https://pembudidaya.lelenesia.panen-panen.com/v0";
  Future login(String nohp) async {
    final response =
        await client.post("$_url/login", body: {'phone_number': nohp});
    return response;
  }

  Future register(String nama, String nohp) async {
    final response = await client.post("$_url/user/register",
        body: {'name': nama, 'phone_number': nohp});
    return response;
  }

  Future UpdateBiodataProfile(String address, String province, String city, String district, String region, String postal_code) async {
    dynamic token =   await FlutterSession().get("token");
    final response = await client.post("$_url/user/change/profile",
        headers: {'Authorization': 'Bearer $token'},
        body: {'_method': "PUT", 'address': address, 'province': province, 'city': city, 'district': district, 'region': region, 'postal_code': postal_code});
    return response;
  }

  getProfile() async {
    dynamic token =   await FlutterSession().get("token");
    final response = await client.get("$_url/user/me",
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }
}

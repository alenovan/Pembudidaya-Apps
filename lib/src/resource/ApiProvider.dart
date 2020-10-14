import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
class ApiProvider {
  Client client = Client();

  Future login(String nohp) async {
    final  _url = "https://pembudidaya.lelenesia.panen-panen.com/v0";
    final response = await client.post("$_url/login", body: {'phone_number': nohp});
    return response;
  }


  Future register(String nama,String nohp) async {
    final  _url = "https://pembudidaya.lelenesia.panen-panen.com/v0";
    final response = await client.post("$_url/user/register", body: {'name': nama,'phone_number':nohp});
    return response;
  }
}

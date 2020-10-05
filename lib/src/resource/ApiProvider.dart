import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class ApiProvider {
  Client client = Client();
  final _url = "";

  bool login(String nohp, String password) {
    if ((nohp == "123456") && (password == "0")) {
      return true;
    } else {
      return false;
    }
  }
}

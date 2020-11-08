import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repository = Repository();

  Future<bool> weightMonitor(_pondid, _weight) async {
    var status;
    print("update weirgh monitor");
    var val = await _repository.monitorWeight(_pondid, _weight);
    print(val.statusCode);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> feedMonitor(_pondid, _feed) async {
    var status;
    print("update feed monitor");
    var val = await _repository.monitorFeed(_pondid, _feed);
    print(val.body);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> feedSR(_pondid, _fishdead) async {
    var status;
    print("update sr monitor");
    var val = await _repository.monitorSr(_pondid, _fishdead);
    print(val.statusCode);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<String> getToken() async {
    dynamic token = await FlutterSession().get("token");
    return token;
  }

  Future<dynamic> analyticsMonitor(
      String pond_id, String month, String year) async {
    var pakan = await _repository.analyticsMonitor(pond_id, month, year);
    var enc = json.decode(pakan.body)['data'];
    return enc;
  }

  Future<List<String>> analyticsCalendar(String pond_id, String from) async {
    List<String> list = new List<String>();
    var pakan = await _repository.analyticsCalendar(pond_id, from);
    var data = json.decode(pakan.body)["data"];
    for (var word in data) {
      // print(word['x'].substring(0,10).toString());
      list.add(word['x'].substring(0,10).toString());
    }
    return list;
    // print(pakan.body.length);
    // var enc = json.encode();
    // for (var i = 0; i < pakan.body.length; i++) {
    //   // var setObject = json.decode(enc[i])["data"];
    //   print(pakan.body.l);
    // }
    // return enc;
  }

  dispose() {}
}

final bloc = LoginBloc();

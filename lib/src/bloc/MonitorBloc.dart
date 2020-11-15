import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repository = Repository();

  Future<bool> weightMonitor(_pondid, _weight,_created_at) async {
    var status;
    print("update weirgh monitor");
    var val = await _repository.monitorWeight(_pondid, _weight,_created_at);
    print(val.statusCode);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> feedMonitor(_pondid, _feed,_created_at) async {
    var status;
    print("update feed monitor");
    var val = await _repository.monitorFeed(_pondid, _feed,_created_at);
    print(val.body);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> feedSR(_pondid, _fishdead,_created_at) async {
    var status;
    print("update sr monitor");
    var val = await _repository.monitorSr(_pondid, _fishdead,_created_at);
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

  Future<List<String>> analyticsCalendar(String pond_id, String from, String to) async {
    List<String> list = new List<String>();
    var pakan = await _repository.analyticsCalendar(pond_id, from,to);
    var data = json.decode(pakan.body)["data"];
    for (var word in data) {;
      list.add(word['x'].substring(0,10).toString());
    }
    return list;
  }

  dispose() {}
}

final bloc = LoginBloc();

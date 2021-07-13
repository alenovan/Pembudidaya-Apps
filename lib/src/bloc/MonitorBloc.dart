import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/resource/ErorManagement.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
class LoginBloc {
  final _repository = Repository();
  final _errManage = ErrorManagement();
  Future weightMonitor(_pondid, _weight,_created_at) async {
    var status;
    var hasil;
    print("update weightMonitor");
    var val = await _repository.monitorWeight(_pondid, _weight,_created_at);
    debugPrint("${val.statusCode}");
    debugPrint("${val.body}");
    if (val.statusCode == 200) {
      String rawJson = '{"message":""}';
      return jsonDecode(rawJson);
    } else {
      return jsonDecode(val.body);
    }

  }

  Future feedMonitor(_pondid, _feed,_created_at) async {
    var status;
    print("update feed monitor");
    var val = await _repository.monitorFeed(_pondid, _feed,_created_at);
    print(val.statusCode);
    if (val.statusCode == 200) {
      String rawJson = '{"message":""}';
      return jsonDecode(rawJson);
    } else {
      return jsonDecode(val.body);
    }
  }

  Future feedSR(_pondid, _fishdead,_created_at) async {
    var status;
    print("update sr monitor");
    var val = await _repository.monitorSr(_pondid, _fishdead,_created_at);
    print(val.statusCode);
    if (val.statusCode == 200) {
      String rawJson = '{"message":""}';
      return jsonDecode(rawJson);
    } else {
      return jsonDecode(val.body);
    }
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

  Future<dynamic> analyticsMonitorByDate(
      String pond_id, String date) async {
    var pakan = await _repository.analyticsMonitorByDate(pond_id, date);
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

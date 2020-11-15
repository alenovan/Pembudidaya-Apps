import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ChartKematianModel.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LaporanBloc {
  final _repository = Repository();

  Future<List<ChartKematianModel>> analyticsKematian(String pond_id, String from, String to) async {
    var pakan = await _repository.analyticsChartKematian(pond_id, from,to);
    var enc = json.encode(json.decode(pakan.body)['data']);
    var data = chartKematianModelFromJson(enc);
    return data;
  }

  Future<List<ChartKematianModel>> analyticsBerat(String pond_id, String from, String to) async {
    var pakan = await _repository.analyticsBeratKematian(pond_id, from,to);
    var enc = json.encode(json.decode(pakan.body)['data']);
    var data = chartKematianModelFromJson(enc);
    return data;
  }

  Future<List<ChartKematianModel>> analyticsPakan(String pond_id, String from, String to) async {
    var pakan = await _repository.analyticsPakanKematian(pond_id, from,to);
    var enc = json.encode(json.decode(pakan.body)['data']);
    var data = chartKematianModelFromJson(enc);
    return data;
  }

  dispose() {}
}

final bloc = LaporanBloc();

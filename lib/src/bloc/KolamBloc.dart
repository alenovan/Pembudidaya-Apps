import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModelsNew.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class KolamBloc {
  final _repository = Repository();
  final _todoFetcher = PublishSubject<List<ListKolamModels>>();
  Stream<List<ListKolamModels>> get allProfile => _todoFetcher.stream;


  Future<bool> funInsertKolam(String count) async {
    var status;
    print("Insert Kolam Profile");
    var val = await _repository.insertKolam(count);
    Map<String, dynamic> responseJson = json.decode(val.body);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  fetchAllKolam() async {
    var kolam = await _repository.fetchAllKolam();
    debugPrint("fetch kolam");
    var enc = json.encode(json.decode(kolam)['data']);
    var data = listKolamModelsNewFromJson(enc);
    return data;
  }

  Future<bool> getCheckKolam() async {
    var status;
    var todo = await _repository.fetchAllKolam();
    final jsondata=json.decode(todo)['data'];
    if(jsonEncode(jsondata).length > 2){
      status = false;
    }else{
      status = true;
    }
    return status;
  }

  getKolamDetail(String idKolam) async {
    var KolamDetal = await _repository.getDetailKolam(idKolam);
    var harvest = json.decode(KolamDetal);
    return harvest;
  }


  Future<bool> funAktivasiKolam(String idkolam,String path) async {
    var status;
    var val = await _repository.activasiKolam(idkolam,path);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  Future<bool> setResetKolam(String pond_id) async {
    var status;
    var val = await _repository.setResetKolam(pond_id);
    print(val.body);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  dispose() {
    _todoFetcher.close();
  }
}

final bloc = KolamBloc();

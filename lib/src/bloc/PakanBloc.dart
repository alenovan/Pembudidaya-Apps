import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListPakanModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/ErorManagement.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class KolamBloc {
  final _repository = Repository();
  final _errManage = ErrorManagement();
  final _todoFetcher = PublishSubject<List<ListKolamModels>>();
  Stream<List<ListKolamModels>> get allProfile => _todoFetcher.stream;


  Future funInsertPenentuanPakan(String pond_id,
      String sow_date,
      String seed_amount,
      String seed_weight,
      String seed_price,
      String survival_rate,
      String feed_conversion_ratio,
      String feed_price,
      String target_fish_count,
      String target_price) async {
    var hasil;
    print("Insert Penentuan Pakan");
    var val = await _repository.insertPenentuanPakan(pond_id,sow_date,seed_amount,seed_weight,seed_price,survival_rate,feed_conversion_ratio,feed_price,target_fish_count,target_price);
    hasil   = await _errManage.penentuanPakanError(val);
    print(hasil);
    return hasil;
  }

  Future<List<ListPakanModels>> fetchAllPakan() async {
    var pakan = await _repository.fetchAllPakan();
    var enc = json.encode(json.decode(pakan)['data']);
    var data = listPakanModelsFromJson(enc);
    return data;
  }


  dispose() {
    _todoFetcher.close();
  }
}

final bloc = KolamBloc();

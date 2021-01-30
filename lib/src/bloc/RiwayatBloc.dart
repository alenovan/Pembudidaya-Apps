import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModelsNew.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListOrdersFeedModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class RiwayatBloc {
  final _repository = Repository();
  final _todoFetcher = PublishSubject<List<ListOrdersFeedModels>>();
  Stream<List<ListOrdersFeedModels>> get allProfile => _todoFetcher.stream;


  fetchRiwayatList() async {
    var kolam = await _repository.fetchRiwayatList();
    var enc = json.encode(json.decode(kolam)['data']);
    var data = listOrdersFeedModelsFromJson(enc);
    return data;
  }


  dispose() {
    _todoFetcher.close();
  }
}

final bloc = RiwayatBloc();

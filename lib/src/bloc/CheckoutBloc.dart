import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/models/ListPakanModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc {
  final _repository = Repository();

  getFeedDetail(String feed_id) async {
    var KolamDetal = await _repository.getFeedDetail(feed_id);
    var harvest = json.decode(KolamDetal);
    return harvest;
  }

  Future<List<ListPakanModels>> fetchPakan(String feed_id) async {
    var pakan = await  _repository.getFeedDetail(feed_id);
    var enc = json.encode(json.decode(pakan)['data']);
    var data = listPakanModelsFromJson(enc);
    return data;
  }

  getOrderId(String id_order) async {
    var todo = await _repository.getOrderId(id_order);
    return jsonDecode(todo.body);
  }

  getCheckOrderId(String id_order) async {
    var status;
    try {
      var todo = await _repository.getOrderId(id_order);
      var statusx = json.decode(todo.body)['data']["status"];
      if (statusx == 0) {
        status = true;
      } else {
        status = false;
      }
    } catch (error) {
      status = false;
    }

    return status;
  }

  Future<bool> checkout(String id_order) async {
    var status;
    debugPrint("checkout"+id_order);
    var val = await _repository.checkout(id_order);
    print(val.body);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}

final bloc = CheckoutBloc();

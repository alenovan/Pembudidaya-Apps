import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class CheckoutBloc {
  final _repository = Repository();
  getFeedDetail(String feed_id) async {
    var KolamDetal = await _repository.getFeedDetail(feed_id);
    var harvest = json.decode(KolamDetal);
    return harvest;
  }

  getOrderId(String id_order) async {
    var todo = await _repository.getOrderId(id_order);
    print(todo.body);
    return jsonDecode(todo.body);
  }

  getCheckOrderId(String id_order) async {
    // var status;
    var todo = await _repository.getOrderId(id_order);

    var status = json.decode(todo.body)['data']["status"];
    if(status == "0"){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  Future<bool> checkout(String id_order) async {
    var status;
    print("checkout");
    var val = await _repository.checkout(id_order);
    print(val.body);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }


}

final bloc = CheckoutBloc();

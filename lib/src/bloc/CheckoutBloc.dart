import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class CheckoutBloc {
  final _repository = Repository();
  getFeedDetail(String feed_id) async {
    var todo = await _repository.getFeedDetail(feed_id);
    return jsonDecode(todo);
  }


}

final bloc = CheckoutBloc();

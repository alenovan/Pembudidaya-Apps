import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class LoginBloc {
  final _repository = Repository();

  Future<bool> feedMonitor(_nohp) async {
    var status;
    print("Login");
    var val = await _repository.login(_nohp);
    Map<String, dynamic> responseJson = json.decode(val.body);
    if(val.statusCode == 200){
      await FlutterSession().set("token", responseJson['token']);
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  Future<String> getToken() async {
    dynamic token =   await FlutterSession().get("token");
    return token;
  }
  dispose() {}
}

final bloc = LoginBloc();

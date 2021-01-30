import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
class LoginBloc {
  final _repository = Repository();
  Future<bool> funLogin(_nohp) async {
    var status;

    var val = await _repository.login(_nohp);
    Map<String, dynamic> responseJson = json.decode(val.body);
    if(val.statusCode == 200){
      await FlutterSession().set("token", responseJson['token']);
      await FlutterSession().set("phoneNumber", _nohp);
        status = true;
    }else {
        status = false;
    }

    return status;
  }

  Future<bool> login_market() async {
    dynamic phoneNumber = await FlutterSession().get("phoneNumber");
    var status;
    var val = await _repository.login_market(phoneNumber.toString());
    Map<String, dynamic> responseJson = json.decode(val.body);

    if(val.statusCode == 200){;
      await FlutterSession().set("token_market", responseJson['token']);

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

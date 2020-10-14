import 'dart:convert';

import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {
  final _repository = Repository();

  Future<int> funRegister(_nama, _nohp) async {
    print("register");
    var status;
    var val = await _repository.register(_nama, _nohp);
    Map<String, dynamic> responseJson = json.decode(val.body);
    print(val.body);
    if (responseJson['status'] == 200) {
      status = 1;
    } else if(responseJson['status'] == 401){
      status = 2;
    }else{
      status = 0;
    }
    return status;
  }

  dispose() {}
}

final bloc = RegisterBloc();

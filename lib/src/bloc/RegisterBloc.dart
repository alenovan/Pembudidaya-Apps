import 'dart:convert';

import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/ErorManagement.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {
  final _repository = Repository();
  final _errManage = ErrorManagement();

  Future funRegister(_nama, _nohp) async {
    var hasil;
    var val = await _repository.register(_nama, _nohp);
    hasil   = await _errManage.registerError(val);
    return hasil;
    }

    dispose() {}
  }

  final bloc = RegisterBloc();

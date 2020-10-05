import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repository = Repository();

  bool funLogin(_nohp, _password) {
    print("Login");
    return _repository.login(_nohp, _password);
  }

  dispose() {}
}

final bloc = LoginBloc();

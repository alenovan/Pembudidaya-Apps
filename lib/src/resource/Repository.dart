import 'dart:async';
import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  bool login(String nohp, String password) =>
      todoApiProvider.login(nohp, password);
}

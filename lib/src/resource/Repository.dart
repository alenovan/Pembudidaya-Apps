import 'dart:async';
import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  Future login(String nohp) =>
      todoApiProvider.login(nohp);

  Future register(String nama,String nohp) =>
      todoApiProvider.register(nama,nohp);
}

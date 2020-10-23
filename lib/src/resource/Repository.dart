import 'dart:async';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';

import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  Future login(String nohp) =>
      todoApiProvider.login(nohp);

  Future register(String nama,String nohp) =>
      todoApiProvider.register(nama,nohp);

  Future updateBiodataProfile(String address, String province, String city, String district, String region, String postal_code) =>
  todoApiProvider.UpdateBiodataProfile(address,province,city,district,region,postal_code);

  getProfile() => todoApiProvider.getProfile();
}

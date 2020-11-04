import 'dart:async';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';

import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  Future login(String nohp) =>
      todoApiProvider.login(nohp);

  Future register(String nama,String nohp) =>
      todoApiProvider.register(nama,nohp);

  Future updateBiodataProfile(String address, String province, String city, String district, String region, String postal_code) =>
  todoApiProvider.UpdateBiodataProfile(address,province,city,district,region,postal_code);


  Future updateKtpProfile(String noKtp, String ktp, String selfie) =>
      todoApiProvider.UpdateKtpProfile(noKtp,ktp,selfie);

  Future insertKolam(String count) =>
      todoApiProvider.insertKolam(count);


  Future fetchAllKolam() => todoApiProvider.fetchKolamList();

  getProfile() => todoApiProvider.getProfile();

  Future insertPenentuanPakan(String pond_id,
      String sow_date,
      String seed_amount,
      String seed_weight,
      String seed_price,
      String survival_rate,
      String feed_conversion_ratio,
      String feed_price,
      String target_fish_count,
      String target_price) =>
      todoApiProvider.insertPententuanPakan(pond_id,sow_date,seed_amount,seed_weight,seed_price,survival_rate,feed_conversion_ratio,feed_price,target_fish_count,target_price);

  getDetailKolam(String idKolam) => todoApiProvider.getDetailKolam(idKolam);

  Future activasiKolam(String idKolam,String kolam) =>
      todoApiProvider.activasiKolam(idKolam,kolam);

  Future fetchAllPakan() => todoApiProvider.fetchPakanList();
}

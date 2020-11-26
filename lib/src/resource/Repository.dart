import 'dart:async';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';

import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  Future login(String nohp) =>
      todoApiProvider.login(nohp);

  Future checkout(String id_order) =>
      todoApiProvider.checkout(id_order);

  Future register(String nama,String nohp) =>
      todoApiProvider.register(nama,nohp);

  Future updateBiodataProfile(String nama,String address, String province, String city, String district) =>
  todoApiProvider.UpdateBiodataProfile(nama,address,province,city,district);


  Future updateKtpProfile(String noKtp, String ktp, String selfie) =>
      todoApiProvider.UpdateKtpProfile(noKtp,ktp,selfie);

  Future insertKolam(String count) =>
      todoApiProvider.insertKolam(count);


  Future fetchAllKolam() => todoApiProvider.fetchKolamList();

  Future fetchRiwayatList() => todoApiProvider.fetchRiwayatList();

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

  getOrderId(String id_order) => todoApiProvider.getOrderId(id_order);

  Future activasiKolam(String idKolam,String kolam) =>
      todoApiProvider.activasiKolam(idKolam,kolam);

  Future fetchAllPakan() => todoApiProvider.fetchPakanList();

//  monitor

  Future monitorWeight(String pond_id,String weight,String created_at) =>
      todoApiProvider.monitorWeight(pond_id,weight,created_at);

  Future monitorFeed(String pond_id,String feed,String created_at) =>
      todoApiProvider.monitorFeed(pond_id,feed,created_at);

  Future monitorSr(String pond_id,String fish_died,String created_at) =>
      todoApiProvider.monitorSR(pond_id,fish_died,created_at);

  getFeedDetail(String feed_id) => todoApiProvider.getFeedDetail(feed_id);

  Future analyticsMonitor(String pond_id,String month,String year) =>
      todoApiProvider.analyticsMonitor(pond_id,month,year);

  Future analyticsMonitorByDate(String pond_id,String date) =>
      todoApiProvider.analyticsMonitorByDate(pond_id,date);

  Future analyticsCalendar(String pond_id,String from,String to) =>
      todoApiProvider.analyticsCalendar(pond_id,from,to);

  Future analyticsChartKematian(String pond_id,String from,String to) =>
      todoApiProvider.analyticsChartKematian(pond_id,from,to);

  Future analyticsBeratKematian(String pond_id,String from,String to) =>
      todoApiProvider.analyticsBeratKematian(pond_id,from,to);

  Future analyticsPakanKematian(String pond_id,String from,String to) =>
      todoApiProvider.analyticsPakanKematian(pond_id,from,to);

  Future getProvinsi() =>
      todoApiProvider.getProvinsi();

  Future getKota(String id_provinsi) =>
      todoApiProvider.getKota(id_provinsi);

  Future getKecamatan(String idKota) =>
      todoApiProvider.getKecamatan(idKota);
}

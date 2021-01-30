import 'dart:async';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';

import 'ApiProvider.dart';

class Repository {
  final todoApiProvider = ApiProvider();
  Future login(String nohp) =>
      todoApiProvider.login(nohp);

  Future login_market(String nohp) =>
      todoApiProvider.login_marketplace(nohp);

  Future checkout(String id_order) =>
      todoApiProvider.checkout(id_order);

  Future addlelang(String harvest_id,String fish_type, String total_amount,
      String amount_per_kilo,String start_date,String end_date,String open_price) =>
      todoApiProvider.addLelang(harvest_id, fish_type, total_amount, amount_per_kilo, start_date, end_date, open_price);

  Future register(String nama,String nohp) =>
      todoApiProvider.register(nama,nohp);

  Future updateBiodataProfile(String nama,String address, String province, String city, String district) =>
  todoApiProvider.UpdateBiodataProfile(nama,address,province,city,district);

  Future funUpdateProfileLocation(String latitude,String longtitude) =>
      todoApiProvider.funUpdateProfileLocation(latitude,longtitude);

   Future addAlamat(String nama,String phone,String address, String province, String city, String district) =>
  todoApiProvider.AddAlamat(nama,phone,address,province,city,district);



  Future updateKtpProfile(String noKtp, String ktp, String selfie) =>
      todoApiProvider.UpdateKtpProfile(noKtp,ktp,selfie);

  Future updateActiveId(String id) =>
      todoApiProvider.updateActiveId(id);

  Future insertKolam(String count) =>
      todoApiProvider.insertKolam(count);


  Future fetchAllKolam() => todoApiProvider.fetchKolamList();
  Future fetchAllAlamat() => todoApiProvider.fetchAllAlamat();

  Future fetchRiwayatList() => todoApiProvider.fetchRiwayatList();

  getProfile() => todoApiProvider.getProfile();

  Future insertPenentuanPakan(String pond_id,
      String sow_date,
      String fish_type_id,
      String seed_amount,
      String seed_weight,
      String seed_price,
      String survival_rate,
      String feed_conversion_ratio,
      String feed_price,
      String target_fish_count,
      String target_price,
      String feed_amount) =>
      todoApiProvider.insertPententuanPakan(pond_id,sow_date,fish_type_id,seed_amount,seed_weight,seed_price,survival_rate,feed_conversion_ratio,feed_price,target_fish_count,target_price,feed_amount);

  getDetailKolam(String idKolam) => todoApiProvider.getDetailKolam(idKolam);

  getOrderId(String id_order) => todoApiProvider.getOrderId(id_order);

  Future activasiKolam(String idKolam,String kolam) =>
      todoApiProvider.activasiKolam(idKolam,kolam);

  Future setResetKolam(String pond_id) =>
      todoApiProvider.setResetKolam(pond_id);

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

//  lealng
  Future fetchAllBid() =>
      todoApiProvider.fetchAllBid();

  Future fetchBidBy(String idBidder) =>
      todoApiProvider.fetchBidBy(idBidder);

  Future fetchBidDetailBy(String idBidder) =>
      todoApiProvider.fetchBidDetailBy(idBidder);

  Future setWinnerlelang(String bidder_id,String auction_id) =>
      todoApiProvider.bidderWinner(bidder_id,auction_id);

  Future setStoplelang(String auction_id) =>
      todoApiProvider.stopLelang(auction_id);

//  market
  Future addJualMarket(String name, String price, String description, String weight, String category_id, String product_photo, String stock) =>
      todoApiProvider.addJualMarket(name,price,description,weight,category_id,product_photo,stock);

  Future addJualMarketAdma( String name, String image, String deskripsi, String harga, String cashback_reseller, String berat) =>
      todoApiProvider.addJualMarketAdma(name,image,deskripsi,harga,cashback_reseller,berat);

}

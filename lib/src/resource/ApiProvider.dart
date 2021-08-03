import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ApiException.dart';

class ApiProvider {
  Client client = Client();
  // final String _url = "http://skripsi.alen.arafah.hk/v0";
  final String _url = "http://192.168.2.13:8000/v0";
  final String  _url_market = "http://marketplace.lelenesia.panen-panen.com/api";

  Future login(String nohp) async {
    var response;
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.post("$_url/login", body: {'phone_number': nohp});
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response;
  }

  Future login_marketplace(String nohp) async {

    var response;
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.post("$_url_market/login", body: {'phonenumber': nohp});
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }

    return response;
  }

  Future register(String nama, String nohp) async {
    var response;
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      debugPrint("$_url/user/change/profile");
      response = await client.post("$_url/user/register",
          body: {'name': nama, 'phone_number': nohp});
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response;
  }

  Future UpdateBiodataProfile(String nama, String address, String province,
      String city, String district) async {
    var response;
    try {
      dynamic token = await FlutterSession().get("token");
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.post("$_url/user/change/profile", headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      }, body: jsonEncode({
        "_method": "PUT",
        'name': nama,
        'address': address,
        'province': province,
        'city': city,
        'district': district,
      }));
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    debugPrint(response.body);
    return response;
  }

  Future funUpdateProfileLocation(String latitude, String longtitude) async {
    var response;
    try {
      dynamic token = await FlutterSession().get("token");
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.post("$_url/user/change/profile", headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      }, body: jsonEncode({
        "_method": "PUT",
        'latitude': latitude,
        'longitude': longtitude,
      }));
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response;
  }

  Future AddAlamat(String nama, String phone,String address, String province,
      String city, String district) async {
    var response;
    try {
      dynamic token = await FlutterSession().get("token");
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.post("$_url/user/address/new", headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      }, body: jsonEncode({
        'name': nama,
        'phone_number': phone,
        'address': address,
        'province_id': province,
        'city_id': city,
        'district_id': district,
        // 'latitude': district,
        // 'longitude': district,
      }));
      print(response.body);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response;
  }

  Future updateActiveId(String id) async {
    var response;
    try {
      dynamic token = await FlutterSession().get("token");
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.put("$_url/user/address/lock/${id}", headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      }, body: jsonEncode({
        'name': "",
      }));
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response;
  }


  Future UpdateKtpProfile(
      String noKtp, String ktp_photo, String selfie_photo) async {
    dynamic token = await FlutterSession().get("token");
    var response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "_method": "PUT",
      "ktp_number": noKtp,
      "ktp_photo": await MultipartFile.fromFile(ktp_photo, filename: "ktp"),
      "selfie_photo":
          await MultipartFile.fromFile(selfie_photo, filename: "ktp"),
    });



    response = await dio.post(
      "$_url/user/change/ktp",
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }

  getProfile() async {
    dynamic token = await FlutterSession().get("token");
    final response = await client
        .get("$_url/user/me", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }

  getFeedDetail(String id) async {
    var response;
    try {
      dynamic token = await FlutterSession().get("token");
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.get("$_url/feeds/${id}",
          headers: {'Authorization': 'Bearer $token'});
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return response.body;
  }

  getDetailKolam(String idKolam) async {
    var response;
    dynamic token = await FlutterSession().get("token");
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      response = await client.get("$_url/ponds/${idKolam}",
          headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }

    return response.body;
  }

  Future insertKolam(String count) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/ponds/bulk",
        headers: {'Authorization': 'Bearer $token'}, body: {'count': count});
    return response;
  }

  Future fetchKolamList() async {
    dynamic token = await FlutterSession().get("token");
    // print('panggil data Kolam');
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/ponds/", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future fetchAllAlamat() async {
    dynamic token = await FlutterSession().get("token");
    // print('panggil data Kolam');
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/user/addresses/", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }


  Future fetchRiwayatList() async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/orders/", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future insertPententuanPakan(
      String pond_id,
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
      String feed_amount) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/harvests/init", headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    }, body: jsonEncode({
      'pond_id': pond_id.toString(),
      'sow_date': sow_date,
      'fish_type_id': fish_type_id,
      'seed_amount': seed_amount.toString(),
      'seed_weight': seed_weight.toString(),
      'seed_price': seed_price.toString(),
      'survival_rate': survival_rate.toString(),
      'feed_conversion_ratio': feed_conversion_ratio.toString(),
      'feed_id': feed_price.toString(),
      'target_fish_count': target_fish_count.toString(),
      'target_price': target_price.toString(),
      'feed_amount': feed_amount.toString(),
    }));

    return response;
  }


  Future insertReOrder(
      String pond_id,
      String feed_id,
      String amount) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/orders/new", headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    }, body: jsonEncode({
      'pond_id': pond_id.toString(),
      'feed_id': feed_id,
      'amount': amount
    }));

    return response;
  }

  Future setResetKolam(
      String pond_id,) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/ponds/reset", headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    }, body: jsonEncode({
      "_method": "PUT",
      "pond_id": pond_id,
    }));

    return response;
  }

  Future activasiKolam(String idKolam, String kolamPath) async {
    dynamic token = await FlutterSession().get("token");
    var response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "_method": "PUT",
      "pond_id": idKolam,
      "photo": await MultipartFile.fromFile(kolamPath, filename: "kolam"),
    });
    response = await dio.post(
      "$_url/ponds/activate",
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }

  Future fetchPakanList() async {
    dynamic token = await FlutterSession().get("token");
    // print('panggil data Kolam');
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/feeds", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }

  }


  //monitor

  Future monitorWeight(String pond_id, String weight, String created_at) async {
    var now = new DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.post("$_url/monit/weight",
        headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'},
        body: jsonEncode({'pond_id': pond_id, "weight": weight, "created_at": created_at}));
    return response;
  }

  Future monitorFeed(String pond_id, String feed, String created_at) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.post("$_url/monit/feed", headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    }, body: jsonEncode({
      'pond_id': pond_id,
      "feed_spent": feed,
      "created_at": created_at
    }));
    debugPrint("test"+response.body);
    return response;
  }

  Future monitorSR(String pond_id, String fish_died, String created_at) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.post("$_url/monit/survival", headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    }, body: jsonEncode({
      'pond_id': pond_id,
      "fish_died": fish_died,
      "created_at": created_at
    }));
    return response;
    print(created_at);
  }
  //end monitor







  Future getOrderId(String id_order) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get("$_url/orders/${id_order}",
        headers: {'Authorization': 'Bearer $token','Content-type': 'application/json'});

    return response;
  }

  Future checkout(String id_order) async {
    // debugPrint(id_order);
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.post("$_url/orders/${id_order}/checkout",
        headers: {'Authorization': 'Bearer $token','Content-type': 'application/json'});
    return response;
  }

  //analytich

  Future analyticsMonitor(String pond_id, String month, String year) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics?pond_id=${pond_id}&month=${month}&year=${year}",
        headers: {'Authorization': 'Bearer $token','Content-type': 'application/json'});
    return response;
  }

  Future analyticsMonitorByDate(String pond_id, String date) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics/daily?pond_id=${pond_id}&date=${date}",
        headers: {'Authorization': 'Bearer $token','Content-type': 'application/json'});
    return response;
  }

  Future analyticsCalendar(String pond_id, String from, String to) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics/survival?pond_id=${pond_id}&from=${from},&to=${to}",
        headers: {'Authorization': 'Bearer $token','Content-type': 'application/json'});
    return response;
  }

  Future analyticsChartKematian(String pond_id, String from, String to) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics/survival?pond_id=${pond_id}&from=${from}&to=${to}",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }

  Future analyticsBeratKematian(String pond_id, String from, String to) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics/growth?pond_id=${pond_id}&from=${from}&to=${to}",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }

  Future analyticsPakanKematian(String pond_id, String from, String to) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get(
        "$_url/analytics/feed?pond_id=${pond_id}&from=${from}&to=${to}",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }
  //end analytich

  //profile
  Future getProvinsi() async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get("$_url/geo/provinces",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }

  Future getKota(id_provinsi) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get("$_url/geo/${id_provinsi}/cities",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }

  Future getKecamatan(id_kota) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client.get("$_url/geo/${id_kota}/districts",
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }

//  end profile


//  lealng bidder

  Future fetchAllBid() async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/bid/", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('');
    }
  }

  Future fetchBidBy(id) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/bid/${id}/bidders/", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('');
    }
  }

  Future fetchByIdJual() async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/seller/sell", headers: {'Authorization': 'Bearer $token', 'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
    //   debugPrint("${response.body}");
      throw Exception('');
    }
  }

  Future bidderWinner(String bidder_id, String auction_id) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/bid/lock", headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'bidder_id': bidder_id.toString(),
      'auction_id': auction_id,
    });

    return response;
  }

  Future stopLelang(String auction_id) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/bid/${auction_id}/end", headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'auction_id': auction_id,
    });

    return response;
  }

  Future fetchBidDetailBy(id) async {
    dynamic token = await FlutterSession().get("token");
    await Future<void>.delayed(Duration(seconds: 1));
    final response = await client
        .get("$_url/bid/bidder-detail?bidder_id=${id}", headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to Load');
    }
  }


  Future addLelang(
      String harvest_id,
      String fish_type,
      String total_amount,
      String amount_per_kilo,
      String start_date,
      String end_date,
      String open_price) async {
    dynamic token = await FlutterSession().get("token");
    final response = await client.post("$_url/bid/new", headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'harvest_id': harvest_id,
      'fish_type': fish_type,
      'total_amount': total_amount,
      'amount_per_kilo': amount_per_kilo,
      'start_date': start_date,
      'end_date': end_date,
      'open_price': open_price,
    });
    return response;
  }





//  end lelang

//jual market
  Future addJualMarket(
      String name, String price, String description, String weight, String category_id, String product_photo, String stock, String harvest_id) async {
    dynamic token = await FlutterSession().get("token");
    var response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "name": name,
      "price": price,
      "description": description,
      "weight": weight,
      "category_id": category_id,
      "subcategory_id": "6",
      "type_id":"18",
      "stock": stock,
      "harvest_id": harvest_id,
      "product_photo": await MultipartFile.fromFile(product_photo, filename: "product_photo"),
    });
    response = await dio.post(
      "$_url/seller/sell",
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }

  Future addJualMarketAdma(
      String name, String image, String deskripsi, String harga, String cashback_reseller, String berat, String stock, String keterangan) async {
    try {
    var response;
      Dio dio = new Dio();
      FormData formData = new FormData.fromMap({
        "nama": name,
        "image": await MultipartFile.fromFile(image, filename: "image"),
        "deskripsi": deskripsi,
        "harga": harga,
        "cashback_reseller": cashback_reseller,
        "berat": berat,
        "keterangan": keterangan,
        "stok":stock

      });
      response = await dio.post(
        "http://pbd.bakti.baktiadma.com/api/product/add",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': 'Bearer 68|vz1hxc6dX9HkQ1ERkJETbwyFft4K5LaZGiIYTPDr'},
        ),
      );
    return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
//end jual market
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lelenesia_pembudidaya/src/models/AuctionModels.dart';
import 'package:lelenesia_pembudidaya/src/models/BidderModels.dart';
import 'package:lelenesia_pembudidaya/src/models/ListSellModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
class LelangBloc {
  final _repository = Repository();
   addlelang(String harvest_id,String fish_type, String total_amount,
      String amount_per_kilo,String start_date,String end_date,String open_price) async {
    var status;
    var val = await _repository.addlelang(harvest_id, fish_type, total_amount, amount_per_kilo, start_date, end_date, open_price);
    // var datz= val;
    if(val.statusCode == 200){
      return [true, "Product Berhasil Di lelang"];
      status = true;
    }else {
      status = false;
      if(val.statusCode == 400){
        return [false, "Stock Ikan Habis"];
      }else{
        return [false, "Pastikan Data Terisi Semua"];
      }

    }

  }

  Future<List<AuctionModels>> getHistoryLelang() async {
    var auction = await _repository.fetchAllBid();
    var enc = json.encode(json.decode(auction));
    var data = auctionModelsFromJson(auction);
    return data;
  }

  Future<List<BidderModels>> getBidderLelang(String bidder) async {
    var auction = await _repository.fetchBidBy(bidder);
    var enc = json.encode(json.decode(auction)["data"]);
    var data = BidderModelsFromJson(enc);
    return data;
  }

  Future<List<ListSellModels>> getJualMarket() async {
    var datax = await _repository.fetchByIdJual();
    var data = listSellModelsFromJson(datax);
    debugPrint("${data}");
    return data;
  }

  Future getBidderDetail(String bidder) async {
    var data = await _repository.fetchBidDetailBy(bidder);
    var enc = json.decode(data)["data"];
    return enc;
  }

  Future<bool> setWinnerlelang(String bidder_id,String auction_id) async {
    var status;
    var val = await _repository.setWinnerlelang(bidder_id,auction_id);
    print(val.body);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  Future<bool> setStoplelang(String auction_id) async {
    var status;
    var val = await _repository.setStoplelang(auction_id);
    print(val.body);
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

//market jual
   addJualMarket(String name, String price, String description, String weight, String category_id, String product_photo, String stock,String harvest_id) async {
    var status;
    var val = await _repository.addJualMarket(name,price,description,weight,category_id,product_photo,stock,harvest_id);
    if (val.statusCode == 201) {
      status = true;
    } else {
      status = false;
    }
    debugPrint("Status ADD JUal = ${val.statusCode}");
    return [status, val.data["message"].toString()];
  }

  Future<bool> addJualMarketAdma(String name, String image, String deskripsi, String harga, String cashback_reseller, String berat, String stock, String keterangan) async {
    var status;
    var val = await _repository.addJualMarketAdma(name,image,deskripsi,harga,cashback_reseller,berat,stock,keterangan);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}

final bloc = LelangBloc();

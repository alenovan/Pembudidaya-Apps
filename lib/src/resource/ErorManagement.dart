import 'dart:convert';

class ErrorManagement {
  Future<dynamic> registerError(dynamic vals) async {
    var hasil;
    var val = jsonDecode(vals.body);
    if (vals.statusCode == 200) {
      var data = {
        'nama': "",
        'phone': "",
      };
      hasil = ({'status': 1, 'data': data});
    } else if (vals.statusCode == 409) {
      var nama = cekColumn(val['message'].toString()) == "null"
          ? "-"
          : replaceJson(val['message'].toString());
      var data = {
        'message': nama,
      };
      hasil = ({'status': 2, 'data': data});
    } else if (vals.statusCode == 400) {
      var nama = cekColumn(val['message']['name'].toString()) == "null"
          ? "-"
          : replaceJson(val['message']['name'].toString());
      var phone = cekColumn(val['message']['phone_number'].toString()) == "null"
          ? "-"
          : replaceJson(val['message']['phone_number'].toString());

      var data = {
        'nama': nama,
        'phone': phone,
      };
      hasil = ({'status': 3, 'data': data});
    }
    return hasil;
  }

  Future<dynamic> penentuanPakanError(dynamic vals) async {
    var hasil;
    var val = jsonDecode(vals.body);
    var array = "message";
    if (vals.statusCode == 200) {
      hasil = ({'status': 1, 'data': "mantap"});
    } else if (vals.statusCode == 409) {
      var error = cekColumn(val[array].toString()) == "null"
          ? ""
          : replaceJson(val[array].toString());
      var data = ({
        'message': error,
      });
      hasil = ({'status': 2, 'data': data});
    } else {
      var sow_date = cekColumn(val[array]['sow_date'].toString()) == "null"
          ? ""
          : replaceJson(val[array]['sow_date'].toString());
      var seed_amount =
          cekColumn(val[array]['seed_amount'].toString()) == "null"
              ? ""
              : replaceJson(val[array]['seed_amount'].toString());
      ;
      var seed_weight =
          cekColumn(val[array]['seed_weight'].toString()) == "null"
              ? ""
              : replaceJson(val[array]['seed_weight'].toString());
      ;
      var seed_price = cekColumn(val[array]['seed_price'].toString()) == "null"
          ? ""
          : replaceJson(val[array]['seed_price'].toString());
      ;
      var feed_price = cekColumn(val[array]['feed_price'].toString()) == "null"
          ? ""
          : replaceJson(val[array]['feed_price'].toString());
      ;
      var target_amount =
          cekColumn(val[array]['target_fish_count'].toString()) == "null"
              ? ""
              : replaceJson(val[array]['target_fish_count'].toString());
      ;
      var target_price =
          cekColumn(val[array]['target_price'].toString()) == "null"
              ? ""
              : replaceJson(val[array]['target_price'].toString());
      ;
      var message = cekColumn(val[array]['message'].toString()) == "null"
          ? ""
          : replaceJson(val[array]['message'].toString());
      ;
      var error = cekColumn(val[array].toString()) == "null"
          ? ""
          : replaceJson(val[array].toString());
      ;

      var data = ({
        'message': message,
        'error': error,
        'sow_date': sow_date,
        'seed_amount': seed_amount,
        'seed_weight': seed_weight,
        'seed_price': seed_price,
        'feed_price': feed_price,
        'target_amount': target_amount,
        'target_price': target_price,
      });
      if (vals.statusCode == 200) {
        hasil = ({'status': 1, 'data': data});
      } else if (vals.statusCode == 400) {
        hasil = ({'status': 3, 'data': data});
      } else {
        hasil = ({'status': 2, 'data': data});
      }
    }
    print(val);
    return hasil;
  }

  String cekColumn(String data) {
    try {
      return data;
    } on Exception catch (_) {
      return "null";
    }
  }

  String replaceJson(String data) {
    try {
      return data.replaceAll("[", "").replaceAll("]", "");
    } on Exception catch (_) {
      return "null";
    }
  }
}

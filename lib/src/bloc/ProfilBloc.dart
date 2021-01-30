import 'dart:convert';
import 'package:lelenesia_pembudidaya/src/Models/KecamatanModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/KotaModel.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProvinsiModel.dart';
import 'package:lelenesia_pembudidaya/src/models/ListAlamatModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfilBloc {
  final _repository = Repository();
  final _todoFetcher = PublishSubject<ProfileModels>();
  Stream<ProfileModels> get allProfile => _todoFetcher.stream;

  Future<bool> funUpdateProfile(nama, address, province, city, district) async {
    var status;
    var val = await _repository.updateBiodataProfile(
        nama, address, province, city, district);
    Map<String, dynamic> responseJson = json.decode(val.body);
    if (responseJson['status'] == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> funUpdateProfileLocation(latitude, longtitude) async {
    var status;
    var val = await _repository.funUpdateProfileLocation(latitude,longtitude);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> funUpdateProfileKtp(noKtp, ktp, selfie) async {
    var status;
    var val = await _repository.updateKtpProfile(noKtp, ktp, selfie);
    Map<String, dynamic> map = val.data;
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> funSetActiveAddress(id) async {
    print(id);
    var status;
    var val = await _repository.updateActiveId(id);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  getProfile() async {
    var todo = await _repository.getProfile();
    return jsonDecode(todo);
  }

  fetchAllAlamat() async {
    var alamat = await _repository.fetchAllAlamat();
    var enc = json.encode(json.decode(alamat)['data']);
    var data = listAlamatModelsFromJson(enc);
    return data;
  }

  Future<List<ProvinsiModel>> getProvinsi() async {
    var pakan = await _repository.getProvinsi();
    var enc = json.encode(json.decode(pakan.body)['data']);
    var data = provinsiModelFromJson(enc);
    return data;
  }

  Future<List<KotaModel>> getKota(_idProvinsi) async {
    var pakan = await _repository.getKota(_idProvinsi);
    var enc = json.encode(json.decode(pakan.body)["data"]["cities"]);
    var data = kotaModelFromJson(enc);
    return data;
  }

  Future<List<KecamatanModel>> getKecamatan(_idKota) async {
    var pakan = await _repository.getKecamatan(_idKota);
    var enc = json.encode(json.decode(pakan.body)["data"]["districts"]);
    var data = kecamatanModelFromJson(enc);
    return data;
  }

  Future<bool> funAddAlamat(
      nama, phone, address, province, city, district) async {
    var status;
    var val = await _repository.addAlamat(
        nama, phone,address, province, city, district);
    if (val.statusCode == 200) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  dispose() {
    _todoFetcher.close();
  }
}

final bloc = ProfilBloc();

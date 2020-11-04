import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:rxdart/rxdart.dart';
class ProfilBloc {
  final _repository = Repository();
  final _todoFetcher = PublishSubject<ProfileModels>();
  Stream<ProfileModels> get allProfile => _todoFetcher.stream;

  Future<bool> funUpdateProfile(nama,address,province,city,district,region,postal_code) async {
    var status;
    print("Update Profile");
    var val = await _repository.updateBiodataProfile(address,province,city,district,region,postal_code);
    Map<String, dynamic> responseJson = json.decode(val.body);
    if(responseJson['status'] == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

  Future<bool> funUpdateProfileKtp(noKtp,ktp,selfie) async {
    var status;
    print("Update Profile Ktp");
    var val = await _repository.updateKtpProfile(noKtp,ktp,selfie);
    Map<String, dynamic> map = val.data;
    if(val.statusCode == 200){
      status = true;
    }else {
      status = false;
    }
    return status;
  }

   getProfile() async {
    var todo = await _repository.getProfile();
    return jsonDecode(todo);
    // _todoFetcher.sink.add(todo);
  }

  dispose() {
    _todoFetcher.close();
  }
}

final bloc = ProfilBloc();

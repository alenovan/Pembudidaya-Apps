
import 'dart:convert';

RegisterModels registerModelsFromJson(String str) => RegisterModels.fromJson(json.decode(str));

String registerModelsToJson(RegisterModels data) => json.encode(data.toJson());

class RegisterModels {
  RegisterModels({
    this.status,
    this.error,
  });

  int status;
  Error error;

  factory RegisterModels.fromJson(Map<String, dynamic> json) => RegisterModels(
    status: json["status"],
    error: Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error.toJson(),
  };
}

class Error {
  Error({
    this.name,
    this.phoneNumber,
  });

  List<String> name;
  List<String> phoneNumber;

  factory Error.fromJson(Map<String, dynamic> json) {
    if(json["name"] == "" || json["name"] =="phone_number"){
    }else{
      Error(
        name: List<String>.from(json["name"].map((x) => x)),
        phoneNumber: List<String>.from(json["phone_number"].map((x) => x)),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "name": List<dynamic>.from(name.map((x) => x)),
    "phone_number": List<dynamic>.from(phoneNumber.map((x) => x)),
  };
}

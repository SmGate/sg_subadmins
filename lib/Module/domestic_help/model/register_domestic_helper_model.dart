// To parse this JSON data, do
//
//     final registerDomesticHelperModel = registerDomesticHelperModelFromJson(jsonString);

import 'dart:convert';

RegisterDomesticHelperModel registerDomesticHelperModelFromJson(String str) =>
    RegisterDomesticHelperModel.fromJson(json.decode(str));

String registerDomesticHelperModelToJson(RegisterDomesticHelperModel data) =>
    json.encode(data.toJson());

class RegisterDomesticHelperModel {
  String? message;
  bool? success;
  Data? data;

  RegisterDomesticHelperModel({
    this.message,
    this.success,
    this.data,
  });

  factory RegisterDomesticHelperModel.fromJson(Map<String, dynamic> json) =>
      RegisterDomesticHelperModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? societyId;
  String? name;
  String? phone;
  String? cnic;
  String? age;
  String? address;
  String? occupation;
  String? visitingFee;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data(
      {this.societyId,
      this.name,
      this.phone,
      this.cnic,
      this.age,
      this.address,
      this.occupation,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.visitingFee});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        societyId: json["society_id"],
        name: json["name"],
        phone: json["phone"],
        cnic: json["cnic"],
        age: json["age"],
        address: json["address"],
        occupation: json["occupation"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        visitingFee: json["visiting_fee"],
      );

  Map<String, dynamic> toJson() => {
        "society_id": societyId,
        "name": name,
        "phone": phone,
        "cnic": cnic,
        "age": age,
        "address": address,
        "occupation": occupation,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

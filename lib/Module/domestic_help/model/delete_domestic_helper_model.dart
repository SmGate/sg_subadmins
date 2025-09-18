// To parse this JSON data, do
//
//     final deleteDomesticHelperModel = deleteDomesticHelperModelFromJson(jsonString);

import 'dart:convert';

DeleteDomesticHelperModel deleteDomesticHelperModelFromJson(String str) =>
    DeleteDomesticHelperModel.fromJson(json.decode(str));

String deleteDomesticHelperModelToJson(DeleteDomesticHelperModel data) =>
    json.encode(data.toJson());

class DeleteDomesticHelperModel {
  String? message;
  bool? success;
  Data? data;

  DeleteDomesticHelperModel({
    this.message,
    this.success,
    this.data,
  });

  factory DeleteDomesticHelperModel.fromJson(Map<String, dynamic> json) =>
      DeleteDomesticHelperModel(
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
  int? id;
  int? societyId;
  String? name;
  String? phone;
  String? cnic;
  int? age;
  String? occupation;
  String? address;
  int? available;
  dynamic visitingFee;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.societyId,
    this.name,
    this.phone,
    this.cnic,
    this.age,
    this.occupation,
    this.address,
    this.available,
    this.visitingFee,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        societyId: json["society_id"],
        name: json["name"],
        phone: json["phone"],
        cnic: json["cnic"],
        age: json["age"],
        occupation: json["occupation"],
        address: json["address"],
        available: json["available"],
        visitingFee: json["visiting_fee"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "society_id": societyId,
        "name": name,
        "phone": phone,
        "cnic": cnic,
        "age": age,
        "occupation": occupation,
        "address": address,
        "available": available,
        "visiting_fee": visitingFee,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

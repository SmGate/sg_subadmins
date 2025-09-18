// To parse this JSON data, do
//
//     final residentEmergencyModel = residentEmergencyModelFromJson(jsonString);

import 'dart:convert';

ResidentEmergencyModel residentEmergencyModelFromJson(String str) =>
    ResidentEmergencyModel.fromJson(json.decode(str));

String residentEmergencyModelToJson(ResidentEmergencyModel data) =>
    json.encode(data.toJson());

class ResidentEmergencyModel {
  String? message;
  bool? success;
  List<Datum>? data;

  ResidentEmergencyModel({
    this.message,
    this.success,
    this.data,
  });

  factory ResidentEmergencyModel.fromJson(Map<String, dynamic> json) =>
      ResidentEmergencyModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? residentid;
  int? societyid;
  int? subadminid;
  String? problem;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.residentid,
    this.societyid,
    this.subadminid,
    this.problem,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        residentid: json["residentid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        problem: json["problem"],
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "societyid": societyid,
        "subadminid": subadminid,
        "problem": problem,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

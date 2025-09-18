// To parse this JSON data, do
//
//     final getAllLuggagePassModel = getAllLuggagePassModelFromJson(jsonString);

import 'dart:convert';

GetAllLuggagePassModel getAllLuggagePassModelFromJson(String str) =>
    GetAllLuggagePassModel.fromJson(json.decode(str));

String getAllLuggagePassModelToJson(GetAllLuggagePassModel data) =>
    json.encode(data.toJson());

class GetAllLuggagePassModel {
  String? message;
  bool? success;
  List<Datum>? data;

  GetAllLuggagePassModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetAllLuggagePassModel.fromJson(Map<String, dynamic> json) =>
      GetAllLuggagePassModel(
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
  int? residentId;
  int? societyId;
  String? description;
  String? status;
  String? type;
  dynamic approvedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum(
      {this.id,
      this.residentId,
      this.societyId,
      this.description,
      this.status,
      this.approvedBy,
      this.createdAt,
      this.updatedAt,
      this.type});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        residentId: json["resident_id"],
        societyId: json["society_id"],
        description: json["description"],
        status: json["status"],
        type: json["type"],
        approvedBy: json["approved_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resident_id": residentId,
        "society_id": societyId,
        "description": description,
        "status": status,
        "approved_by": approvedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type
      };
}

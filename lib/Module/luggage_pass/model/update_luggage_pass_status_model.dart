// To parse this JSON data, do
//
//     final updateLuggagePassStatusModel = updateLuggagePassStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateLuggagePassStatusModel updateLuggagePassStatusModelFromJson(String str) =>
    UpdateLuggagePassStatusModel.fromJson(json.decode(str));

String updateLuggagePassStatusModelToJson(UpdateLuggagePassStatusModel data) =>
    json.encode(data.toJson());

class UpdateLuggagePassStatusModel {
  String? message;
  bool? success;
  Data? data;

  UpdateLuggagePassStatusModel({
    this.message,
    this.success,
    this.data,
  });

  factory UpdateLuggagePassStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateLuggagePassStatusModel(
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
  int? residentId;
  int? societyId;
  String? description;
  String? status;
  dynamic approvedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.residentId,
    this.societyId,
    this.description,
    this.status,
    this.approvedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        residentId: json["resident_id"],
        societyId: json["society_id"],
        description: json["description"],
        status: json["status"],
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
      };
}

// To parse this JSON data, do
//
//     final residentComplaintModel = residentComplaintModelFromJson(jsonString);

import 'dart:convert';

ResidentComplaintModel residentComplaintModelFromJson(String str) =>
    ResidentComplaintModel.fromJson(json.decode(str));

String residentComplaintModelToJson(ResidentComplaintModel data) =>
    json.encode(data.toJson());

class ResidentComplaintModel {
  String? message;
  bool? success;
  List<Datum>? data;

  ResidentComplaintModel({
    this.message,
    this.success,
    this.data,
  });

  factory ResidentComplaintModel.fromJson(Map<String, dynamic> json) =>
      ResidentComplaintModel(
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
  int? userid;
  int? subadminid;
  String? title;
  String? description;
  int? status;
  String? statusdescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userid,
    this.subadminid,
    this.title,
    this.description,
    this.status,
    this.statusdescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userid: json["userid"],
        subadminid: json["subadminid"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "subadminid": subadminid,
        "title": title,
        "description": description,
        "status": status,
        "statusdescription": statusdescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

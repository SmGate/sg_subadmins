// To parse this JSON data, do
//
//     final unBlockResidentsModel = unBlockResidentsModelFromJson(jsonString);

import 'dart:convert';

UnBlockResidentsModel unBlockResidentsModelFromJson(String str) =>
    UnBlockResidentsModel.fromJson(json.decode(str));

String unBlockResidentsModelToJson(UnBlockResidentsModel data) =>
    json.encode(data.toJson());

class UnBlockResidentsModel {
  String? message;
  bool? success;
  Data? data;

  UnBlockResidentsModel({
    this.message,
    this.success,
    this.data,
  });

  factory UnBlockResidentsModel.fromJson(Map<String, dynamic> json) =>
      UnBlockResidentsModel(
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
  int? residentid;
  int? subadminid;
  String? username;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  String? visibility;
  int? committeemember;
  int? status;
  int? isModerator;
  int? isForumBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.residentid,
    this.subadminid,
    this.username,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.visibility,
    this.committeemember,
    this.status,
    this.isModerator,
    this.isForumBlocked,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        residentid: json["residentid"],
        subadminid: json["subadminid"],
        username: json["username"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        houseaddress: json["houseaddress"],
        vechileno: json["vechileno"],
        residenttype: json["residenttype"],
        propertytype: json["propertytype"],
        visibility: json["visibility"],
        committeemember: json["committeemember"],
        status: json["status"],
        isModerator: json["is_moderator"],
        isForumBlocked: json["is_forum_blocked"],
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
        "subadminid": subadminid,
        "username": username,
        "country": country,
        "state": state,
        "city": city,
        "houseaddress": houseaddress,
        "vechileno": vechileno,
        "residenttype": residenttype,
        "propertytype": propertytype,
        "visibility": visibility,
        "committeemember": committeemember,
        "status": status,
        "is_moderator": isModerator,
        "is_forum_blocked": isForumBlocked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

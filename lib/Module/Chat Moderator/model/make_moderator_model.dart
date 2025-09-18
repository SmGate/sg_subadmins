// To parse this JSON data, do
//
//     final makeModeratorModel = makeModeratorModelFromJson(jsonString);

import 'dart:convert';

MakeModeratorModel makeModeratorModelFromJson(String str) =>
    MakeModeratorModel.fromJson(json.decode(str));

String makeModeratorModelToJson(MakeModeratorModel data) =>
    json.encode(data.toJson());

class MakeModeratorModel {
  String? message;
  bool? success;
  List<Datum>? data;

  MakeModeratorModel({
    this.message,
    this.success,
    this.data,
  });

  factory MakeModeratorModel.fromJson(Map<String, dynamic> json) =>
      MakeModeratorModel(
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

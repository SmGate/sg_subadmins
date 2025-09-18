import 'dart:convert';

// Method to parse JSON string to model
GetSocietyBuildingsModel getSocietyBuildingsModelFromJson(String str) =>
    GetSocietyBuildingsModel.fromJson(json.decode(str));

// Method to convert model to JSON string
String getSocietyBuildingsModelToJson(GetSocietyBuildingsModel data) =>
    json.encode(data.toJson());

// Model Class
class GetSocietyBuildingsModel {
  String? message;
  bool? success;
  List<SocietyBuilding>? data;

  GetSocietyBuildingsModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetSocietyBuildingsModel.fromJson(Map<String, dynamic> json) =>
      GetSocietyBuildingsModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SocietyBuilding>.from(
                json["data"].map((x) => SocietyBuilding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SocietyBuilding {
  int? id;
  int? subadminid;
  int? superadminid;
  int? societyid;
  String? societybuildingname;
  int? dynamicid;
  String? type;
  String? createdAt;
  String? updatedAt;

  SocietyBuilding({
    this.id,
    this.subadminid,
    this.superadminid,
    this.societyid,
    this.societybuildingname,
    this.dynamicid,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory SocietyBuilding.fromJson(Map<String, dynamic> json) =>
      SocietyBuilding(
        id: json["id"],
        subadminid: json["subadminid"],
        superadminid: json["superadminid"],
        societyid: json["societyid"],
        societybuildingname: json["societybuildingname"],
        dynamicid: json["dynamicid"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subadminid": subadminid,
        "superadminid": superadminid,
        "societyid": societyid,
        "societybuildingname": societybuildingname,
        "dynamicid": dynamicid,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

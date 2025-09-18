import 'dart:convert';

// Method to parse JSON string to model
GetBuildingFloorsModel getBuildingFloorsModelFromJson(String str) =>
    GetBuildingFloorsModel.fromJson(json.decode(str));

// Method to convert model to JSON string
String getBuildingFloorsModelToJson(GetBuildingFloorsModel data) =>
    json.encode(data.toJson());

// Model Class
class GetBuildingFloorsModel {
  String? message;
  bool? success;
  List<BuildingFloor>? data;

  GetBuildingFloorsModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetBuildingFloorsModel.fromJson(Map<String, dynamic> json) =>
      GetBuildingFloorsModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BuildingFloor>.from(
                json["data"].map((x) => BuildingFloor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BuildingFloor {
  int? id;
  String? name;
  int? buildingid;
  String? createdAt;
  String? updatedAt;

  BuildingFloor({
    this.id,
    this.name,
    this.buildingid,
    this.createdAt,
    this.updatedAt,
  });

  factory BuildingFloor.fromJson(Map<String, dynamic> json) => BuildingFloor(
        id: json["id"],
        name: json["name"],
        buildingid: json["buildingid"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "buildingid": buildingid,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

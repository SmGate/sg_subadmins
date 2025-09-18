import 'dart:convert';

// Method to parse JSON string to model
GetBuildingApartmentsModel getBuildingApartmentsModelFromJson(String str) =>
    GetBuildingApartmentsModel.fromJson(json.decode(str));

// Method to convert model to JSON string
String getBuildingApartmentsModelToJson(GetBuildingApartmentsModel data) =>
    json.encode(data.toJson());

// Model Class
class GetBuildingApartmentsModel {
  String? message;
  bool? success;
  List<BuildingApartment>? data;

  GetBuildingApartmentsModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetBuildingApartmentsModel.fromJson(Map<String, dynamic> json) =>
      GetBuildingApartmentsModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BuildingApartment>.from(
                json["data"].map((x) => BuildingApartment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BuildingApartment {
  int? id;
  int? societybuildingfloorid;
  String? name;
  int? typeid;
  String? type;
  int? occupied;
  String? createdAt;
  String? updatedAt;

  BuildingApartment({
    this.id,
    this.societybuildingfloorid,
    this.name,
    this.typeid,
    this.type,
    this.occupied,
    this.createdAt,
    this.updatedAt,
  });

  factory BuildingApartment.fromJson(Map<String, dynamic> json) =>
      BuildingApartment(
        id: json["id"],
        societybuildingfloorid: json["societybuildingfloorid"],
        name: json["name"],
        typeid: json["typeid"],
        type: json["type"],
        occupied: json["occupied"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "societybuildingfloorid": societybuildingfloorid,
        "name": name,
        "typeid": typeid,
        "type": type,
        "occupied": occupied,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

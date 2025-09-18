import 'dart:convert';

RentSettlementModel rentSettlementModelFromJson(String str) =>
    RentSettlementModel.fromJson(json.decode(str));

String rentSettlementModelToJson(RentSettlementModel data) =>
    json.encode(data.toJson());

class RentSettlementModel {
  String? message;
  bool? success;
  RentData? data;

  RentSettlementModel({
    this.message,
    this.success,
    this.data,
  });

  factory RentSettlementModel.fromJson(Map<String, dynamic> json) =>
      RentSettlementModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] != null ? RentData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class RentData {
  int? id;
  int? societyBuildingFloorId;
  String? name;
  int? typeId;
  String? type;
  int? occupied;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? residentId;
  String? monthlyRent;
  String? annualIncrement;
  String? startDate;

  RentData({
    this.id,
    this.societyBuildingFloorId,
    this.name,
    this.typeId,
    this.type,
    this.occupied,
    this.createdAt,
    this.updatedAt,
    this.residentId,
    this.monthlyRent,
    this.annualIncrement,
    this.startDate,
  });

  factory RentData.fromJson(Map<String, dynamic> json) => RentData(
        id: json["id"],
        societyBuildingFloorId: json["societybuildingfloorid"],
        name: json["name"],
        typeId: json["typeid"],
        type: json["type"],
        occupied: json["occupied"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        residentId: json["resident_id"],
        monthlyRent: json["monthly_rent"],
        annualIncrement: json["annual_increment"],
        startDate: json["start_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "societybuildingfloorid": societyBuildingFloorId,
        "name": name,
        "typeid": typeId,
        "type": type,
        "occupied": occupied,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "resident_id": residentId,
        "monthly_rent": monthlyRent,
        "annual_increment": annualIncrement,
        "start_date": startDate,
      };
}

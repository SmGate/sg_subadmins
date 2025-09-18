// To parse this JSON data, do
//
//     final updateParkingModel = updateParkingModelFromJson(jsonString);

import 'dart:convert';

UpdateParkingModel updateParkingModelFromJson(String str) =>
    UpdateParkingModel.fromJson(json.decode(str));

String updateParkingModelToJson(UpdateParkingModel data) =>
    json.encode(data.toJson());

class UpdateParkingModel {
  String? message;
  bool? success;
  Data? data;

  UpdateParkingModel({
    this.message,
    this.success,
    this.data,
  });

  factory UpdateParkingModel.fromJson(Map<String, dynamic> json) =>
      UpdateParkingModel(
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
  int? parkingLotId;
  String? slotNumber;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  ParkingLot? parkingLot;

  Data({
    this.id,
    this.parkingLotId,
    this.slotNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.parkingLot,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        parkingLotId: json["parking_lot_id"],
        slotNumber: json["slot_number"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        parkingLot: json["parking_lot"] == null
            ? null
            : ParkingLot.fromJson(json["parking_lot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parking_lot_id": parkingLotId,
        "slot_number": slotNumber,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "parking_lot": parkingLot?.toJson(),
      };
}

class ParkingLot {
  int? id;
  int? societyId;
  String? name;
  int? totalSlots;
  DateTime? createdAt;
  DateTime? updatedAt;

  ParkingLot({
    this.id,
    this.societyId,
    this.name,
    this.totalSlots,
    this.createdAt,
    this.updatedAt,
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) => ParkingLot(
        id: json["id"],
        societyId: json["society_id"],
        name: json["name"],
        totalSlots: json["total_slots"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "society_id": societyId,
        "name": name,
        "total_slots": totalSlots,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

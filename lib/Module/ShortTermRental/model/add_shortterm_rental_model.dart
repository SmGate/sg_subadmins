import 'dart:convert';

AddShortTermRentalModel addShortTermRentalModelFromJson(String str) =>
    AddShortTermRentalModel.fromJson(json.decode(str));

String addShortTermRentalModelToJson(AddShortTermRentalModel data) =>
    json.encode(data.toJson());

class AddShortTermRentalModel {
  AddShortTermRentalModel({
    this.message,
    this.success,
    this.data,
  });

  String? message;
  bool? success;
  BookingData? data;

  factory AddShortTermRentalModel.fromJson(Map<String, dynamic> json) =>
      AddShortTermRentalModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] != null ? BookingData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class BookingData {
  BookingData({
    this.appartmentId,
    this.guestName,
    this.guestPhone,
    this.guestCnic,
    this.cnicPhoto,
    this.checkInDate,
    this.checkOutDate,
    this.totalPrice,
    this.status,
    this.description,
    this.vehicleNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? appartmentId;
  String? guestName;
  String? guestPhone;
  String? guestCnic;
  String? cnicPhoto;
  String? checkInDate;
  String? checkOutDate;
  String? totalPrice;
  String? status;
  String? description;
  String? vehicleNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        appartmentId: json["appartment_id"],
        guestName: json["guest_name"],
        guestPhone: json["guest_phone"],
        guestCnic: json["guest_cnic"],
        cnicPhoto: json["cnic_photo"],
        checkInDate: json["check_in_date"],
        checkOutDate: json["check_out_date"],
        totalPrice: json["total_price"],
        status: json["status"],
        description: json["description"],
        vehicleNumber: json["vehicle_number"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "appartment_id": appartmentId,
        "guest_name": guestName,
        "guest_phone": guestPhone,
        "guest_cnic": guestCnic,
        "cnic_photo": cnicPhoto,
        "check_in_date": checkInDate,
        "check_out_date": checkOutDate,
        "total_price": totalPrice,
        "status": status,
        "description": description,
        "vehicle_number": vehicleNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

import 'dart:convert';

AllShortTermRentalModel allShortTermRentalModelFromJson(String str) =>
    AllShortTermRentalModel.fromJson(json.decode(str));

String allShortTermRentalModelToJson(AllShortTermRentalModel data) =>
    json.encode(data.toJson());

class AllShortTermRentalModel {
  String message;
  bool success;
  List<ShortTermRentalData> data;

  AllShortTermRentalModel({
    required this.message,
    required this.success,
    required this.data,
  });

  factory AllShortTermRentalModel.fromJson(Map<String, dynamic> json) {
    return AllShortTermRentalModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: List<ShortTermRentalData>.from(
        json['data'].map((x) => ShortTermRentalData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShortTermRentalData {
  int id;
  int appartmentId;
  String guestName;
  String guestPhone;
  String guestCnic;
  String checkInDate;
  String checkOutDate;
  String cnicPhoto;
  String totalPrice;
  String status;
  String description;
  String vehicleNumber;
  String createdAt;
  String updatedAt;

  Apartment? appartment;

  ShortTermRentalData({
    required this.id,
    required this.appartmentId,
    required this.guestName,
    required this.guestPhone,
    required this.guestCnic,
    required this.checkInDate,
    required this.checkOutDate,
    required this.cnicPhoto,
    required this.totalPrice,
    required this.status,
    required this.description,
    required this.vehicleNumber,
    required this.createdAt,
    required this.updatedAt,
    this.appartment,
  });

  factory ShortTermRentalData.fromJson(Map<String, dynamic> json) {
    return ShortTermRentalData(
      id: json['id'],
      appartmentId: json['appartment_id'],
      guestName: json['guest_name'] ?? '',
      guestPhone: json['guest_phone'] ?? '',
      guestCnic: json['guest_cnic'] ?? '',
      checkInDate: json['check_in_date'] ?? '',
      checkOutDate: json['check_out_date'] ?? '',
      cnicPhoto: json['cnic_photo'] ?? '',
      totalPrice: json['total_price'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      appartment: json['appartment'] != null
          ? Apartment.fromJson(json['appartment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "appartment_id": appartmentId,
        "guest_name": guestName,
        "guest_phone": guestPhone,
        "guest_cnic": guestCnic,
        "check_in_date": checkInDate,
        "check_out_date": checkOutDate,
        "cnic_photo": cnicPhoto,
        "total_price": totalPrice,
        "status": status,
        "description": description,
        "vehicle_number": vehicleNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "appartment": appartment?.toJson(),
      };
}

class Apartment {
  int id;
  int societyBuildingFloorId;
  String name;
  int typeId;
  String type;
  int occupied;
  String createdAt;
  String updatedAt;

  Floor? floor;

  Apartment({
    required this.id,
    required this.societyBuildingFloorId,
    required this.name,
    required this.typeId,
    required this.type,
    required this.occupied,
    required this.createdAt,
    required this.updatedAt,
    this.floor,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'],
      societyBuildingFloorId: json['societybuildingfloorid'],
      name: json['name'] ?? '',
      typeId: json['typeid'] ?? 0,
      type: json['type'] ?? '',
      occupied: json['occupied'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      floor: json['floor'] != null ? Floor.fromJson(json['floor']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "societybuildingfloorid": societyBuildingFloorId,
        "name": name,
        "typeid": typeId,
        "type": type,
        "occupied": occupied,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "floor": floor?.toJson(),
      };
}

class Floor {
  int id;
  String name;
  int buildingId;
  String createdAt;
  String updatedAt;

  Building? building;

  Floor({
    required this.id,
    required this.name,
    required this.buildingId,
    required this.createdAt,
    required this.updatedAt,
    this.building,
  });

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      id: json['id'],
      name: json['name'] ?? '',
      buildingId: json['buildingid'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      building:
          json['building'] != null ? Building.fromJson(json['building']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "buildingid": buildingId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "building": building?.toJson(),
      };
}

class Building {
  int id;
  int subAdminId;
  int superAdminId;
  int societyId;
  String societyBuildingName;
  int dynamicId;
  String type;
  String createdAt;
  String updatedAt;

  Building({
    required this.id,
    required this.subAdminId,
    required this.superAdminId,
    required this.societyId,
    required this.societyBuildingName,
    required this.dynamicId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'],
      subAdminId: json['subadminid'],
      superAdminId: json['superadminid'],
      societyId: json['societyid'],
      societyBuildingName: json['societybuildingname'] ?? '',
      dynamicId: json['dynamicid'],
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "subadminid": subAdminId,
        "superadminid": superAdminId,
        "societyid": societyId,
        "societybuildingname": societyBuildingName,
        "dynamicid": dynamicId,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

import 'dart:convert';

// Parsing Functions
AddMeasurement addMeasurementFromJson(String str) =>
    AddMeasurement.fromJson(json.decode(str));

String addMeasurementToJson(AddMeasurement data) => json.encode(data.toJson());

// Model Classes
class AddMeasurement {
  String? message;
  MeasurementData? data;

  AddMeasurement({
    this.message,
    this.data,
  });

  factory AddMeasurement.fromJson(Map<String, dynamic> json) => AddMeasurement(
        message: json['message'] as String?,
        data: json['data'] != null
            ? MeasurementData.fromJson(json['data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
      };
}

class MeasurementData {
  String? societyId;
  String? societyBuildingId;
  String? societyBuildingFloorId;
  String? societyBuildingApartmentId;
  String? appartmentType;
  String? type;
  String? unit;
  String? charges;
  String? area;
  int? status;
  String? subadminid;
  String? appcharges;
  String? latecharges;
  String? category;
  String? monthlyRent;
  String? annualIncrement;
  String? tax;
  String? updatedAt;
  String? createdAt;
  int? id;

  MeasurementData({
    this.societyId,
    this.societyBuildingId,
    this.societyBuildingFloorId,
    this.societyBuildingApartmentId,
    this.appartmentType,
    this.type,
    this.unit,
    this.charges,
    this.area,
    this.status,
    this.subadminid,
    this.appcharges,
    this.latecharges,
    this.category,
    this.monthlyRent,
    this.annualIncrement,
    this.tax,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory MeasurementData.fromJson(Map<String, dynamic> json) =>
      MeasurementData(
        societyId: json['society_id'] as String?,
        societyBuildingId: json['societybuilding_id'] as String?,
        societyBuildingFloorId: json['societybuildingfloor_id'] as String?,
        societyBuildingApartmentId:
            json['societybuildingapartment_id'] as String?,
        appartmentType: json['appartment_type'] as String?,
        type: json['type'] as String?,
        unit: json['unit'] as String?,
        charges: json['charges'] as String?,
        area: json['area'] as String?,
        status: json['status'] as int?,
        subadminid: json['subadminid'] as String?,
        appcharges: json['appcharges'] as String?,
        latecharges: json['latecharges'] as String?,
        category: json['category'] as String?,
        monthlyRent: json['monthly_rent'] as String?,
        annualIncrement: json['annual_increment'] as String?,
        tax: json['tax'] as String?,
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'society_id': societyId,
        'societybuilding_id': societyBuildingId,
        'societybuildingfloor_id': societyBuildingFloorId,
        'societybuildingapartment_id': societyBuildingApartmentId,
        'appartment_type': appartmentType,
        'type': type,
        'unit': unit,
        'charges': charges,
        'area': area,
        'status': status,
        'subadminid': subadminid,
        'appcharges': appcharges,
        'latecharges': latecharges,
        'category': category,
        'monthly_rent': monthlyRent,
        'annual_increment': annualIncrement,
        'tax': tax,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
      };
}

import 'dart:convert';

GetAllFloorsModel getAllFloorsModelFromJson(String str) =>
    GetAllFloorsModel.fromJson(json.decode(str));

class GetAllFloorsModel {
  final String? message;
  final bool? success;
  final List<FloorData>? data;

  GetAllFloorsModel({this.message, this.success, this.data});

  factory GetAllFloorsModel.fromJson(Map<String, dynamic> json) {
    return GetAllFloorsModel(
      message: json['message'],
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FloorData.fromJson(e))
          .toList(),
    );
  }
}

class FloorData {
  final int? id;
  final String? name;
  final String? category;
  final int? buildingId;
  final String? createdAt;
  final String? updatedAt;
  final Building? building;

  FloorData({
    this.id,
    this.name,
    this.category,
    this.buildingId,
    this.createdAt,
    this.updatedAt,
    this.building,
  });

  factory FloorData.fromJson(Map<String, dynamic> json) {
    return FloorData(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      buildingId: json['buildingid'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      building:
          json['building'] != null ? Building.fromJson(json['building']) : null,
    );
  }
}

class Building {
  final int? id;
  final int? subadminid;
  final int? superadminid;
  final int? societyid;
  final String? societybuildingname;
  final int? dynamicid;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  Building({
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

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'],
      subadminid: json['subadminid'],
      superadminid: json['superadminid'],
      societyid: json['societyid'],
      societybuildingname: json['societybuildingname'],
      dynamicid: json['dynamicid'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

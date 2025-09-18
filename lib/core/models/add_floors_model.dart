import 'dart:convert';

FloorResponse floorResponseFromJson(String str) =>
    FloorResponse.fromJson(json.decode(str));

String floorResponseToJson(FloorResponse data) => json.encode(data.toJson());

class FloorResponse {
  String? message;
  bool? success;
  List<FloorData>? data;

  FloorResponse({
    this.message,
    this.success,
    this.data,
  });

  factory FloorResponse.fromJson(Map<String, dynamic> json) {
    return FloorResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => FloorData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class FloorData {
  String? name;
  String? buildingid;
  String? category;
  String? createdAt;
  String? updatedAt;

  FloorData({
    this.name,
    this.buildingid,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory FloorData.fromJson(Map<String, dynamic> json) {
    return FloorData(
      name: json['name'] as String?,
      buildingid: json['buildingid'] as String?,
      category: json['category'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'buildingid': buildingid,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class UpdateMeasurementModel {
  final String message;
  final UpdateMeasurementData data;

  UpdateMeasurementModel({
    required this.message,
    required this.data,
  });

  factory UpdateMeasurementModel.fromJson(Map<String, dynamic> json) {
    return UpdateMeasurementModel(
      message: json['message'],
      data: UpdateMeasurementData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UpdateMeasurementData {
  final int id;
  final String subadminid;
  final String type;
  final String? unit;
  final String? category;
  final String monthlyRent;
  final String annualIncrement;
  final String charges;
  final String latecharges;
  final String? appcharges;
  final String tax;
  final String? area;
  final int status;
  final String createdAt;
  final String updatedAt;

  UpdateMeasurementData({
    required this.id,
    required this.subadminid,
    required this.type,
    this.unit,
    this.category,
    required this.monthlyRent,
    required this.annualIncrement,
    required this.charges,
    required this.latecharges,
    this.appcharges,
    required this.tax,
    this.area,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdateMeasurementData.fromJson(Map<String, dynamic> json) {
    return UpdateMeasurementData(
      id: json['id'],
      subadminid: json['subadminid'],
      type: json['type'],
      unit: json['unit'],
      category: json['category'],
      monthlyRent: json['monthly_rent'],
      annualIncrement: json['annual_increment'],
      charges: json['charges'],
      latecharges: json['latecharges'],
      appcharges: json['appcharges'],
      tax: json['tax'],
      area: json['area'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subadminid': subadminid,
      'type': type,
      'unit': unit,
      'category': category,
      'monthly_rent': monthlyRent,
      'annual_increment': annualIncrement,
      'charges': charges,
      'latecharges': latecharges,
      'appcharges': appcharges,
      'tax': tax,
      'area': area,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

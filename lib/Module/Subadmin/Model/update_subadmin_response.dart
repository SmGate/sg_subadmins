class UpdateSubadminResponse {
  final bool success;
  final String? message;
  final UpdateSubadminData? data;

  UpdateSubadminResponse({required this.success, this.message, this.data});

  factory UpdateSubadminResponse.fromJson(Map<String, dynamic> json) {
    return UpdateSubadminResponse(
      success: json['success'] == true,
      message: json['message']?.toString(),
      data: json['data'] != null
          ? UpdateSubadminData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateSubadminData {
  final String? firstname;
  final String? lastname;
  final String? cnic;
  final String? email;
  final String? address;
  final String? mobileno;
  final int? roleid;
  final String? rolename;
  final String? image;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  UpdateSubadminData({
    this.firstname,
    this.lastname,
    this.cnic,
    this.email,
    this.address,
    this.mobileno,
    this.roleid,
    this.rolename,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UpdateSubadminData.fromJson(Map<String, dynamic> json) {
    return UpdateSubadminData(
      firstname: json['firstname']?.toString(),
      lastname: json['lastname']?.toString(),
      cnic: json['cnic']?.toString(),
      email: json['email']?.toString(),
      address: json['address']?.toString(),
      mobileno: json['mobileno']?.toString(),
      roleid: (json['roleid'] as num?)?.toInt(),
      rolename: json['rolename']?.toString(),
      image: json['image']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      id: (json['id'] as num?)?.toInt(),
    );
  }
}




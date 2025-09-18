// get_all_sub_admin_model.dart

class GetAllSubAdminModel {
  final bool? success;
  final List<SubAdminData>? data;

  GetAllSubAdminModel({
    this.success,
    this.data,
  });

  factory GetAllSubAdminModel.fromJson(Map<String, dynamic> json) {
    return GetAllSubAdminModel(
      success: json['success'] as bool?,
      data: (json['data'] as List?)
          ?.map((e) => SubAdminData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubAdminData {
  final int? id;
  final int? superadminid;
  final int? societyid;
  final int? subadminid;
  final String? createdAt; // keep as String? to avoid timezone issues in UI
  final String? updatedAt; // keep as String?
  final String? firstname;
  final String? lastname;
  final String? name;
  final String? email;
  final String? cnic;
  final String? address;
  final String? mobileno;
  final String? password;
  final int? roleid;
  final String? rolename;
  final String? image;
  final String? fcmtoken;
  final String? code;
  final int? isVerified; // backend returns 0/1
  final String? deletedAt; // null or timestamp string

  SubAdminData({
    this.id,
    this.superadminid,
    this.societyid,
    this.subadminid,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.name,
    this.email,
    this.cnic,
    this.address,
    this.mobileno,
    this.password,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.code,
    this.isVerified,
    this.deletedAt,
  });

  factory SubAdminData.fromJson(Map<String, dynamic> json) {
    int? _asInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      return int.tryParse(v.toString());
    }

    String? _asString(dynamic v) => v?.toString();

    return SubAdminData(
      id: _asInt(json['id']),
      superadminid: _asInt(json['superadminid']),
      societyid: _asInt(json['societyid']),
      subadminid: _asInt(json['subadminid']),
      createdAt: _asString(json['created_at']),
      updatedAt: _asString(json['updated_at']),
      firstname: _asString(json['firstname']),
      lastname: _asString(json['lastname']),
      name: _asString(json['name']),
      email: _asString(json['email']),
      cnic: _asString(json['cnic']),
      address: _asString(json['address']),
      mobileno: _asString(json['mobileno']),
      password: _asString(json['password']),
      roleid: _asInt(json['roleid']),
      rolename: _asString(json['rolename']),
      image: _asString(json['image']),
      fcmtoken: _asString(json['fcmtoken']),
      code: _asString(json['code']),
      isVerified: _asInt(json['is_verified']),
      deletedAt: _asString(json['deleted_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'superadminid': superadminid,
      'societyid': societyid,
      'subadminid': subadminid,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'firstname': firstname,
      'lastname': lastname,
      'name': name,
      'email': email,
      'cnic': cnic,
      'address': address,
      'mobileno': mobileno,
      'password': password,
      'roleid': roleid,
      'rolename': rolename,
      'image': image,
      'fcmtoken': fcmtoken,
      'code': code,
      'is_verified': isVerified,
      'deleted_at': deletedAt,
    };
  }

  SubAdminData copyWith({
    int? id,
    int? superadminid,
    int? societyid,
    int? subadminid,
    String? createdAt,
    String? updatedAt,
    String? firstname,
    String? lastname,
    String? name,
    String? email,
    String? cnic,
    String? address,
    String? mobileno,
    String? password,
    int? roleid,
    String? rolename,
    String? image,
    String? fcmtoken,
    String? code,
    int? isVerified,
    String? deletedAt,
  }) {
    return SubAdminData(
      id: id ?? this.id,
      superadminid: superadminid ?? this.superadminid,
      societyid: societyid ?? this.societyid,
      subadminid: subadminid ?? this.subadminid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      name: name ?? this.name,
      email: email ?? this.email,
      cnic: cnic ?? this.cnic,
      address: address ?? this.address,
      mobileno: mobileno ?? this.mobileno,
      password: password ?? this.password,
      roleid: roleid ?? this.roleid,
      rolename: rolename ?? this.rolename,
      image: image ?? this.image,
      fcmtoken: fcmtoken ?? this.fcmtoken,
      code: code ?? this.code,
      isVerified: isVerified ?? this.isVerified,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

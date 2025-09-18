// To parse this JSON data, do
//
//     final allResidentModel = allResidentModelFromJson(jsonString);

import 'dart:convert';

AllResidentModel allResidentModelFromJson(String str) =>
    AllResidentModel.fromJson(json.decode(str));

String allResidentModelToJson(AllResidentModel data) =>
    json.encode(data.toJson());

class AllResidentModel {
  String? message;
  bool? success;
  Data? data;

  AllResidentModel({
    this.message,
    this.success,
    this.data,
  });

  factory AllResidentModel.fromJson(Map<String, dynamic> json) =>
      AllResidentModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  int? residentid;
  int? subadminid;
  String? username;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  String? visibility;
  int? committeemember;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstname;
  String? lastname;
  dynamic name;
  dynamic email;
  dynamic cnic;
  String? address;
  String? mobileno;
  String? password;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  int? code;
  int? isVerified;

  Datum({
    this.id,
    this.residentid,
    this.subadminid,
    this.username,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.visibility,
    this.committeemember,
    this.status,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        residentid: json["residentid"],
        subadminid: json["subadminid"],
        username: json["username"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        houseaddress: json["houseaddress"],
        vechileno: json["vechileno"],
        residenttype: json["residenttype"],
        propertytype: json["propertytype"],
        visibility: json["visibility"],
        committeemember: json["committeemember"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"],
        mobileno: json["mobileno"],
        password: json["password"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: json["image"],
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "subadminid": subadminid,
        "username": username,
        "country": country,
        "state": state,
        "city": city,
        "houseaddress": houseaddress,
        "vechileno": vechileno,
        "residenttype": residenttype,
        "propertytype": propertytype,
        "visibility": visibility,
        "committeemember": committeemember,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "firstname": firstname,
        "lastname": lastname,
        "name": name,
        "email": email,
        "cnic": cnic,
        "address": address,
        "mobileno": mobileno,
        "password": password,
        "roleid": roleid,
        "rolename": rolename,
        "image": image,
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

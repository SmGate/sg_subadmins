// To parse this JSON data, do
//
//     final domesticHelperProfileModel = domesticHelperProfileModelFromJson(jsonString);

import 'dart:convert';

DomesticHelperProfileModel domesticHelperProfileModelFromJson(String str) =>
    DomesticHelperProfileModel.fromJson(json.decode(str));

String domesticHelperProfileModelToJson(DomesticHelperProfileModel data) =>
    json.encode(data.toJson());

class DomesticHelperProfileModel {
  String? message;
  bool? success;
  Data? data;

  DomesticHelperProfileModel({
    this.message,
    this.success,
    this.data,
  });

  factory DomesticHelperProfileModel.fromJson(Map<String, dynamic> json) =>
      DomesticHelperProfileModel(
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
  int? societyId;
  String? name;
  String? phone;
  String? cnic;
  int? age;
  String? occupation;
  String? address;
  int? available;
  int? visitingFee;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Rating>? ratings;
  List<Booking>? bookings;

  Data({
    this.id,
    this.societyId,
    this.name,
    this.phone,
    this.cnic,
    this.age,
    this.occupation,
    this.address,
    this.available,
    this.visitingFee,
    this.createdAt,
    this.updatedAt,
    this.ratings,
    this.bookings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        societyId: json["society_id"],
        name: json["name"],
        phone: json["phone"],
        cnic: json["cnic"],
        age: json["age"],
        occupation: json["occupation"],
        address: json["address"],
        available: json["available"],
        visitingFee: json["visiting_fee"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        ratings: json["ratings"] == null
            ? []
            : List<Rating>.from(
                json["ratings"]!.map((x) => Rating.fromJson(x))),
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "society_id": societyId,
        "name": name,
        "phone": phone,
        "cnic": cnic,
        "age": age,
        "occupation": occupation,
        "address": address,
        "available": available,
        "visiting_fee": visitingFee,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "ratings": ratings == null
            ? []
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  int? id;
  int? societyId;
  int? workerId;
  int? residentId;
  DateTime? jobDate;
  String? jobTime;
  String? status;
  dynamic remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  Booking({
    this.id,
    this.societyId,
    this.workerId,
    this.residentId,
    this.jobDate,
    this.jobTime,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        societyId: json["society_id"],
        workerId: json["worker_id"],
        residentId: json["resident_id"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobTime: json["job_time"],
        status: json["status"],
        remarks: json["remarks"],
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
        "worker_id": workerId,
        "resident_id": residentId,
        "job_date":
            "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_time": jobTime,
        "status": status,
        "remarks": remarks,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Rating {
  int? id;
  int? workerId;
  int? residentId;
  int? bookingId;
  int? rating;
  String? review;
  dynamic createdAt;
  dynamic updatedAt;
  Resident? resident;

  Rating({
    this.id,
    this.workerId,
    this.residentId,
    this.bookingId,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.resident,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        workerId: json["worker_id"],
        residentId: json["resident_id"],
        bookingId: json["booking_id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        resident: json["resident"] == null
            ? null
            : Resident.fromJson(json["resident"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "worker_id": workerId,
        "resident_id": residentId,
        "booking_id": bookingId,
        "rating": rating,
        "review": review,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "resident": resident?.toJson(),
      };
}

class Resident {
  int? id;
  int? residentid;
  int? subadminid;
  int? societyId;
  dynamic username;
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
  int? isModerator;
  int? isForumBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;

  Resident({
    this.id,
    this.residentid,
    this.subadminid,
    this.societyId,
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
    this.isModerator,
    this.isForumBlocked,
    this.createdAt,
    this.updatedAt,
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        id: json["id"],
        residentid: json["residentid"],
        subadminid: json["subadminid"],
        societyId: json["society_id"],
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
        isModerator: json["is_moderator"],
        isForumBlocked: json["is_forum_blocked"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "subadminid": subadminid,
        "society_id": societyId,
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
        "is_moderator": isModerator,
        "is_forum_blocked": isForumBlocked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

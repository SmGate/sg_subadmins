// To parse this JSON data, do
//
//     final getAllDomesticHelperModel = getAllDomesticHelperModelFromJson(jsonString);

import 'dart:convert';

GetAllDomesticHelperModel getAllDomesticHelperModelFromJson(String str) =>
    GetAllDomesticHelperModel.fromJson(json.decode(str));

String getAllDomesticHelperModelToJson(GetAllDomesticHelperModel data) =>
    json.encode(data.toJson());

class GetAllDomesticHelperModel {
  String? message;
  bool? success;
  Data? data;

  GetAllDomesticHelperModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetAllDomesticHelperModel.fromJson(Map<String, dynamic> json) =>
      GetAllDomesticHelperModel(
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
  List<Worker>? workers;
  List<String>? occupations;

  Data({
    this.workers,
    this.occupations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        workers: json["workers"] == null
            ? []
            : List<Worker>.from(
                json["workers"]!.map((x) => Worker.fromJson(x))),
        occupations: json["occupations"] == null
            ? []
            : List<String>.from(json["occupations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "workers": workers == null
            ? []
            : List<dynamic>.from(workers!.map((x) => x.toJson())),
        "occupations": occupations == null
            ? []
            : List<dynamic>.from(occupations!.map((x) => x)),
      };
}

class Worker {
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
  dynamic ratingsAvgRating;
  List<Booking>? bookings;

  Worker({
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
    this.ratingsAvgRating,
    this.bookings,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
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
        ratingsAvgRating: json["ratings_avg_rating"],
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
        "ratings_avg_rating": ratingsAvgRating,
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

// To parse this JSON data, do
//
//     final visitorsLogsModel = visitorsLogsModelFromJson(jsonString);

import 'dart:convert';

VisitorsLogsModel visitorsLogsModelFromJson(String str) =>
    VisitorsLogsModel.fromJson(json.decode(str));

String visitorsLogsModelToJson(VisitorsLogsModel data) =>
    json.encode(data.toJson());

class VisitorsLogsModel {
  String? message;
  bool? success;
  Data? data;

  VisitorsLogsModel({
    this.message,
    this.success,
    this.data,
  });

  factory VisitorsLogsModel.fromJson(Map<String, dynamic> json) =>
      VisitorsLogsModel(
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
  dynamic nextPageUrl;
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
  String? name;
  String? visitortype;
  String? cnic;
  String? mobileno;
  String? statusdescription;
  String? vechileno;
  DateTime? arrivaldate;
  String? checkintime;
  String? checkouttime;
  String? entryType;

  Datum({
    this.id,
    this.name,
    this.visitortype,
    this.cnic,
    this.mobileno,
    this.statusdescription,
    this.vechileno,
    this.arrivaldate,
    this.checkintime,
    this.checkouttime,
    this.entryType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        visitortype: json["visitortype"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        statusdescription: json["statusdescription"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"] == null
            ? null
            : DateTime.parse(json["arrivaldate"]),
        checkintime: json["checkintime"],
        checkouttime: json["checkouttime"],
        entryType: json["entry_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "visitortype": visitortype,
        "cnic": cnic,
        "mobileno": mobileno,
        "statusdescription": statusdescription,
        "vechileno": vechileno,
        "arrivaldate":
            "${arrivaldate!.year.toString().padLeft(4, '0')}-${arrivaldate!.month.toString().padLeft(2, '0')}-${arrivaldate!.day.toString().padLeft(2, '0')}",
        "checkintime": checkintime,
        "checkouttime": checkouttime,
        "entry_type": entryType,
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

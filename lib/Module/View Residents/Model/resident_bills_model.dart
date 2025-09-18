// To parse this JSON data, do
//
//     final residentBillsModel = residentBillsModelFromJson(jsonString);

import 'dart:convert';

ResidentBillsModel residentBillsModelFromJson(String str) =>
    ResidentBillsModel.fromJson(json.decode(str));

String residentBillsModelToJson(ResidentBillsModel data) =>
    json.encode(data.toJson());

class ResidentBillsModel {
  String? message;
  bool? success;
  List<Datum>? data;

  ResidentBillsModel({
    this.message,
    this.success,
    this.data,
  });

  factory ResidentBillsModel.fromJson(Map<String, dynamic> json) =>
      ResidentBillsModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? billNumber;
  int? isAuto;
  String? description;
  dynamic otherDescription;
  String? charges;
  String? latecharges;
  String? appcharges;
  String? tax;
  String? balance;
  String? previousBalance;
  String? payableamount;
  String? totalpaidamount;
  int? subadminid;
  int? financemanagerid;
  int? residentid;
  int? propertyid;
  int? measurementid;
  DateTime? duedate;
  DateTime? billstartdate;
  DateTime? billenddate;
  dynamic paidOn;
  String? month;
  String? billtype;
  String? specificType;
  String? paymenttype;
  String? status;
  int? isbilllate;
  int? noofappusers;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.billNumber,
    this.isAuto,
    this.description,
    this.otherDescription,
    this.charges,
    this.latecharges,
    this.appcharges,
    this.tax,
    this.balance,
    this.previousBalance,
    this.payableamount,
    this.totalpaidamount,
    this.subadminid,
    this.financemanagerid,
    this.residentid,
    this.propertyid,
    this.measurementid,
    this.duedate,
    this.billstartdate,
    this.billenddate,
    this.paidOn,
    this.month,
    this.billtype,
    this.specificType,
    this.paymenttype,
    this.status,
    this.isbilllate,
    this.noofappusers,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        billNumber: json["bill_number"],
        isAuto: json["is_auto"],
        description: json["description"],
        otherDescription: json["other_description"],
        charges: json["charges"],
        latecharges: json["latecharges"],
        appcharges: json["appcharges"],
        tax: json["tax"],
        balance: json["balance"],
        previousBalance: json["previous_balance"],
        payableamount: json["payableamount"],
        totalpaidamount: json["totalpaidamount"],
        subadminid: json["subadminid"],
        financemanagerid: json["financemanagerid"],
        residentid: json["residentid"],
        propertyid: json["propertyid"],
        measurementid: json["measurementid"],
        duedate:
            json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
        billstartdate: json["billstartdate"] == null
            ? null
            : DateTime.parse(json["billstartdate"]),
        billenddate: json["billenddate"] == null
            ? null
            : DateTime.parse(json["billenddate"]),
        paidOn: json["paid_on"],
        month: json["month"],
        billtype: json["billtype"],
        specificType: json["specific_type"],
        paymenttype: json["paymenttype"],
        status: json["status"],
        isbilllate: json["isbilllate"],
        noofappusers: json["noofappusers"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bill_number": billNumber,
        "is_auto": isAuto,
        "description": description,
        "other_description": otherDescription,
        "charges": charges,
        "latecharges": latecharges,
        "appcharges": appcharges,
        "tax": tax,
        "balance": balance,
        "previous_balance": previousBalance,
        "payableamount": payableamount,
        "totalpaidamount": totalpaidamount,
        "subadminid": subadminid,
        "financemanagerid": financemanagerid,
        "residentid": residentid,
        "propertyid": propertyid,
        "measurementid": measurementid,
        "duedate":
            "${duedate!.year.toString().padLeft(4, '0')}-${duedate!.month.toString().padLeft(2, '0')}-${duedate!.day.toString().padLeft(2, '0')}",
        "billstartdate":
            "${billstartdate!.year.toString().padLeft(4, '0')}-${billstartdate!.month.toString().padLeft(2, '0')}-${billstartdate!.day.toString().padLeft(2, '0')}",
        "billenddate":
            "${billenddate!.year.toString().padLeft(4, '0')}-${billenddate!.month.toString().padLeft(2, '0')}-${billenddate!.day.toString().padLeft(2, '0')}",
        "paid_on": paidOn,
        "month": month,
        "billtype": billtype,
        "specific_type": specificType,
        "paymenttype": paymenttype,
        "status": status,
        "isbilllate": isbilllate,
        "noofappusers": noofappusers,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

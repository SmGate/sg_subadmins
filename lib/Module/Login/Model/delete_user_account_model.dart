// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromJson(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) =>
    DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) =>
    json.encode(data.toJson());

class DeleteAccountModel {
  String? message;
  bool? success;
  List<dynamic>? data;

  DeleteAccountModel({
    this.message,
    this.success,
    this.data,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      DeleteAccountModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

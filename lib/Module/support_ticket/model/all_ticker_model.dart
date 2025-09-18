import 'dart:convert';

GetAllTicketsModel getAllTicketsFromjson(String str) =>
    GetAllTicketsModel.fromJson(json.decode(str));

class GetAllTicketsModel {
  final String? message;
  final bool? success;
  final List<TicketData>? data;

  GetAllTicketsModel({
    this.message,
    this.success,
    this.data,
  });

  factory GetAllTicketsModel.fromJson(Map<String, dynamic> json) {
    return GetAllTicketsModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data:
          (json['data'] as List?)?.map((e) => TicketData.fromJson(e)).toList(),
    );
  }
}

class TicketData {
  final int? id;
  final String? ticketNo;
  final int? ownerId;
  final int? societyId;
  final String? title;
  final String? message;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic owner; // Since it is always null
  final Society? society;

  TicketData({
    this.id,
    this.ticketNo,
    this.ownerId,
    this.societyId,
    this.title,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.society,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      id: json['id'] ?? 0,
      ticketNo: json['ticket_no'] ?? '',
      ownerId: json['owner_id'] ?? 0,
      societyId: json['society_id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      owner: json['owner'],
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }
}

class Society {
  final int? id;
  final String? email;
  final String? phone;
  final String? country;
  final String? state;
  final String? city;
  final String? area;
  final String? type;
  final String? name;
  final String? slogan;
  final int? appcharges;
  final String? address;
  final String? logo;
  final String? splashImage;
  final int? hasCustomIntro;
  final int? superadminid;
  final int? structuretype;
  final String? createdAt;
  final String? updatedAt;
  final int? showAppchargesInBill;

  Society({
    this.id,
    this.email,
    this.phone,
    this.country,
    this.state,
    this.city,
    this.area,
    this.type,
    this.name,
    this.slogan,
    this.appcharges,
    this.address,
    this.logo,
    this.splashImage,
    this.hasCustomIntro,
    this.superadminid,
    this.structuretype,
    this.createdAt,
    this.updatedAt,
    this.showAppchargesInBill,
  });

  factory Society.fromJson(Map<String, dynamic> json) {
    return Society(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      slogan: json['slogan'] ?? '',
      appcharges: json['appcharges'] ?? 0,
      address: json['address'] ?? '',
      logo: json['logo'] ?? '',
      splashImage: json['splash_image'],
      hasCustomIntro: json['has_custom_intro'] ?? 0,
      superadminid: json['superadminid'] ?? 0,
      structuretype: json['structuretype'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      showAppchargesInBill: json['show_appcharges_in_bill'] ?? 0,
    );
  }
}

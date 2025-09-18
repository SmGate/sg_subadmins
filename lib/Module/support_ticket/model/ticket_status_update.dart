
import 'dart:convert';

TicketStatusUpdate ticketStatusUpdateFromjson(String str) =>
    TicketStatusUpdate.fromJson(json.decode(str));

class TicketStatusUpdate {
  final String? message;
  final TicketDataUpdate? ticket;

  TicketStatusUpdate({
    this.message,
    this.ticket,
  });

  factory TicketStatusUpdate.fromJson(Map<String, dynamic> json) {
    return TicketStatusUpdate(
      message: json['message'] ?? '',
      ticket: json['ticket'] != null
          ? TicketDataUpdate.fromJson(json['ticket'])
          : null,
    );
  }
}

class TicketDataUpdate {
  final int? id;
  final String? ticketNo;
  final int? ownerId;
  final int? societyId;
  final String? title;
  final String? message;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  TicketDataUpdate({
    this.id,
    this.ticketNo,
    this.ownerId,
    this.societyId,
    this.title,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketDataUpdate.fromJson(Map<String, dynamic> json) {
    return TicketDataUpdate(
      id: json['id'] ?? 0,
      ticketNo: json['ticket_no'] ?? '',
      ownerId: json['owner_id'] ?? 0,
      societyId: json['society_id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

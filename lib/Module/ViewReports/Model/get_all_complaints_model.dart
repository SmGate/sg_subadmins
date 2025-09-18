// get_all_complaint.dart
import 'dart:convert';

class GetAllComplaint {
  final bool? success;
  final List<ComplaintData>? data;
  final ComplaintMeta? meta;

  GetAllComplaint({
    this.success,
    this.data,
    this.meta,
  });

  factory GetAllComplaint.fromJson(Map<String, dynamic> json) {
    return GetAllComplaint(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : (json['data'] as List)
              .whereType<Map<String, dynamic>>()
              .map((e) => ComplaintData.fromJson(e))
              .toList(),
      meta: json['meta'] == null
          ? null
          : ComplaintMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }

  /// Optional: convenience helpers if your API returns string body
  static GetAllComplaint fromJsonString(String source) =>
      GetAllComplaint.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());
}

class ComplaintData {
  final int? id;
  final int? userid;
  final int? subadminid;
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ComplaintData({
    this.id,
    this.userid,
    this.subadminid,
    this.title,
    this.description,
    this.status,
    this.statusDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory ComplaintData.fromJson(Map<String, dynamic> json) {
    DateTime? _parseDate(dynamic v) {
      if (v == null) return null;
      final s = v.toString();
      try {
        return DateTime.tryParse(s);
      } catch (_) {
        return null;
      }
    }

    int? _parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString());
    }

    return ComplaintData(
      id: _parseInt(json['id']),
      userid: _parseInt(json['userid']),
      subadminid: _parseInt(json['subadminid']),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      status: _parseInt(json['status']),
      statusDescription: json['statusdescription']?.toString(),
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    String? _fmtDate(DateTime? d) => d?.toIso8601String();

    return {
      'id': id,
      'userid': userid,
      'subadminid': subadminid,
      'title': title,
      'description': description,
      'status': status,
      'statusdescription': statusDescription,
      'created_at': _fmtDate(createdAt),
      'updated_at': _fmtDate(updatedAt),
    };
  }
}

class ComplaintMeta {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  ComplaintMeta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory ComplaintMeta.fromJson(Map<String, dynamic> json) {
    int? _parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString());
    }

    return ComplaintMeta(
      currentPage: _parseInt(json['current_page']),
      lastPage: _parseInt(json['last_page']),
      perPage: _parseInt(json['per_page']),
      total: _parseInt(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}

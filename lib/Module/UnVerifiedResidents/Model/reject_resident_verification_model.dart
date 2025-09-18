class RejectResidentVerification {
  final bool? success;
  final RejectResidentData? data;

  RejectResidentVerification({
    this.success,
    this.data,
  });

  factory RejectResidentVerification.fromJson(Map<String, dynamic> json) {
    return RejectResidentVerification(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? RejectResidentData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class RejectResidentData {
  final int? id;
  final int? residentId;
  final int? subadminId;
  final int? societyId;
  final int? measurementId;
  final String? username;
  final String? residentName;
  final String? residentCnic;
  final String? residentPhone;
  final String? residentPermanentAddress;
  final String? residentTotalNumbers;
  final String? genderCount;
  final String? familyType;
  final String? country;
  final String? state;
  final String? city;
  final String? houseAddress;
  final String? vehicleNo;
  final String? residentType;
  final String? propertyType;
  final String? visibility;
  final int? committeeMember;
  final int? status;
  final int? verificationRejected;
  final String? rejectReason;
  final int? isModerator;
  final int? isForumBlocked;
  final String? createdAt;
  final String? updatedAt;
  final String? monthlyRent;
  final String? serviceCharge;
  final String? waterCharge;
  final String? rentStartDate;
  final String? incrementDate;
  final String? incrementPercentage;
  final String? securityAmount;
  final String? commissionPercentage;
  final int? parking;
  final String? parkingRate;
  final String? parkingSlot;

  RejectResidentData({
    this.id,
    this.residentId,
    this.subadminId,
    this.societyId,
    this.measurementId,
    this.username,
    this.residentName,
    this.residentCnic,
    this.residentPhone,
    this.residentPermanentAddress,
    this.residentTotalNumbers,
    this.genderCount,
    this.familyType,
    this.country,
    this.state,
    this.city,
    this.houseAddress,
    this.vehicleNo,
    this.residentType,
    this.propertyType,
    this.visibility,
    this.committeeMember,
    this.status,
    this.verificationRejected,
    this.rejectReason,
    this.isModerator,
    this.isForumBlocked,
    this.createdAt,
    this.updatedAt,
    this.monthlyRent,
    this.serviceCharge,
    this.waterCharge,
    this.rentStartDate,
    this.incrementDate,
    this.incrementPercentage,
    this.securityAmount,
    this.commissionPercentage,
    this.parking,
    this.parkingRate,
    this.parkingSlot,
  });

  factory RejectResidentData.fromJson(Map<String, dynamic> json) {
    return RejectResidentData(
      id: json['id'] ?? 0,
      residentId: json['residentid'] ?? 0,
      subadminId: json['subadminid'] ?? 0,
      societyId: json['society_id'],
      measurementId: json['measurement_id'],
      username: json['username'] ?? '',
      residentName: json['resident_name'] ?? '',
      residentCnic: json['resident_cnic'] ?? '',
      residentPhone: json['resident_phone'] ?? '',
      residentPermanentAddress: json['resident_permanent_address'] ?? '',
      residentTotalNumbers: json['resident_total_numbers'] ?? '',
      genderCount: json['gender_count'] ?? '',
      familyType: json['family_type'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      houseAddress: json['houseaddress'] ?? '',
      vehicleNo: json['vechileno'] ?? '',
      residentType: json['residenttype'] ?? '',
      propertyType: json['propertytype'] ?? '',
      visibility: json['visibility'] ?? '',
      committeeMember: json['committeemember'] ?? 0,
      status: json['status'] ?? 0,
      verificationRejected: json['verification_rejected'] ?? 0,
      rejectReason: json['reject_reason'] ?? '',
      isModerator: json['is_moderator'] ?? 0,
      isForumBlocked: json['is_forum_blocked'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      monthlyRent: json['monthly_rent']?.toString(),
      serviceCharge: json['service_charge']?.toString(),
      waterCharge: json['water_charge']?.toString(),
      rentStartDate: json['rent_start_date'] ?? '',
      incrementDate: json['increment_date'] ?? '',
      incrementPercentage: json['increment_percentage']?.toString(),
      securityAmount: json['security_amount']?.toString(),
      commissionPercentage: json['commission_percentage']?.toString(),
      parking: json['parking'] ?? 0,
      parkingRate: json['parking_rate']?.toString(),
      parkingSlot: json['parking_slot']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'residentid': residentId,
      'subadminid': subadminId,
      'society_id': societyId,
      'measurement_id': measurementId,
      'username': username,
      'resident_name': residentName,
      'resident_cnic': residentCnic,
      'resident_phone': residentPhone,
      'resident_permanent_address': residentPermanentAddress,
      'resident_total_numbers': residentTotalNumbers,
      'gender_count': genderCount,
      'family_type': familyType,
      'country': country,
      'state': state,
      'city': city,
      'houseaddress': houseAddress,
      'vechileno': vehicleNo,
      'residenttype': residentType,
      'propertytype': propertyType,
      'visibility': visibility,
      'committeemember': committeeMember,
      'status': status,
      'verification_rejected': verificationRejected,
      'reject_reason': rejectReason,
      'is_moderator': isModerator,
      'is_forum_blocked': isForumBlocked,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'monthly_rent': monthlyRent,
      'service_charge': serviceCharge,
      'water_charge': waterCharge,
      'rent_start_date': rentStartDate,
      'increment_date': incrementDate,
      'increment_percentage': incrementPercentage,
      'security_amount': securityAmount,
      'commission_percentage': commissionPercentage,
      'parking': parking,
      'parking_rate': parkingRate,
      'parking_slot': parkingSlot,
    };
  }
}

class MeasurementModel {
  MeasurementModel({
    this.message,
    this.data,
  });

  MeasurementModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? message;
  List<Data>? data;

  MeasurementModel copyWith({
    String? message,
    List<Data>? data,
  }) =>
      MeasurementModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.subadminid,
    this.type,
    this.unit,
    this.charges,
    this.lateCharges,
    this.appcharges,
    this.tax,
    this.area,
    this.bedrooms,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.monthlyRent,
    this.annualIncrement,
    this.category,
    this.society,
    this.societyBuilding,
    this.societyBuildingFloor,
    this.societyBuildingFloorApartment,
    this.appartmentType,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    subadminid = json['subadminid'];
    type = json['type'];
    unit = json['unit'];
    charges = json['charges'];
    lateCharges = json['latecharges'];
    appcharges = json['appcharges'];
    tax = json['tax'];
    area = json['area'];
    bedrooms = json['bedrooms'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    monthlyRent = json['monthly_rent'];
    annualIncrement = json['annual_increment'];
    category = json['category'];
    appartmentType = json['appartment_type'];
    society =
        json['society'] != null ? Society.fromJson(json['society']) : null;
    societyBuilding = json['society_building'] != null
        ? SocietyBuilding.fromJson(json['society_building'])
        : null;
    societyBuildingFloor = json['society_building_floor'] != null
        ? SocietyBuildingFloor.fromJson(json['society_building_floor'])
        : null;
    societyBuildingFloorApartment =
        json['society_building_floor_appartment'] != null
            ? SocietyBuildingFloorApartment.fromJson(
                json['society_building_floor_appartment'])
            : null;
  }

  int? id;
  int? subadminid;
  String? type;
  String? unit;
  String? charges;
  String? lateCharges;
  String? appcharges;
  String? tax;
  String? area;
  int? bedrooms;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? monthlyRent;
  int? annualIncrement;
  String? category;
  String? appartmentType;

  Society? society;
  SocietyBuilding? societyBuilding;
  SocietyBuildingFloor? societyBuildingFloor;
  SocietyBuildingFloorApartment? societyBuildingFloorApartment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subadminid'] = subadminid;
    map['type'] = type;
    map['unit'] = unit;
    map['charges'] = charges;
    map['latecharges'] = lateCharges;
    map['appcharges'] = appcharges;
    map['tax'] = tax;
    map['area'] = area;
    map['bedrooms'] = bedrooms;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['monthly_rent'] = monthlyRent;
    map['annual_increment'] = annualIncrement;
    map['category'] = category;
    map['appartment_type'] = appartmentType;
    map['society'] = society?.toJson();
    map['society_building'] = societyBuilding?.toJson();
    map['society_building_floor'] = societyBuildingFloor?.toJson();
    map['society_building_floor_appartment'] =
        societyBuildingFloorApartment?.toJson();
    return map;
  }
}

class Society {
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
  });

  Society.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    area = json['area'];
    type = json['type'];
    name = json['name'];
    slogan = json['slogan'];
    appcharges = json['appcharges'];
    address = json['address'];
    logo = json['logo'];
    splashImage = json['splash_image'];
    hasCustomIntro = json['has_custom_intro'];
    superadminid = json['superadminid'];
    structuretype = json['structuretype'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? email;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? area;
  String? type;
  String? name;
  String? slogan;
  int? appcharges;
  String? address;
  String? logo;
  String? splashImage;
  int? hasCustomIntro;
  int? superadminid;
  int? structuretype;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['phone'] = phone;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['area'] = area;
    map['type'] = type;
    map['name'] = name;
    map['slogan'] = slogan;
    map['appcharges'] = appcharges;
    map['address'] = address;
    map['logo'] = logo;
    map['splash_image'] = splashImage;
    map['has_custom_intro'] = hasCustomIntro;
    map['superadminid'] = superadminid;
    map['structuretype'] = structuretype;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class SocietyBuilding {
  SocietyBuilding({
    this.id,
    this.subadminid,
    this.superadminid,
    this.societyid,
    this.societybuildingname,
    this.dynamicid,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  SocietyBuilding.fromJson(dynamic json) {
    id = json['id'];
    subadminid = json['subadminid'];
    superadminid = json['superadminid'];
    societyid = json['societyid'];
    societybuildingname = json['societybuildingname'];
    dynamicid = json['dynamicid'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  int? subadminid;
  int? superadminid;
  int? societyid;
  String? societybuildingname;
  int? dynamicid;
  String? type;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subadminid'] = subadminid;
    map['superadminid'] = superadminid;
    map['societyid'] = societyid;
    map['societybuildingname'] = societybuildingname;
    map['dynamicid'] = dynamicid;
    map['type'] = type;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class SocietyBuildingFloor {
  SocietyBuildingFloor({
    this.id,
    this.name,
    this.category,
    this.buildingid,
    this.createdAt,
    this.updatedAt,
  });

  SocietyBuildingFloor.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    buildingid = json['buildingid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? name;
  String? category;
  int? buildingid;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['buildingid'] = buildingid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class SocietyBuildingFloorApartment {
  SocietyBuildingFloorApartment({
    this.id,
    this.societybuildingfloorid,
    this.name,
    this.typeid,
    this.type,
    this.occupied,
    this.createdAt,
    this.updatedAt,
    this.residentId,
    this.monthlyRent,
    this.annualIncrement,
    this.startDate,
  });

  SocietyBuildingFloorApartment.fromJson(dynamic json) {
    id = json['id'];
    societybuildingfloorid = json['societybuildingfloorid'];
    name = json['name'];
    typeid = json['typeid'];
    type = json['type'];
    occupied = json['occupied'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    residentId = json['resident_id'];
    monthlyRent = json['monthly_rent'];
    annualIncrement = json['annual_increment'];
    startDate = json['start_date'];
  }

  int? id;
  int? societybuildingfloorid;
  String? name;
  int? typeid;
  String? type;
  int? occupied;
  String? createdAt;
  String? updatedAt;
  int? residentId;
  int? monthlyRent;
  int? annualIncrement;
  String? startDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['societybuildingfloorid'] = societybuildingfloorid;
    map['name'] = name;
    map['typeid'] = typeid;
    map['type'] = type;
    map['occupied'] = occupied;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['resident_id'] = residentId;
    map['monthly_rent'] = monthlyRent;
    map['annual_increment'] = annualIncrement;
    map['start_date'] = startDate;
    return map;
  }
}

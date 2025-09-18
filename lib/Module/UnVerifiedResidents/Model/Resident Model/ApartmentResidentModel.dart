/// success : true
/// data : [{"id":8,"residentid":8,"subadminid":6,"country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Bahria Town,Civic Center, Floor 1,Apartment 1","vechileno":"rwp066","residenttype":"Rental","propertytype":"apartment","committeemember":0,"status":0,"created_at":"2023-04-28T13:04:45.000000Z","updated_at":"2023-04-28T13:10:11.000000Z","societyid":2,"buildingid":1,"societybuildingfloorid":1,"societybuildingapartmentid":1,"measurementid":4,"firstname":"kiki","lastname":"aulliya","cnic":"333","address":"---","mobileno":"085","password":"$2y$10$3w/BMCeuhi99j0ZJ7UHtcefKbM14q5j8tI9znL.EW6qWMcDFL3miC","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"doicq4q0TNyYXYxTFmd9y1:APA91bFWZ2nOzGuF09KSflTKsIWj8cHVvmCizf1uFXqGzsjUU_-cJVr1hR1qaIQJhRc43PUpr0C5j93CCHSBybwir6Zl-nIV328E5yy4BT5UyUy-S2WoNYsiSZtQ30FPji9xVNZ2YNcx","society":[{"id":2,"country":"🇵🇰    Pakistan","state":"null","city":"null","area":"Islamabad","type":"society","name":"Bahria Town","address":"Islamabad","superadminid":1,"structuretype":3,"created_at":"2023-04-28T12:52:32.000000Z","updated_at":"2023-04-28T12:52:32.000000Z"}],"building":[{"id":1,"subadminid":6,"superadminid":1,"societyid":2,"societybuildingname":"Civic Center","dynamicid":2,"type":"phase society building","created_at":"2023-04-28T13:03:38.000000Z","updated_at":"2023-04-28T13:03:38.000000Z"}],"floor":[{"id":1,"name":"Floor 1","buildingid":1,"created_at":"2023-04-28T13:03:45.000000Z","updated_at":"2023-04-28T13:03:45.000000Z"}],"apartment":[{"id":1,"societybuildingfloorid":1,"name":"Apartment 1","typeid":1,"type":"apartment","occupied":0,"created_at":"2023-04-28T13:03:52.000000Z","updated_at":"2023-04-28T13:03:52.000000Z"}],"measurement":[{"id":4,"subadminid":6,"type":"apartment","unit":"sqft","charges":"5000.00","chargesafterduedate":"5250.00","appcharges":"100.00","tax":"750.00","area":"500.00","bedrooms":5,"status":0,"created_at":"2023-04-28T13:08:22.000000Z","updated_at":"2023-04-28T13:08:22.000000Z"}],"owner":[{"id":3,"residentid":8,"ownername":"khan","owneraddress":"NA","ownermobileno":"g","created_at":"2023-04-28T13:10:11.000000Z","updated_at":"2023-04-28T13:10:11.000000Z"}]}]

class ApartmentResidentModel {
  ApartmentResidentModel({
    this.success,
    this.data,
  });

  ApartmentResidentModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;
  ApartmentResidentModel copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      ApartmentResidentModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.residentid,
    this.subadminid,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.committeemember,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.societyid,
    this.buildingid,
    this.societybuildingfloorid,
    this.societybuildingapartmentid,
    this.measurementid,
    this.firstname,
    this.lastname,
    this.cnic,
    this.address,
    this.mobileno,
    this.password,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.society,
    this.building,
    this.floor,
    this.apartment,
    this.measurement,
    this.owner,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    subadminid = json['subadminid'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    houseaddress = json['houseaddress'];
    vechileno = json['vechileno'];
    residenttype = json['residenttype'];
    propertytype = json['propertytype'];
    committeemember = json['committeemember'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    societyid = json['societyid'];
    buildingid = json['buildingid'];
    societybuildingfloorid = json['societybuildingfloorid'];
    societybuildingapartmentid = json['societybuildingapartmentid'];
    measurementid = json['measurementid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cnic = json['cnic'];
    address = json['address'];
    mobileno = json['mobileno'];
    password = json['password'];
    roleid = json['roleid'];
    rolename = json['rolename'];
    image = json['image'];
    fcmtoken = json['fcmtoken'];
    if (json['society'] != null) {
      society = [];
      json['society'].forEach((v) {
        society?.add(Society.fromJson(v));
      });
    }
    if (json['building'] != null) {
      building = [];
      json['building'].forEach((v) {
        building?.add(Building.fromJson(v));
      });
    }
    if (json['floor'] != null) {
      floor = [];
      json['floor'].forEach((v) {
        floor?.add(Floor.fromJson(v));
      });
    }
    if (json['apartment'] != null) {
      apartment = [];
      json['apartment'].forEach((v) {
        apartment?.add(Apartment.fromJson(v));
      });
    }
    if (json['measurement'] != null) {
      measurement = [];
      json['measurement'].forEach((v) {
        measurement?.add(Measurement.fromJson(v));
      });
    }
    if (json['owner'] != null) {
      owner = [];
      json['owner'].forEach((v) {
        owner?.add(Owner.fromJson(v));
      });
    }
  }
  int? id;
  int? residentid;
  int? subadminid;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  int? committeemember;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? societyid;
  int? buildingid;
  int? societybuildingfloorid;
  int? societybuildingapartmentid;
  int? measurementid;
  String? firstname;
  String? lastname;
  String? cnic;
  String? address;
  String? mobileno;
  String? password;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  List<Society>? society;
  List<Building>? building;
  List<Floor>? floor;
  List<Apartment>? apartment;
  List<Measurement>? measurement;
  List<Owner>? owner;
  Data copyWith({
    int? id,
    int? residentid,
    int? subadminid,
    String? country,
    String? state,
    String? city,
    String? houseaddress,
    String? vechileno,
    String? residenttype,
    String? propertytype,
    int? committeemember,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? societyid,
    int? buildingid,
    int? societybuildingfloorid,
    int? societybuildingapartmentid,
    int? measurementid,
    String? firstname,
    String? lastname,
    String? cnic,
    String? address,
    String? mobileno,
    String? password,
    int? roleid,
    String? rolename,
    String? image,
    String? fcmtoken,
    List<Society>? society,
    List<Building>? building,
    List<Floor>? floor,
    List<Apartment>? apartment,
    List<Measurement>? measurement,
    List<Owner>? owner,
  }) =>
      Data(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        subadminid: subadminid ?? this.subadminid,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        houseaddress: houseaddress ?? this.houseaddress,
        vechileno: vechileno ?? this.vechileno,
        residenttype: residenttype ?? this.residenttype,
        propertytype: propertytype ?? this.propertytype,
        committeemember: committeemember ?? this.committeemember,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        societyid: societyid ?? this.societyid,
        buildingid: buildingid ?? this.buildingid,
        societybuildingfloorid:
            societybuildingfloorid ?? this.societybuildingfloorid,
        societybuildingapartmentid:
            societybuildingapartmentid ?? this.societybuildingapartmentid,
        measurementid: measurementid ?? this.measurementid,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        cnic: cnic ?? this.cnic,
        address: address ?? this.address,
        mobileno: mobileno ?? this.mobileno,
        password: password ?? this.password,
        roleid: roleid ?? this.roleid,
        rolename: rolename ?? this.rolename,
        image: image ?? this.image,
        fcmtoken: fcmtoken ?? this.fcmtoken,
        society: society ?? this.society,
        building: building ?? this.building,
        floor: floor ?? this.floor,
        apartment: apartment ?? this.apartment,
        measurement: measurement ?? this.measurement,
        owner: owner ?? this.owner,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['subadminid'] = subadminid;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['houseaddress'] = houseaddress;
    map['vechileno'] = vechileno;
    map['residenttype'] = residenttype;
    map['propertytype'] = propertytype;
    map['committeemember'] = committeemember;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['societyid'] = societyid;
    map['buildingid'] = buildingid;
    map['societybuildingfloorid'] = societybuildingfloorid;
    map['societybuildingapartmentid'] = societybuildingapartmentid;
    map['measurementid'] = measurementid;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['cnic'] = cnic;
    map['address'] = address;
    map['mobileno'] = mobileno;
    map['password'] = password;
    map['roleid'] = roleid;
    map['rolename'] = rolename;
    map['image'] = image;
    map['fcmtoken'] = fcmtoken;
    if (society != null) {
      map['society'] = society?.map((v) => v.toJson()).toList();
    }
    if (building != null) {
      map['building'] = building?.map((v) => v.toJson()).toList();
    }
    if (floor != null) {
      map['floor'] = floor?.map((v) => v.toJson()).toList();
    }
    if (apartment != null) {
      map['apartment'] = apartment?.map((v) => v.toJson()).toList();
    }
    if (measurement != null) {
      map['measurement'] = measurement?.map((v) => v.toJson()).toList();
    }
    if (owner != null) {
      map['owner'] = owner?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// residentid : 8
/// ownername : "khan"
/// owneraddress : "NA"
/// ownermobileno : "g"
/// created_at : "2023-04-28T13:10:11.000000Z"
/// updated_at : "2023-04-28T13:10:11.000000Z"

class Owner {
  Owner({
    this.id,
    this.residentid,
    this.ownername,
    this.owneraddress,
    this.ownermobileno,
    this.createdAt,
    this.updatedAt,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    ownername = json['ownername'];
    owneraddress = json['owneraddress'];
    ownermobileno = json['ownermobileno'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? residentid;
  String? ownername;
  String? owneraddress;
  String? ownermobileno;
  String? createdAt;
  String? updatedAt;
  Owner copyWith({
    int? id,
    int? residentid,
    String? ownername,
    String? owneraddress,
    String? ownermobileno,
    String? createdAt,
    String? updatedAt,
  }) =>
      Owner(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        ownername: ownername ?? this.ownername,
        owneraddress: owneraddress ?? this.owneraddress,
        ownermobileno: ownermobileno ?? this.ownermobileno,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['ownername'] = ownername;
    map['owneraddress'] = owneraddress;
    map['ownermobileno'] = ownermobileno;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 4
/// subadminid : 6
/// type : "apartment"
/// unit : "sqft"
/// charges : "5000.00"
/// chargesafterduedate : "5250.00"
/// appcharges : "100.00"
/// tax : "750.00"
/// area : "500.00"
/// bedrooms : 5
/// status : 0
/// created_at : "2023-04-28T13:08:22.000000Z"
/// updated_at : "2023-04-28T13:08:22.000000Z"

class Measurement {
  Measurement({
    this.id,
    this.subadminid,
    this.type,
    this.unit,
    this.charges,
    this.chargesafterduedate,
    this.appcharges,
    this.tax,
    this.area,
    this.bedrooms,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.societyId,
    this.societyBuildingId,
    this.societyBuildingFloorId,
    this.societyBuildingApartmentId,
    this.appartmentType,
    this.category,
    this.monthlyRent,
    this.annualIncrement,
  });

  Measurement.fromJson(dynamic json) {
    id = json['id'];
    subadminid = json['subadminid'];
    type = json['type'];
    unit = json['unit'];
    charges = json['charges'];
    chargesafterduedate = json['latecharges'];
    appcharges = json['appcharges'];
    tax = json['tax'];
    area = json['area'];
    bedrooms = json['bedrooms'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    societyId = json['society_id'];
    societyBuildingId = json['societybuilding_id'];
    societyBuildingFloorId = json['societybuildingfloor_id'];
    societyBuildingApartmentId = json['societybuildingapartment_id'];
    appartmentType = json['appartment_type'];
    category = json['category'];
    monthlyRent = json['monthly_rent'];
    annualIncrement = json['annual_increment'];
  }

  int? id;
  int? subadminid;
  String? type;
  String? unit;
  String? charges;
  String? chargesafterduedate; // from latecharges
  String? appcharges;
  String? tax;
  String? area;
  int? bedrooms;
  int? status;
  String? createdAt;
  String? updatedAt;

  // Newly added fields:
  int? societyId;
  int? societyBuildingId;
  int? societyBuildingFloorId;
  int? societyBuildingApartmentId;
  String? appartmentType;
  String? category;
  String? monthlyRent;
  String? annualIncrement;

  Measurement copyWith({
    int? id,
    int? subadminid,
    String? type,
    String? unit,
    String? charges,
    String? chargesafterduedate,
    String? appcharges,
    String? tax,
    String? area,
    int? bedrooms,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? societyId,
    int? societyBuildingId,
    int? societyBuildingFloorId,
    int? societyBuildingApartmentId,
    String? appartmentType,
    String? category,
    String? monthlyRent,
    String? annualIncrement,
  }) =>
      Measurement(
        id: id ?? this.id,
        subadminid: subadminid ?? this.subadminid,
        type: type ?? this.type,
        unit: unit ?? this.unit,
        charges: charges ?? this.charges,
        chargesafterduedate: chargesafterduedate ?? this.chargesafterduedate,
        appcharges: appcharges ?? this.appcharges,
        tax: tax ?? this.tax,
        area: area ?? this.area,
        bedrooms: bedrooms ?? this.bedrooms,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        societyId: societyId ?? this.societyId,
        societyBuildingId: societyBuildingId ?? this.societyBuildingId,
        societyBuildingFloorId:
            societyBuildingFloorId ?? this.societyBuildingFloorId,
        societyBuildingApartmentId:
            societyBuildingApartmentId ?? this.societyBuildingApartmentId,
        appartmentType: appartmentType ?? this.appartmentType,
        category: category ?? this.category,
        monthlyRent: monthlyRent ?? this.monthlyRent,
        annualIncrement: annualIncrement ?? this.annualIncrement,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subadminid'] = subadminid;
    map['type'] = type;
    map['unit'] = unit;
    map['charges'] = charges;
    map['latecharges'] = chargesafterduedate;
    map['appcharges'] = appcharges;
    map['tax'] = tax;
    map['area'] = area;
    map['bedrooms'] = bedrooms;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['society_id'] = societyId;
    map['societybuilding_id'] = societyBuildingId;
    map['societybuildingfloor_id'] = societyBuildingFloorId;
    map['societybuildingapartment_id'] = societyBuildingApartmentId;
    map['appartment_type'] = appartmentType;
    map['category'] = category;
    map['monthly_rent'] = monthlyRent;
    map['annual_increment'] = annualIncrement;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Measurement &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// id : 1
/// societybuildingfloorid : 1
/// name : "Apartment 1"
/// typeid : 1
/// type : "apartment"
/// occupied : 0
/// created_at : "2023-04-28T13:03:52.000000Z"
/// updated_at : "2023-04-28T13:03:52.000000Z"

class Apartment {
  Apartment({
    this.id,
    this.societybuildingfloorid,
    this.name,
    this.typeid,
    this.type,
    this.occupied,
    this.createdAt,
    this.updatedAt,
  });

  Apartment.fromJson(dynamic json) {
    id = json['id'];
    societybuildingfloorid = json['societybuildingfloorid'];
    name = json['name'];
    typeid = json['typeid'];
    type = json['type'];
    occupied = json['occupied'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? societybuildingfloorid;
  String? name;
  int? typeid;
  String? type;
  int? occupied;
  String? createdAt;
  String? updatedAt;
  Apartment copyWith({
    int? id,
    int? societybuildingfloorid,
    String? name,
    int? typeid,
    String? type,
    int? occupied,
    String? createdAt,
    String? updatedAt,
  }) =>
      Apartment(
        id: id ?? this.id,
        societybuildingfloorid:
            societybuildingfloorid ?? this.societybuildingfloorid,
        name: name ?? this.name,
        typeid: typeid ?? this.typeid,
        type: type ?? this.type,
        occupied: occupied ?? this.occupied,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
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
    return map;
  }
}

/// id : 1
/// name : "Floor 1"
/// buildingid : 1
/// created_at : "2023-04-28T13:03:45.000000Z"
/// updated_at : "2023-04-28T13:03:45.000000Z"

class Floor {
  Floor({
    this.id,
    this.name,
    this.buildingid,
    this.createdAt,
    this.updatedAt,
  });

  Floor.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    buildingid = json['buildingid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? buildingid;
  String? createdAt;
  String? updatedAt;
  Floor copyWith({
    int? id,
    String? name,
    int? buildingid,
    String? createdAt,
    String? updatedAt,
  }) =>
      Floor(
        id: id ?? this.id,
        name: name ?? this.name,
        buildingid: buildingid ?? this.buildingid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['buildingid'] = buildingid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 1
/// subadminid : 6
/// superadminid : 1
/// societyid : 2
/// societybuildingname : "Civic Center"
/// dynamicid : 2
/// type : "phase society building"
/// created_at : "2023-04-28T13:03:38.000000Z"
/// updated_at : "2023-04-28T13:03:38.000000Z"

class Building {
  Building({
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

  Building.fromJson(dynamic json) {
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
  Building copyWith({
    int? id,
    int? subadminid,
    int? superadminid,
    int? societyid,
    String? societybuildingname,
    int? dynamicid,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) =>
      Building(
        id: id ?? this.id,
        subadminid: subadminid ?? this.subadminid,
        superadminid: superadminid ?? this.superadminid,
        societyid: societyid ?? this.societyid,
        societybuildingname: societybuildingname ?? this.societybuildingname,
        dynamicid: dynamicid ?? this.dynamicid,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
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

/// id : 2
/// country : "🇵🇰    Pakistan"
/// state : "null"
/// city : "null"
/// area : "Islamabad"
/// type : "society"
/// name : "Bahria Town"
/// address : "Islamabad"
/// superadminid : 1
/// structuretype : 3
/// created_at : "2023-04-28T12:52:32.000000Z"
/// updated_at : "2023-04-28T12:52:32.000000Z"

class Society {
  Society({
    this.id,
    this.country,
    this.state,
    this.city,
    this.area,
    this.type,
    this.name,
    this.address,
    this.superadminid,
    this.structuretype,
    this.createdAt,
    this.updatedAt,
  });

  Society.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    area = json['area'];
    type = json['type'];
    name = json['name'];
    address = json['address'];
    superadminid = json['superadminid'];
    structuretype = json['structuretype'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? country;
  String? state;
  String? city;
  String? area;
  String? type;
  String? name;
  String? address;
  int? superadminid;
  int? structuretype;
  String? createdAt;
  String? updatedAt;
  Society copyWith({
    int? id,
    String? country,
    String? state,
    String? city,
    String? area,
    String? type,
    String? name,
    String? address,
    int? superadminid,
    int? structuretype,
    String? createdAt,
    String? updatedAt,
  }) =>
      Society(
        id: id ?? this.id,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        area: area ?? this.area,
        type: type ?? this.type,
        name: name ?? this.name,
        address: address ?? this.address,
        superadminid: superadminid ?? this.superadminid,
        structuretype: structuretype ?? this.structuretype,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['area'] = area;
    map['type'] = type;
    map['name'] = name;
    map['address'] = address;
    map['superadminid'] = superadminid;
    map['structuretype'] = structuretype;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

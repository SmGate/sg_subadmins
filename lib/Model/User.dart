class User {
  final int? userid;
  final String? firstName;
  final String? lastName;
  final String? cnic;
  final int? roleId;
  final int? societyid;
  final int? subadminid;
  final String? roleName;
  final String? bearerToken;
  final String? fcmtoken;
  final String? address;
  final String? mobileno;
  final String? image;
  final String? created_at;
  final String? updated_at;
  final int? superadminid;
  final int? structureType;
  final String? societyorbuildingname;
  Map<String, dynamic>? permissions;

  // final List<GateKeeper>? gatekeeperlist;

  User(
      {this.societyorbuildingname,
      this.structureType,
      this.userid,
      this.image,
      this.societyid,
      this.subadminid,
      this.firstName,
      this.lastName,
      this.cnic,
      this.roleId,
      this.roleName,
      this.bearerToken,
      this.address,
      this.mobileno,
      this.fcmtoken,
      this.superadminid,
      this.created_at,
      this.updated_at,
      this.permissions
      // this.gatekeeperlist,
      });
}

// {
// "success": true,
// "data": {
// "id": 1,
// "firstname": "Fuzail",
// "lastname": "Raza",
// "cnic": "37405",
// "address": "Chakri Road Rawalpindi",
// "mobileno": "03215550979",
// "password": "$2y$10$Arxuk.mjZ6vLg2dO7caHPOFm6HiOEmgM/rq.odOA9xuLTAfG9KxFm",
// "roleid": 2,
// "rolename": "subadmin",
// "image": "1670845608.png",
// "fcmtoken": "ft3Y3iYKRzOGjus055W-96:APA91bFhTj9ePLbbeXpUBvL7snzeR0v8gRiuuuKdnFoxLYngUU4Q763BTchqqph0Qby7DuSxMxwMAR6nH4xePBbyGcga5vd4-oV6IMAFQuBygSPJ2zO7ZoH9trZQSEx5aqmQj9xHHgYn",
// "created_at": "2022-12-12T11:46:48.000000Z",
// "updated_at": "2022-12-12T11:46:48.000000Z",
// "superadminid": 1,
// "societyid": 1,
// "subadminid": 2
// },
// "Bearer": "14|TQJtyHiBB8plbTasFtcdq3ppP1jQFph75kYyajPd"
// }
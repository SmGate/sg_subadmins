import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Houses/Model/Houses.dart';

import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../../../Model/User.dart';

class HouseController extends GetxController {
  var data = Get.arguments;
  // int? sid ;
  // int? bid ;
  // int? pid ;
  // String? bearerToken;
  int apiCount = 0;

  User user = User(
      structureType: 0,
      userid: 0,
      image: '',
      societyid: 0,
      subadminid: 0,
      firstName: '',
      lastName: '',
      cnic: '',
      roleId: 0,
      roleName: '',
      bearerToken: '',
      address: '',
      mobileno: '',
      fcmtoken: '',
      superadminid: 0,
      created_at: '',
      updated_at: '');

  int streetid = 0;
  int blockid = 0;
  int phaseid = 0;

  @override
  void onInit() async {
    // sid=data[0];
    // bid=data[1];
    // pid=data[2];
    // bearerToken=data[3];
    //  user = data[0];
    //  streetid = data[1];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      super.onInit();

      user = await MySharedPreferences.getUserData();

      if (user.structureType == 5) {
        user = data;
      } else if (user.structureType == 1) {
        user = data[0];
        streetid = data[1];
      } else if (user.structureType == 2) {
        user = data[0];
        streetid = data[1];
        blockid = data[2];
      } else if (user.structureType == 3) {
        user = data[0];
        streetid = data[1];
        blockid = data[2];
        phaseid = data[3];
      }

      update();
    });
  }

  Future<Houses> housesApi(
      {required int dynamicid, required String bearerToken}) async {
    // String? type;
    // if (user.structureType == 1) {
    //   type = 'house';
    // } else if (user.structureType == 2) {
    //   type = 'street';
    // }
    print('house api count ${apiCount++}');

    String type;
    if (user.structureType == 5) {
      type = 'society';
    } else {
      type = 'street';
    }

    final response = await Http.get(
      Uri.parse(
          Api.properties + "/" + dynamicid.toString() + "/" + type.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Houses.fromJson(data);
    }

    return Houses.fromJson(data);
  }
}

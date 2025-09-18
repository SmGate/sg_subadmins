import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/AddSocietyDetail/Blocks/Model/Blocks.dart';

import '../../../../utils/Constants/api_routes.dart';
import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../../../Model/User.dart';

class BlocksController extends GetxController {
  var data = Get.arguments;
// int? pid ;
// String? bearerToken;
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
  int phaseid = 0;
  @override
  void onInit() {
    super.onInit();

    // pid=data[0];
    // bearerToken=data[1];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      super.onInit();

      user = await MySharedPreferences.getUserData();

      if (user.structureType == 2) {
        user = data;
      } else {
        user = data[0];
        phaseid = data[1];
      }

      update();
    });
  }

  Future<Blocks> blocksApi(
      {required int dynamicid, required String bearerToken}) async {
    print("${dynamicid.toString()}");
    print(bearerToken);
    String? type;
    if (user.structureType == 2) {
      type = 'society';
    } else if (user.structureType == 3) {
      type = 'phase';
    }
    final response = await Http.get(
      Uri.parse(
          Api.blocks + "/" + dynamicid.toString() + "/" + type.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
    );
    print(response.statusCode);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return Blocks.fromJson(data);
    }

    return Blocks.fromJson(data);
  }


  
}

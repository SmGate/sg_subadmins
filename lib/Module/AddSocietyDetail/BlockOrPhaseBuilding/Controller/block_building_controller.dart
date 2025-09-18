import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../../../Model/User.dart';

import '../Model/BlockBuilding.dart';

class BlockBuildingController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;
  String? type;

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

  BlockBuilding? blockBuilding;

  bool isLoading = false;
  final fromController = TextEditingController();
  final toController = TextEditingController();

  int bid = 0;
  int pid = 0;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      super.onInit();

      user = await MySharedPreferences.getUserData();

      if (user.structureType == 2) {
        user = data[0];
        bid = data[1];
        type = 'block building';
      } else {
        user = data[0];
        pid = data[1];
        type = 'phase building';
      }

      update();
    });
  }

  Future<BlockBuilding> SocietyBuildingApi(
      {required int dynamicid, required String token}) async {
    print("${dynamicid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.societyBuildings +
          "/" +
          dynamicid.toString() +
          "/" +
          type.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);

      return BlockBuilding.fromJson(data);
    }

    return BlockBuilding.fromJson(data);
  }
}

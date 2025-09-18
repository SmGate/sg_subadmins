import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Streets/Model/Streets.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Services/Shared%20Preferences/MySharedPreferences.dart';
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

class StreetsController extends GetxController {
  var data = Get.arguments;
  // int? bid ;
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

  int blockid = 0;
  int? phaseid;

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      super.onInit();

      user = await MySharedPreferences.getUserData();

      if (user.structureType == 1) {
        user = data;
        print(user);
      } else if (user.structureType == 2) {
        user = data[0];
        blockid = data[1];
      } else if (user.structureType == 3) {
        user = data[0];
        blockid = data[1];
        phaseid = data[2];
      }

      update();
    });

    // user = await MySharedPreferences.getUserData();

    // Future.delayed(
    //   Duration(seconds: 2),
    //   () {

    //   },
    // );

    // bid=data[0];
    // pid=data[1];
    // bearerToken=data[2];
  }

  Future<Streets> streetsApi(
      {required int dynamicid, required String bearerToken}) async {
    print("${dynamicid.toString()}");
    print(bearerToken);
    String? type;
    if (user.structureType == 1) {
      type = 'society';
    } else {
      type = 'blocks';
    }

    final response = await Http.get(
      Uri.parse(
          Api.streets + "/" + dynamicid.toString() + "/" + type.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
    );
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      print(response.body);
      return Streets.fromJson(data);
    }

    return Streets.fromJson(data);
  }
}

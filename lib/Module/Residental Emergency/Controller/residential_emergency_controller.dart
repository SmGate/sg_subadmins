import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../utils/Constants/api_routes.dart';
import '../../../Model/User.dart';
import '../Model/ResidentialEmergeny.dart';

class ResidentialEmergencyController extends GetxController {
  late final User userdata;

  Uri? uri;
  var data = Get.arguments;

  @override
  void onInit() {
    super.onInit();

    userdata = data;
  }

  viewVistorsDetailApi(int subadminid, String token) async {
    final userId =
        userdata.structureType == 6 ? subadminid : userdata.societyid ?? 0;
    final response = await Http.get(
      Uri.parse(Api.viewEmergency + "/" + userId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return ResidentialEmergeny.fromJson(data);
    }
    return ResidentialEmergeny.fromJson(data);
  }
}

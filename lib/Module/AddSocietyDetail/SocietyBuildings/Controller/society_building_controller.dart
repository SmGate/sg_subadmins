import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/society_building_model.dart';

class SocietyBuildingController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;

  late final User user;

  SocietyBuilding? societyBuilding;

  bool isLoading = false;
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String? type;

  @override
  void onInit() {
    super.onInit();
    user = data;

    if (user.structureType == 1) {
      type = 'street society building';
    } else if (user.structureType == 2) {
      type = 'block society building';
    } else {
      type = 'phase society building';
    }
  }

  Future<SocietyBuilding> societyBuildingApi(
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

      return SocietyBuilding.fromJson(data);
    }

    return SocietyBuilding.fromJson(data);
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';

import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

class AddSocietyBuildingApartmentsController extends GetxController {
  var argumnet = Get.arguments;
  int? fid;
  int? bid;

  bool isLoading = false;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  late final User user;
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    user = argumnet[0];
    fid = argumnet[1];
    bid = argumnet[2];
  }

  addApartmentsApi({
    required String bearerToken,
    required int fid,
    required String from,
    required String to,
    String? name,
    int? typeId,
    String? type,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
    var request = Http.MultipartRequest(
        'POST', Uri.parse(Api.addSocietyBuildingApartments));
    request.headers.addAll(headers);
    if (name != null && name.trim().isNotEmpty) {
      request.fields['name'] = name.trim();
    } else {
      request.fields['from'] = from;
      request.fields['to'] = to;
    }
    if (typeId != null) request.fields['typeid'] = typeId.toString();
    if (type != null && type.trim().isNotEmpty)
      request.fields['type'] = type.trim();
    request.fields['societybuildingfloorid'] = fid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    print(response.body);

    if (response.statusCode == 200) {
      final String t = SessionController().selectedFloorType;
      final String successMsg = t == 'Corporate'
          ? 'Offices added successfully'
          : t == 'Commercial'
              ? 'Shops added successfully'
              : 'Apartments added successfully';
      Get.snackbar(successMsg, "");
      Get.offAndToNamed(societybuildingapartmentscreen,
          arguments: [user, fid, bid]);

      isLoading = false;
      update();
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());

      Get.snackbar(
        "Error",
        data.toString(),
      );

      isLoading = false;
      update();
    } else {
      Get.snackbar("Failed to Add Apartments", "");
      isLoading = false;
      update();
    }
  }
}

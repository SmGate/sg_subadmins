// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Routes/set_routes.dart';
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/Phases.dart';

class PhasesController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;
  late final User user;
  Phases? phases;

  List<Map<String, dynamic>> myApiData = [];
  bool isLoading = false;
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    user = data;
  }

  Future<Phases> phasesApi(
      {required int societyid, required String token}) async {
    print("${societyid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.phases + "/" + societyid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      print(response.body);
      return Phases.fromJson(data);
    }

    return Phases.fromJson(data);
  }

  addPhaseApi({
    required String bearerToken,
    required int subadminid,
    required int societyid,
    required String from,
    required String to,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.addPhases));
    request.headers.addAll(headers);

    request.fields['from'] = from;
    request.fields['to'] = to;
    request.fields['subadminid'] = subadminid.toString();
    request.fields['societyid'] = societyid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      Get.snackbar("Phases Add Successfully", "");

      Get.offAndToNamed(phasess, arguments: user);
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body.toString());

      Get.snackbar(
        "Error",
        data.toString(),
      );
    } else {
      isLoading = false;
      update();

      Get.snackbar("Failed to Add Phases", "");
    }
  }
}

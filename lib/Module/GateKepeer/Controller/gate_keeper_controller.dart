import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/gate_keeper_model.dart';

class GateKeeperController extends GetxController {
  var userdata = Get.arguments;
  late final User user;
  List<Gatekeeper> li = [];

  @override
  void onInit() {
    super.onInit();

    user = userdata;
  }

  Future<List<Gatekeeper>> viewGatekeepersApi(
      int subadminId, String token) async {
    print("subadminiid.toString() ${subadminId.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.viewGatekeepers + "/" + subadminId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      li = (data['gatekeeperlist'] as List)
          .map((e) => Gatekeeper(
                gatekeeperid: e['gatekeeperid'],
                firstName: e['firstname'],
                image: e['image'],
                password: e['password'],
                id: e['id'],
                address: e['address'],
                gateno: e['gateno'],
                cnic: e['cnic'],
                lastName: e['lastname'],
                mobileno: e['mobileno'],
                roleid: e['roleid'],
                rolename: e['rolename'],
                subadminid: e['subadminid'],
                societyid: e['societyid'],
              ))
          .toList();

      return li;
    }
    return li;
  }

  Future<void> deleteGateKeeperApi(
      int gatekeeperid, String token, BuildContext context) async {
    try {
      final response = await Http.get(
        Uri.parse("${Api.deleteGatekeeper}/$gatekeeperid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        final mydata = data['data'];
        print('Deleted data: $mydata');

        // Success feedback
        Get.snackbar(
          "Success",
          "Gatekeeper deleted successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
        Navigator.of(context).pop();
        // Refresh list
        await viewGatekeepersApi(user.userid ?? 0, userdata.bearerToken!);

        // Get.back(); // Close the delete confirmation dialog
        update();
      } else {
        final data = jsonDecode(response.body.toString());
        String errorMsg = data['message'] ?? "Something went wrong";

        Get.snackbar(
          "Error",
          errorMsg,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

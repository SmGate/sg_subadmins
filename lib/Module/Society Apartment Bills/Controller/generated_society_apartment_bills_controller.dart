import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../utils/Constants/api_routes.dart';
import '../../House Bills/Model/BillModel.dart';
import '../../../../Model/User.dart' as U;

class GeneratedSocietyApartmentBillsController extends GetxController {
  var userdata = Get.arguments;

  late final U.User user;
  String? firstname;
  String? lastname;
  @override
  void onInit() {
    super.onInit();

    user = this.userdata;
  }

  generatedSocietyApartmentBillApi(int subadminid, String token) async {
    final response = await Http.get(
      Uri.parse(
          Api.generatedSocietyApartmentBill + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());
    print(response.body.toString());
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      return BillModel.fromJson(data);
    }
    return BillModel.fromJson(data);
  }
}

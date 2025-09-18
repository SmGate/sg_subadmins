import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

class GenerateSocietyApartmentBillsController extends GetxController {
  var userdata = Get.arguments;

  late final User user;
  int status = 0;

  bool isLoading = false;
  var residentList = [];

  @override
  void onInit() {
    super.onInit();
    print("init");
    user = this.userdata;
  }

  TextEditingController bill_start_date = TextEditingController();
  TextEditingController bill_end_date = TextEditingController();
  TextEditingController bill_due_date = TextEditingController();

  Future chooseBillStartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) {
      picked.toString();
      bill_start_date.text = picked.toString().split(' ')[0];

      update();
    } else {
      bill_start_date.clear();
      update();
    }
  }

  Future chooseBillEndDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) {
      picked.toString();
      bill_end_date.text = picked.toString().split(' ')[0];
      update();
    } else {
      bill_end_date.clear();
      update();
    }
  }

  Future chooseBillDueDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) {
      picked.toString();
      bill_due_date.text = picked.toString().split(' ')[0];
    } else {
      bill_due_date.clear();
      update();
    }
  }

  generateSocietyApartmentBillApi({
    required String billstartdate,
    required String billenddate,
    required String duedate,
    required int status,
    required String bearerToken,
    required int subadminid,
  }) async {
    isLoading = true;
    update();

    // Map<String, List<int>> results = {
    //   "residentlist": residentlists
    // };
    print("----");
    //
    // print(jsonEncode(results));
    final response = await Http.post(
      Uri.parse(Api.generateSocietyApartmentBill),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
      body: jsonEncode(<String, dynamic>{
        "subadminid": subadminid,
        // "residentlist":jsonEncode(results),
        "duedate": duedate,
        "billstartdate": billstartdate,
        "billenddate": billenddate,
        "status": status,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Bill Generated Successfully");

      Get.offNamed(generatedsocietyapartmentbills, arguments: user);
      isLoading = false;
      update();
    } else if (response.statusCode == 400) {
      Get.snackbar("WARNING",
          "A bill has already been generated for this user in this month");

      isLoading = false;
      update();
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());
      Get.snackbar("WARNING",
          (data['errors'] as List).map((e) => e.toString()).toString());

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
      print(response.body);
      Get.snackbar("Failed to generate Bill", "");
    }
  }
}

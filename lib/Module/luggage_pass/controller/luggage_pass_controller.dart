import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/luggage_pass/model/get_all_luggage_pass_model.dart';
import 'package:societyadminapp/Module/luggage_pass/model/update_luggage_pass_status_model.dart';
import 'package:societyadminapp/Module/luggage_pass/service/make_luggage_pass_service.dart';

import '../../../Model/User.dart';

class LuggagePassController extends GetxController {
  var data = Get.arguments;
  User userdata = User();

  TextEditingController luggadeDescription = TextEditingController();

  RxBool isLoading = false.obs;
  RxString error = "".obs;

  var updateLuggagePassModel = UpdateLuggagePassStatusModel();

  var getAllLuggagePassModel = GetAllLuggagePassModel();
  RxString errorGettingLuggagePass = "".obs;
  @override
  void onInit() {
    userdata = data;
    super.onInit();
  }

  Future<GetAllLuggagePassModel> getAllLuggagePassEntry({
    String? societyId,
  }) async {
    errorGettingLuggagePass.value = "";

    var res = await MakeLuggagePassService.getAllLuggagePass(
      societyId: societyId,
    );

    if (res is GetAllLuggagePassModel) {
      getAllLuggagePassModel = res;
      Get.snackbar("Message", getAllLuggagePassModel.message ?? "");
      return getAllLuggagePassModel;
    } else {
      errorGettingLuggagePass.value = res.toString();
      Get.snackbar("Error", errorGettingLuggagePass.value);
    }

    return getAllLuggagePassModel;
  }

  Future<void> updateLuggagePassStatus({
    String? passId,
  }) async {
    error.value = "";
    isLoading.value = true;

    var res =
        await MakeLuggagePassService.updateLuggagePassStatus(passId: passId);
    isLoading.value = false;
    if (res is UpdateLuggagePassStatusModel) {
      updateLuggagePassModel = res;

      Get.snackbar("Message", updateLuggagePassModel.message ?? "");
    } else {
      isLoading.value = false;
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }
}

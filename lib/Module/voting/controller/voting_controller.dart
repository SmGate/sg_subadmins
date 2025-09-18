import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Model/User.dart';

import 'package:societyadminapp/Module/voting/model/ganerate_poll_model.dart';
import 'package:societyadminapp/Module/voting/model/get_all_poll_model.dart';
import 'package:societyadminapp/Module/voting/service/poll_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

class VotingController extends GetxController {
  var user = Get.arguments;
  User? userdata;

  TextEditingController titleController = TextEditingController();
  TextEditingController endnoticedateController = TextEditingController();
  TextEditingController endnoticetimeController = TextEditingController();
  final TextEditingController optionController = TextEditingController();
  final List<String> options = [];
  final formKey = new GlobalKey<FormState>();
  RxInt isResonable = 0.obs;
  RxBool loading = false.obs;
  RxString radioSelectedOption = ''.obs;

  var generatePollModel = GeneratePollModel();
  var getAllPollModel = GetAllPollModel();
  RxString errorGeneratingPoll = "".obs;
  RxString errorGettingPoll = "".obs;

  @override
  void onInit() {
    userdata = user;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    optionController.dispose();
  }

  Future NoticeEndDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) picked.toString();
    endnoticedateController.text = picked.toString().split(' ')[0];

    update();
  }

  Future NoticeEndTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('timeee.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    endnoticetimeController.text = currentTime.toString().split(' ')[0].trim();

    update();
  }

  void generatePoll(
      {String? societyId,
      String? title,
      String? endDate,
      String? endTime,
      int? isResonable,
      String? subadminId,
      List<String>? options}) async {
    loading.value = true;
    errorGeneratingPoll.value = "";

    if (options?.length == 0) Get.snackbar("Error", "Add At Least 1 Options");
    var res = await GeneratePollService.generatePoll(
        societyId: societyId,
        title: title,
        endDate: endDate,
        endTime: endTime,
        isResonable: isResonable,
        options: options,
        subadminId: subadminId);

    loading.value = false;

    if (res is GeneratePollModel) {
      generatePollModel = res;
      Get.snackbar("Message", res.message ?? "");
      titleController.text = "";
      endnoticedateController.text = "";
      endnoticetimeController.text = "";
      optionController.text = "";
      options?.clear();
      Get.offNamed(voting, arguments: user);
    } else {
      loading.value = false;
      errorGeneratingPoll.value = res;
      Get.snackbar("Error", errorGeneratingPoll.value);
    }
  }

  void updateCheckbox(bool isChecked) {
    isResonable.value = isChecked ? 1 : 0;

    print(isResonable.value);
  }

  Future<GetAllPollModel> getAllPoll({
    String? societyId,
  }) async {
    var userId =
        userdata?.structureType == 6 ? userdata?.userid : societyId ?? 0;
    errorGettingPoll.value = "";
    var res =
        await GeneratePollService.getAllPoll(societyId: userId.toString());

    if (res is GetAllPollModel) {
      getAllPollModel = res;

      return getAllPollModel;
    } else {
      errorGettingPoll.value = res;
      Get.snackbar("Error", errorGettingPoll.value);
    }

    return getAllPollModel;
  }

  void selectOption(String option) {
    radioSelectedOption.value = option;

    print(radioSelectedOption.value);
  }
}

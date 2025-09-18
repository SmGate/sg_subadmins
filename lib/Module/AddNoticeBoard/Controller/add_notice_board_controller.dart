import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../Model/User.dart';

class AddNoticeBoardScreenController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  bool checkBoxValue = false;
  var user = Get.arguments;
  User? userdata;
  bool isLoading = false;
  int dateTimeVisibility = 0;
  @override
  void onInit() {
    super.onInit();
    userdata = user;
  }

  TextEditingController noticetitleController = TextEditingController();
  TextEditingController noticedescriptionController = TextEditingController();
  TextEditingController startnoticedateController = TextEditingController();
  TextEditingController endnoticedateController = TextEditingController();
  TextEditingController startnoticetimeController = TextEditingController();
  TextEditingController endnoticetimeController = TextEditingController();

  Future NoticeStartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) picked.toString();
    startnoticedateController.text = picked.toString().split(' ')[0];

    update();
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

  Future NoticeStartTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('timeee.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();
    startnoticetimeController.text =
        currentTime.toString().split(' ')[0].trim();

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

  addNoticeBoardApi({
    required String noticetitle,
    required String noticedes,
    required String startdate,
    required String enddate,
    required String starttime,
    required String endtime,
    required String bearerToken,
    required int subadminid,
    required int dateTimeVisibility,
  }) async {
    isLoading = true;
    update();
    final response = await Http.post(
      Uri.parse(Api.addNoticeboardDetail),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
      body: jsonEncode(<String, dynamic>{
        "noticetitle": noticetitle,
        "noticedetail": noticedes,
        "startdate": startdate,
        "enddate": enddate,
        "starttime": starttime,
        "endtime": endtime,
        "status": dateTimeVisibility,
        "subadminid": subadminid
      }),
    );

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      Get.offNamed(noticeboardscreen, arguments: user);

      myToast(msg: 'Notice Add Successfully');
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body.toString());
      (data['errors'] as List)
          .map((e) => myToast(
                msg: e.toString(),
              ))
          .toList();
    } else {
      isLoading = false;
      update();
      myToast(msg: 'Failed to Add Notice');
    }
  }

  setCheckBox(val) async {
    checkBoxValue = val;
    if (checkBoxValue == false) {
      dateTimeVisibility = 0;
    } else {
      dateTimeVisibility = 1;
    }
    print(dateTimeVisibility);
    update();
  }
}

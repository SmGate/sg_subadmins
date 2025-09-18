// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Services/Notification Services/notification_services.dart';
import '../Model/myapimodel.dart';

class HomeScreenController extends GetxController {
  late final User user;
  var userdata = Get.arguments;
  int count = 0;
  String countGreaterThanHundred = '99+';
  int inProgressReportCount = 0;
  int unVerifiedUserCount = 0;
  int emergencyCount = 0;
  PhasesList? selectedItem;

  @override
  void onInit() {
    super.onInit();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotification();
    notificationServices.fireBaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.getDeviceToken();
    user = userdata;
    getPendingReportsCount();
    getInProgressReportsCount();
    getUnverifiedResidentCount();
    getEmergencyCount();
  }

  getEmergencyCount() async {
    emergencyCount = (await emergencyCountApi(
            userId: user.userid!, token: user.bearerToken!)) ??
        0;
    update();
  }

  getPendingReportsCount() async {
    count = (await pendingReportsCountApi(
            userId: user.userid!, token: user.bearerToken!)) ??
        0;
    update();
  }

  getInProgressReportsCount() async {
    inProgressReportCount = (await inProgressReportsCountApi(
            userId: user.userid!, token: user.bearerToken!)) ??
        0;
    update();
  }

  getUnverifiedResidentCount() async {
    unVerifiedUserCount = (await unverifiedResidentCountApi(
            userId: user.userid!, token: user.bearerToken!)) ??
        0;
    update();
  }

  viewUnVerifiedResidentCountApi(
      {required int subadminid,
      required String token,
      required int status}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.unverifiedResidentCount.toString() +
          '/' +
          subadminid.toString() +
          '/' +
          status.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    print(data['data']);

    if (response.statusCode == 200) {
      return data['data'];
    }

    return data['data'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<int?> pendingReportsCountApi(
      {required int userId, required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.pendingReportsCount + "/" + userId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    try {
      if (response.statusCode == 200) {
        int count = 0;
        var data = jsonDecode(response.body);
        count = data['data'];

        return count;
      } else {
        myToast(msg: 'Something Went Wrong', isNegative: true);
      }
    } catch (e) {
      myToast(msg: 'Something Went Wrong $e', isNegative: true);
    }
  }

  Future<int?> inProgressReportsCountApi(
      {required int userId, required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.inProgressReportsCount + "/" + userId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    try {
      if (response.statusCode == 200) {
        int count = 0;
        var data = jsonDecode(response.body);
        count = data['data'];

        return count;
      } else {
        myToast(msg: 'Something Went Wrong', isNegative: true);
      }
    } catch (e) {
      myToast(msg: 'Something Went Wrong $e', isNegative: true);
    }
  }

  Future<int?> unverifiedResidentCountApi(
      {required int userId, required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.unverifiedResidentCount + "/" + userId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    try {
      if (response.statusCode == 200) {
        int count = 0;
        var data = jsonDecode(response.body);
        count = data['data'];

        return count;
      } else {
        myToast(msg: 'Something Went Wrong', isNegative: true);
      }
    } catch (e) {
      myToast(msg: 'Something Went Wrong $e', isNegative: true);
    }
  }

  Future<int?> emergencyCountApi(
      {required int userId, required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.emergencyCount + "/" + userId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    try {
      if (response.statusCode == 200) {
        int count = 0;
        var data = jsonDecode(response.body);
        count = data['data'];

        return count;
      } else {
        myToast(msg: 'Something Went Wrong', isNegative: true);
      }
    } catch (e) {
      myToast(msg: 'Something Went Wrong $e', isNegative: true);
    }
  }
}

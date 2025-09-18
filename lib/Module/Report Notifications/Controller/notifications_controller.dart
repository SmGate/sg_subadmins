import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/constants.dart';
import '../Model/Notification.dart';

class NotificationsController extends GetxController {
  var user = Get.arguments;
  TextEditingController rejectcontroller = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  var status = Status.completed;

  late final User userData;
  List<ReportNotification> li = [];

  @override
  void onInit() {
    super.onInit();

    userData = user;
    print(userData);
  }

  setStatus(Status status) {
    this.status = status;
    update();
  }

  Future<List<ReportNotification>> viewNotificationsApi(
      int subadminid, String token) async {
    final response = await Http.get(
      Uri.parse(Api.pendingReports + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      li = (data['data'] as List)
          .map(
            (e) => ReportNotification(
                address: e['address'],
                firstname: e['firstname'],
                lastname: e['lastname'],
                mobileno: e['mobileno'],
                id: e['id'],
                subadminid: e['subadminid'],
                userid: e['userid'],
                title: e['title'],
                description: e['description'],
                date: e['date'],
                status: e['status'],
                statusdescription: e['statusdescription'],
                created_at: e['created_at'],
                updated_at: e['updated_at']),
          )
          .toList();

      return li;
    }
    return li;
  }

  RejectButtonApi(
      int reportid, int userid, String statusdescription, String token) async {
    setStatus(Status.loading);

    final uri = Uri.parse(Api.updateReportStatus);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };
    Map<String, dynamic> body = {
      "id": reportid,
      "userid": userid,
      "status": 3,
      "statusdescription": statusdescription,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Http.Response response = await Http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      rejectcontroller.clear();

      myToast(msg: 'Report Rejected');

      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
  }

  AcceptButtonApi(int reportid, int userid, String token) async {
    setStatus(Status.loading);

    final uri = Uri.parse(Api.updateReportStatus);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };
    Map<String, dynamic> body = {
      "id": reportid,
      "userid": userid,
      "status": 2,
      "statusdescription": 'in progress',
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Http.Response response = await Http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    print(response.body);
    if (response.statusCode == 200) {
      myToast(msg: 'Report Accepted');

      setStatus(Status.completed);
    } else {
      setStatus(Status.error);
    }
  }
}

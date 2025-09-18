import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../Model/ResidentReports.dart';

class ResidentReportsController extends GetxController {
  var user = Get.arguments;
  var residentName;
  var residentId;
  var residentAddress;
  var residentMobileno;

  Uri? uri;

  late final User userdata;

  List<ResidentReports> li = [];

  @override
  void onInit() {
    super.onInit();
    userdata = this.user[0];
    residentId = user[1];
    residentName = user[2] + ' ' + user[3];
    residentAddress = user[4];
    residentMobileno = user[5];

    print("init ${residentId}");
  }

  Future<List<ResidentReports>> viewResidentsReportsApi(
      int subadminid, int residentid, String token) async {
    print("subadminiid.toString() ${subadminid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.reports +
          "/" +
          subadminid.toString() +
          "/" +
          residentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(data);
      li = (data['data'] as List)
          .map((e) => ResidentReports(
                id: e['id'],
                updatedAt: e['updated_at'],
                subadminid: e['subadminid'],
                userid: e['userid'],
                title: e['title'],
                description: e['description'],
                date: e['date'],
                status: e['status'],
                statusdescription: e['statusdescription'],
              ))
          .toList();

      return li;
    }
    return li;
  }
}

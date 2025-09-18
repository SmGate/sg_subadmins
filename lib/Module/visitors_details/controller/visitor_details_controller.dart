import 'dart:convert';

import 'package:get/get.dart';
import 'package:societyadminapp/Module/visitors_details/model/visitor_details_model.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Model/User.dart' as U;
import 'package:http/http.dart' as Http;

class VisitoreDetailsScreenController extends GetxController {
  var userdata = Get.arguments;
  late final U.User user;
  List<Datum> li = [];

  @override
  void onInit() {
    super.onInit();
    user = this.userdata;
    getVisitorsDetails(user.userid!, user.bearerToken ?? "");
  }

  getVisitorsDetails(int subAdminId, String token) async {
    print(subAdminId.toString());

    final response = await Http.get(
      Uri.parse(Api.getVisitorDetails + "/" + subAdminId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(data);
// Residents.fromJson(data);
      li = await (data['data'] as List)
          .map(
            (e) => Datum(
                id: e['id'],
                gatekeeperid: e['image'],
                societyid: e['gatekeeperid'],
                subadminid: e['subadminid'],
                houseaddress: e['houseaddress'],
                visitortype: e["visitortype"],
                name: e['name'],
                cnic: e['cnic'],
                mobileno: e['mobileno'],
                vechileno: e['vechileno'],
                arrivaldate: e['arrivaldate'].toString(),
                arrivaltime: e['arrivaltime'],
                //
                checkoutdate: e['checkoutdate'],
                checkouttime: e['checkouttime'],
                status: e['status'],
                statusdescription: e['statusdescription'],
                createdAt: e['createdAt'],
                updatedAt: e['updatedAt']),
          )
          .toList();

      return li;
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/Module/Finance%20Manger/View%20Finance%20Manager/Model/FinanceManagerModel.dart';

import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';
import '../../../../Widgets/my_button.dart';

class ViewFinanceManagerController extends GetxController {
  var userdata = Get.arguments;
  late final User user;
  var snapShotData;
  bool isDelete = false;

  @override
  void onInit() {
    super.onInit();

    user = userdata;
  }

  Future<FinanceManagerModel> financeManagerViewApi(
      {required subAdminId,
      required bearerToken,
      required BuildContext context}) async {
    final id = user.structureType == 6 ? subAdminId : user.societyid.toString();
    var response = await Http.get(
        Uri.parse(Api.financeManagerView + id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $bearerToken"
        });
    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else if (response.statusCode == 500) {
      showDialogBox(context, title: 'Error.', data: 'Server Error');
    } else {
      showDialogBox(context, title: 'Error.', data: 'Something Went Wrong');
    }
    return FinanceManagerModel.fromJson(data);
  }

  financeManagerDeleteApi(
      {required financeManagerId,
      required bearerToken,
      required BuildContext context}) async {
    var response = await Http.get(
        Uri.parse(Api.financeManagerDelete + financeManagerId.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $bearerToken"
        });

    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());

      await financeManagerViewApi(
          subAdminId: user.userid,
          bearerToken: user.bearerToken,
          context: context);

      update();
    } else if (response.statusCode == 500) {
      myToast(msg: 'Server Error');
    } else if (response.statusCode == 403) {
      data = jsonDecode(response.body.toString());

      myToast(msg: data.toString());
    } else {
      myToast(msg: 'Something Went Wrong');
    }
  }

  void showDialogBox(BuildContext context, {required title, required data}) {
    Get.defaultDialog(
        title: title,
        titleStyle: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: HexColor('#4D4D4D')),
        content: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              data,
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: HexColor('#DC3545')),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
              onPressed: () {
                Get.back();
              },
              name: 'OK',
              width: 100,
              height: 30,
            ),
          ],
        ));
  }
}

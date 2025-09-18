import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/all_residens_model.dart';
import 'package:societyadminapp/Module/View%20Residents/service/all_resident_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Model/User.dart';
import '../../../Widgets/my_button.dart';

import '../Model/Resident.dart';

class ViewResidentController extends GetxController {
  var user = Get.arguments;

  User userdata = User();
  var residentid = 0.obs;
  var token = "".obs;
  var pageSize = 10;
  RxString error = "".obs;
  List<Datum> residentRecordList = [];
  var allResidentModel = AllResidentModel();

  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);
  @override
  void onInit() {
    super.onInit();
    print("init");
    userdata = this.user;

    pagingController.addPageRequestListener((pageKey) {
      viewResidentsApi(
          pageKey: pageKey,
          limit: pageSize,
          subAdminId: userdata.structureType == 6
              ? userdata.userid.toString()
              : userdata.societyid.toString());
    });
  }

  viewResidentsApi({
    String? subAdminId,
    int? pageKey,
    int? limit,
  }) async {
    print("this method call");
    error.value = "";

    var res = await AllResidentSerVice.getAllResidentList(
      subadminId: subAdminId,
      pageKey: pageKey,
      limit: limit,
    );

    if (res is AllResidentModel) {
      allResidentModel = res;
      residentRecordList = allResidentModel.data?.data ?? [];

      final isLastPage = residentRecordList.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(residentRecordList);
      } else {
        final nextPageKey = pageKey! + 1;
        pagingController.appendPage(residentRecordList, nextPageKey);
      }
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

  searchResidentsApi(int subadminiid, String token, String query) async {
    print("Search Resident Api Hits");
    print(subadminiid.toString());
    print(token);
    print(query);

    final response = await Http.get(
      Uri.parse(Api.searchResidents +
          "/" +
          subadminiid.toString() +
          "/" +
          query.toString()),
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
      final List<Resident> li = await (data['residentslist'] as List)
          .map(
            (e) => Resident(
                firstname: e['firstname'],
                image: e['image'],
                password: e['password'],
                id: e['id'],
                address: e['address'],
                committeemember: e["committeemember"],
                cnic: e['cnic'],
                lastname: e['lastname'],
                mobileno: e['mobileno'],
                owneraddress: e['owneraddress'],
                ownermobileno: e['ownermobileno'],
                ownername: e['ownername'],
                //
                propertytype: e['propertytype'],
                residentid: e['residentid'],
                residenttype: e['residenttype'],
                roleid: e['roleid'],
                rolename: e['rolename'],
                subadminid: e['subadminid'],
                vechileno: e['vechileno'],
                created_at: e['created_at'],
                updated_at: e['updated_at']),
          )
          .toList();

      return li;
    }
  }

  DeleteResidentsApi(int residentid, String token) async {
    print(residentid);
    print(token);

    final response = await Http.get(
      Uri.parse(Api.deleteResident + "/" + residentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());
    var mydata = data['data'];

    if (response.statusCode == 200) {
      print(mydata);

      Get.toNamed(viewuser, arguments: user);

      update();
    } else {}
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Delete'),
              content: const Text('Do you want to delete this Admin?'),
              actions: <Widget>[
                MyButton(
                  onPressed: () async {
                    await DeleteResidentsApi(residentid.value, token.value);
                  },
                  name: 'delete',
                  color: primaryColor,
                  maxLines: 1,
                ),
                MyButton(
                  onPressed: () {
                    Get.back();
                  },
                  maxLines: 1,
                  name: 'cancel',
                  textColor: Colors.white60,
                  color: primaryColor,
                ),
              ],
            ));
  }
}

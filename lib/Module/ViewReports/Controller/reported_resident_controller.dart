// ignore_for_file: unnecessary_this
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/ViewReports/Model/get_all_complaints_model.dart';

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../Model/ReportedResident.dart';

class ResidentsListController extends GetxController {
  var user = Get.arguments;
  late final User userdata;

  List<ReportedResident> li = [];
  var currentGateKeeperId;
  var currentToekn;

  @override
  void onInit() {
    super.onInit();
    userdata = this.user;
    viewResidentsApi(userdata.userid!, userdata.bearerToken!);
  }

  //========================================
  // BY-RESIDENT (unchanged)
  //========================================
  Future<List<ReportedResident>> viewResidentsApi(
      int subadminid, String token) async {
    var finalId = userdata.structureType == 6
        ? subadminid
        : userdata.societyid.toString();

    final response = await Http.get(
      Uri.parse('${Api.reportedResidents}/$finalId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      li = (data['data'] as List)
          .map((e) => ReportedResident(
                firstname: e['firstname'],
                lastname: e['lastname'],
                image: e['image'],
                id: e['id'],
                address: e['address'],
                cnic: e['cnic'],
                mobileno: e['mobileno'],
                roleid: e['roleid'],
                rolename: e['rolename'],
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

  //========================================
  // ALL COMPLAINTS (no pagination, only filter)
  //========================================
  List<ComplaintData> allComplaints = [];
  bool allIsLoading = false;
  String? allError;

  /// 'pending' | 'in progress' | 'completed' | null (for all)
  String? selectedStatusText;

  Future<void> setAllStatusAndReload(String? statusText) async {
    selectedStatusText = (statusText == null || statusText.trim().isEmpty)
        ? null
        : statusText.trim().toLowerCase();

    await fetchAllComplaints(
      subadminId: _resolveAllReportsOwnerId(),
      token: userdata.bearerToken ?? '',
    );
  }

  Future<void> fetchAllComplaints({
    required int subadminId,
    required String token,
  }) async {
    allComplaints.clear();
    allError = null;
    allIsLoading = true;
    update(['all']);

    try {
      final uri = _buildAllUri(subadminId: subadminId);
      final res = await Http.get(
        uri,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        final map = jsonDecode(res.body) as Map<String, dynamic>;
        final parsed = GetAllComplaint.fromJson(map);
        allComplaints = parsed.data ?? <ComplaintData>[];
        allError = null;
      } else {
        allError = 'HTTP ${res.statusCode}';
      }
    } catch (e) {
      allError = e.toString();
    } finally {
      allIsLoading = false;
      update(['all']);
    }
  }

  //======= internals
  int _resolveAllReportsOwnerId() {
    return userdata.subadminid ?? userdata.userid ?? 0;
  }

  Uri _buildAllUri({required int subadminId}) {
    // {{base_url}}/get-all-reports/{subadminId}?status=in progress
    final base = '${Api.getAllReports}/$subadminId';
    final params = <String, String>{};
    if (selectedStatusText != null && selectedStatusText!.isNotEmpty) {
      params['status'] = selectedStatusText!;
    }
    return Uri.parse(base).replace(queryParameters: params);
  }
}

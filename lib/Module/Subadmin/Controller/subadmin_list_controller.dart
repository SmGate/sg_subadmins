import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Model/User.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';

class SubadminListController extends GetxController {
  bool isLoading = false;
  bool isSubmitting = false;
  String? errorMessage;
  List<Map<String, dynamic>> subadmins = [];
  List<Map<String, dynamic>> buildings = [];
  int? selectedBuildingId;
  final User? user;

  SubadminListController({this.user});

  @override
  void onInit() {
    super.onInit();
    fetchSubadmins();
  }

  Future<void> fetchSubadmins() async {
    debugPrint('fetchSubadmins');
    if (user == null || user!.societyid == null) {
      errorMessage = 'Missing user/society ID';
      update();
      return;
    }

    isLoading = true;
    errorMessage = null;
    update();

    try {
      final uri = Uri.parse('${Api.getAllAdmins}/${user!.societyid}');
      debugPrint('GET URL -> $uri');
      final response = await Http.get(
        uri,
        headers: <String, String>{
          'Accept': 'application/json',
          if (user!.bearerToken != null) 'Authorization': 'Bearer ${user!.bearerToken}',
        },
      );
      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = (body['data'] is List) ? body['data'] as List : <dynamic>[];
        final all = data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
        // Exclude the logged-in subadmin from the list
        final int? currentSubadminId = user!.userid;
        subadmins = all.where((item) {
          final int? itemSubId = (item['subadminid'] as num?)?.toInt() ?? (item['id'] as num?)?.toInt();
          if (currentSubadminId == null) return true;
          return itemSubId != currentSubadminId;
        }).toList();
        isLoading = false;
        update();
        return;
      }

      errorMessage = '(${response.statusCode}) Failed to load subadmins';
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('fetchSubadmins error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchBuildings() async {
    if (user == null || user!.societyid == null) return;
    try {
      final uri = Uri.parse('${Api.getBuildings}/${user!.societyid}');
      debugPrint('GET URL -> $uri');
      final response = await Http.get(
        uri,
        headers: <String, String>{
          'Accept': 'application/json',
          if (user!.bearerToken != null) 'Authorization': 'Bearer ${user!.bearerToken}',
        },
      );
      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = (body['data'] is List) ? body['data'] as List : <dynamic>[];
        buildings = data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
        update();
      }
    } catch (e) {
      debugPrint('fetchBuildings error: $e');
    }
  }

  Future<void> assignBuildingToSubadmin({required int subadminId, required int buildingId}) async {
 
    Get.snackbar('Assigned', 'Building $buildingId assigned to subadmin $subadminId');
  }

  Future<void> addSubadmin({
    required String firstname,
    required String lastname,
    required String cnic,
    required String password,
    required String mobileno,
    required String email,
      required String address,
  }) async {
    if (user == null || user!.societyid == null || user!.superadminid == null) {
      Get.snackbar('Error', 'Missing user identifiers');
      return;
    }

    isSubmitting = true;
    update();

    try {
      final uri = Uri.parse(Api.addSubadmin);
      final response = await Http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (user!.bearerToken != null)
            'Authorization': 'Bearer ${user!.bearerToken}',
        },
        body: jsonEncode(<String, dynamic>{
          'firstname': firstname,
          'lastname': lastname,
          'cnic': cnic,
          'password': password,
          'mobileno': mobileno,
          'email': email,
          'superadminid': user!.superadminid,
          'societyid': user!.societyid,
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        Get.back();
        await fetchSubadmins();
        Get.snackbar('Success', body['message']?.toString() ?? 'Subadmin added');
        return;
      }

      Get.snackbar('Error', '(${response.statusCode}) Failed to add subadmin');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSubmitting = false;
      update();
    }
  }
}



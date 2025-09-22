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
  bool isBuildingsLoading = false;
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
    await fetchBuildingsForSociety(user!.societyid!);
  }

  Future<void> fetchBuildingsForSociety(int societyId) async {
    isBuildingsLoading = true;
    buildings = [];
    update();
    try {
      final uri = Uri.parse('${Api.getBuildings}/$societyId');
      debugPrint('GET URL -> $uri');
      final response = await Http.get(
        uri,
        headers: <String, String>{
          'Accept': 'application/json',
          if (user?.bearerToken != null) 'Authorization': 'Bearer ${user!.bearerToken}',
        },
      );
      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = (body['data'] is List) ? body['data'] as List : <dynamic>[];
        buildings = data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
    } catch (e) {
      debugPrint('fetchBuildingsForSociety error: $e');
    } finally {
      isBuildingsLoading = false;
      update();
    }
  }

  Future<String?> assignBuildingToSubadmin({required int subadminId, required int buildingId}) async {
    try {
      isSubmitting = true;
      update();
      final uri = Uri.parse(Api.assignBuilding);
      final Map<String, dynamic> payload = <String, dynamic>{
        'building_id': buildingId,
        'subadminid': subadminId,
      };

      debugPrint('POST URL -> $uri');
      debugPrint('Request Body -> ${jsonEncode(payload)}');

      final response = await Http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (user?.bearerToken != null) 'Authorization': 'Bearer ${user!.bearerToken}',
        },
        body: jsonEncode(payload),
      );
      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final String message = body['message']?.toString() ?? 'Building Assigned Successfully';
        return message;
      } else {
        String message = '(${response.statusCode}) Failed to assign building';
        try {
          final Map<String, dynamic> err = jsonDecode(response.body);
          if (err['message'] != null) message = err['message'].toString();
        } catch (_) {}
        Get.snackbar('Error', message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSubmitting = false;
      update();
    }
    return null;
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
      final Map<String, dynamic> payload = <String, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'cnic': cnic,
        'password': password,
        'mobileno': mobileno,
        'email': email,
        'superadminid': user!.superadminid,
        'societyid': user!.societyid,
        'address': address,
      };

      debugPrint('POST URL -> $uri');
      debugPrint('Request Body -> ${jsonEncode(payload)}');

      final response = await Http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (user!.bearerToken != null)
            'Authorization': 'Bearer ${user!.bearerToken}',
        },
        body: jsonEncode(payload),
      );

      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        Get.back();
        await fetchSubadmins();
        Get.snackbar('Success', body['message']?.toString() ?? 'Subadmin added');
        return;
      } else {
        String message = '(${response.statusCode}) Failed to add subadmin';
        try {
          final Map<String, dynamic> err = jsonDecode(response.body);
          if (err['message'] != null) {
            message = err['message'].toString();
          } else if (err['errors'] != null) {
            final errors = err['errors'];
            if (errors is Map) {
              final parts = <String>[];
              errors.forEach((k, v) {
                if (v is List && v.isNotEmpty) {
                  parts.add(v.first.toString());
                } else if (v != null) {
                  parts.add(v.toString());
                }
              });
              if (parts.isNotEmpty) message = parts.join('\n');
            } else {
              message = errors.toString();
            }
          }
        } catch (_) {}
        Get.snackbar('Error', message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSubmitting = false;
      update();
    }
  }

  Future<String?> updateSubadmin({
    required int subadminId,
    required String firstname,
    required String lastname,
    required String cnic,
    required String password,
    required String mobileno,
    required String address,
    String? email,
  }) async {
    if (user == null || user!.societyid == null || user!.superadminid == null) {
      Get.snackbar('Error', 'Missing user identifiers');
      return null;
    }

    isSubmitting = true;
    update();

    try {
      final uri = Uri.parse(Api.updateSubadmin);
      final request = Http.MultipartRequest('POST', uri);
      request.headers['Accept'] = 'application/json';
      if (user!.bearerToken != null) {
        request.headers['Authorization'] = 'Bearer ${user!.bearerToken}';
      }

      request.fields['cnic'] = cnic;
      request.fields['password'] = password;
      request.fields['firstname'] = firstname;
      request.fields['lastname'] = lastname;
      request.fields['address'] = address;
      request.fields['mobileno'] = mobileno;
      request.fields['superadminid'] = user!.superadminid.toString();
      request.fields['societyid'] = user!.societyid.toString();
      request.fields['subadminid'] = subadminId.toString();
      if (email != null && email.trim().isNotEmpty) {
        request.fields['email'] = email.trim();
      }

      debugPrint('POST URL -> $uri');
      debugPrint('Request (multipart fields) -> ${request.fields}');

      final streamed = await request.send();
      final response = await Http.Response.fromStream(streamed);
      debugPrint('Status -> ${response.statusCode}');
      debugPrint('Response -> ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final String message = body['message']?.toString() ?? 'Manager Updated Successfully';
        return message;
      } else {
        String message = '(${response.statusCode}) Failed to update subadmin';
        try {
          final Map<String, dynamic> err = jsonDecode(response.body);
          if (err['message'] != null) message = err['message'].toString();
        } catch (_) {}
        Get.snackbar('Error', message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSubmitting = false;
      update();
    }
    return null;
  }
}



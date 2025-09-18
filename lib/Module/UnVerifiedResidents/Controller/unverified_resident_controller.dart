import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/Resident%20Model/ApartmentResidentModel.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/Resident%20Model/HouseResident.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/reject_resident_verification_model.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/Resident Model/LocalBuildingApartmentResidentModel.dart';

class UnVerifiedResidentController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  Map<int, List<dynamic>> cache = {};

  @override
  void onInit() {
    super.onInit();
    userdata = this.user;
  }

  Future<HouseResident> viewUnVerifiedResidentApi(
      {required int subadminid,
      required String token,
      required int status}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.unverifiedHouseResident.toString() +
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

    print(
      Uri.parse(Api.unverifiedHouseResident.toString() +
          '/' +
          subadminid.toString() +
          '/' +
          status.toString()),
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return HouseResident.fromJson(data);
    }

    return HouseResident.fromJson(data);
  }

  Future<ApartmentResidentModel> viewUnVerifiedApartmentResidentApi(
      {required int subadminid,
      required String token,
      required int status}) async {
    print(token);
    var finalId = userdata.structureType == 6
        ? subadminid
        : userdata.societyid.toString();
    final response = await Http.get(
      Uri.parse(Api.unverifiedApartmentResident.toString() +
          '/' +
          finalId.toString() +
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

    if (response.statusCode == 200) {
      return ApartmentResidentModel.fromJson(data);
    }

    return ApartmentResidentModel.fromJson(data);
  }

  Future<LocalBuildingApartmentResidentModel>
      viewUnVerifiedLocalBuildingApartmentResidentApi(
          {required int subadminid,
          required String token,
          required int status}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.unverifiedLocalBuildingApartmentResident.toString() +
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

    if (response.statusCode == 200) {
      return LocalBuildingApartmentResidentModel.fromJson(data);
    }

    return LocalBuildingApartmentResidentModel.fromJson(data);
  }

  List<dynamic>? getCachedUnverifiedResidentData(
      int subadminid, String token, int tabIndex) {
    final cacheKey = _generateCacheKey(subadminid, token, tabIndex);
    return cache[cacheKey];
  }

  void cacheUnverifiedResidentData(List<dynamic> data, int tabIndex) {
    final cacheKey =
        _generateCacheKey(userdata.userid!, userdata.bearerToken!, tabIndex);
    cache[cacheKey] = data;
  }

  int _generateCacheKey(int subadminid, String token, int tabIndex) {
    final key = '$subadminid-$token-$tabIndex';
    return key.hashCode;
  }

  ////
  Future<void> rejectResidentVerification({
    required String token,
    required int residentId,
    required String reason,
  }) async {
    final uri = Uri.parse(Api.rejectVerification.toString());
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'residentid': residentId, 
      'reason': reason,
    });

    final response = await Http.post(uri, headers: headers, body: body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Reject verification failed '
          '(${response.statusCode}): ${response.body}');
    }

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map) {
        final parsed = RejectResidentVerification.fromJson(
          Map<String, dynamic>.from(decoded),
        );
        if (parsed.success == false) {
          throw Exception('Reject verification not accepted by server.');
        }
      }
    } catch (_) {}
  }
}

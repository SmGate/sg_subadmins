import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/ShortTermRental/model/add_shortterm_rental_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_all_shortterm_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_apartments_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_floors_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_society_buildings_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/rentSettlement_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class AddShortTermRentalService {
  static Future<dynamic> addShortTermRental({
    required String guestName,
    required String guestPhone,
    required String guestCnic,
    required File cnicPhoto,
    required String checkInDate,
    required String checkOutDate,
    required String totalPrice,
    required String description,
    required String vehicleNumber,
    required String apartmentId,
    required String buildingId,
    required String societyId,
    required String token,
    required String subAdminId,
  }) async {
    try {
      var url = Uri.parse(Api.addShortTermRental);

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      /// Add file
      request.files.add(
        await http.MultipartFile.fromPath('cnic_photo', cnicPhoto.path),
      );

      /// Add fields
      request.fields['guest_name'] = guestName;
      request.fields['guest_phone'] = guestPhone;
      request.fields['guest_cnic'] = guestCnic;
      request.fields['check_in_date'] = checkInDate;
      request.fields['check_out_date'] = checkOutDate;
      request.fields['total_price'] = totalPrice;
      request.fields['description'] = description;
      request.fields['vehicle_number'] = vehicleNumber;
      request.fields['appartment_id'] = apartmentId;
      request.fields['building_id'] = buildingId;
      request.fields['society_id'] = societyId;
      request.fields['subadminid'] = subAdminId;

      /// Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      /// Print the response body
      print('Response Body: ${response.body}');

      /// Decode response
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return addShortTermRentalModelFromJson(response.body);
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 409 ||
          response.statusCode == 500) {
        return responseData['message'] ?? 'An error occurred';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// ===========================

  static Future<dynamic> getSocietyBuildings({required int subadminId}) async {
    try {
      var url = "${Api.getSocietyBuildings}/$subadminId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getSocietyBuildingsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getBuilDIngFloors({required int buildingId}) async {
    try {
      var url = "${Api.getBuildingsFloor}/$buildingId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getBuildingFloorsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  /// ==============================

  static Future<dynamic> getBuilDIngFloorsApartment(
      {required int floorId}) async {
    try {
      var url = "${Api.getBuildingApartments}/$floorId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getBuildingApartmentsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  /// ==============================

  static Future<dynamic> getAllShortTermRental() async {
    try {
      var url = "${Api.getAllShortTermRental}";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allShortTermRentalModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> rentSettlement(
      {String? apartmentId,
      String? monthlyRent,
      String? anualIncrement,
      String? startDate,
      String? residentId}) async {
    try {
      Map data = {
        "appartment_id": apartmentId,
        "monthly_rent": monthlyRent,
        "annual_increment": anualIncrement,
        "start_date": startDate,
        "resident_id": residentId,
      };
      var url = "${Api.rentSettlement}";

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return rentSettlementModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

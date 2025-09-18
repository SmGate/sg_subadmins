import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/parking%20managment/model/add_parking_model.dart';
import 'package:societyadminapp/Module/parking%20managment/model/assign_parking_model.dart';
import 'package:societyadminapp/Module/parking%20managment/model/get_area_slots_model.dart';
import 'package:societyadminapp/Module/parking%20managment/model/update_parking_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class ParkingManagmentService {
  static Future<dynamic> addparking({
    String? societyId,
    String? parkingAreaName,
    String? totalSlots,
    String? subadmin,
  }) async {
    try {
      var url = "${Api.createParking}";
      Map data = {
        "society_id": societyId,
        "name": parkingAreaName,
        "total_slots": totalSlots,
        "subadminid": subadmin
      };

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return addParkingModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getParkingSlots(
      {String? societyId, String? area, String? status}) async {
    try {
      var url = "${Api.getParkingSlots}/$societyId?area=$area&status=$status";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAreaAndSlotsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> assignparking({
    String? slotId,
    String? residentId,
    String? starDate,
  }) async {
    try {
      var url = "${Api.assignParking}";
      Map data = {
        "slot_id": slotId,
        "resident_id": residentId,
        "start_date": starDate,
      };

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return assignParkingModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateParking({
    String? slotId,
    String? residentId,
    String? status,
  }) async {
    try {
      var url = "${Api.updateParking}/$slotId";
      Map data = {
        "resident_id": residentId,
        "status": status,
      };

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return updateParkingModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

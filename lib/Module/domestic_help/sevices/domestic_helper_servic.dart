import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/domestic_help/model/all_bookings_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/delete_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/domestic_helper_profile.dart';
import 'package:societyadminapp/Module/domestic_help/model/get_all_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/register_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/update_domestic_helper.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class DomesticHelperService {
  static Future<dynamic> registerDomesticHelper({
    String? societyId,
    String? name,
    String? phone,
    String? cnic,
    String? age,
    String? address,
    String? occupation,
    bool? avialble,
    String? visitingFee,
    String? subadminId,
  }) async {
    try {
      Map data = {
        "society_id": societyId,
        "name": name,
        "phone": phone,
        "cnic": cnic,
        "age": age,
        "address": address,
        "occupation": occupation,
        "avialble": avialble,
        "visiting_fee": visitingFee,
        "subadminid": subadminId
      };
      var url = "${Api.registerDomesticHelper}";

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return registerDomesticHelperModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateDomesticHelper({
    String? societyId,
    String? name,
    String? phone,
    String? cnic,
    String? age,
    String? address,
    String? occupation,
    String? visitingFee,
    String? workerId,
    bool? avialble,
  }) async {
    try {
      Map data = {
        "name": name,
        "phone": phone,
        "cnic": cnic,
        "age": age,
        "address": address,
        "occupation": occupation,
        "available": avialble,
        "visiting_fee": visitingFee
      };
      var url = "${Api.updateDomesticHelper}/$workerId";

      var res = await BaseClientClass.put(url, data);

      if (res is http.Response) {
        return updateDomesticHelperModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> deleteDomesticHelper({
    String? workerId,
  }) async {
    try {
      var url = "${Api.deleteDomesticHelper}/$workerId";

      var res = await BaseClientClass.delete(url);

      if (res is http.Response) {
        return deleteDomesticHelperModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllDomesticHelper({
    int? societyId,
    String? occupation,
    int? isAvaiable,
  }) async {
    try {
      var url =
          "${Api.getAllWorkers}?society_id=$societyId&occupation=$occupation&available=$isAvaiable";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllDomesticHelperModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllDomesticHelperProfile({
    String? workerId,
  }) async {
    try {
      var url = "${Api.domesticHelperProfile}/$workerId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return domesticHelperProfileModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllBookings({
    String? societyID,
  }) async {
    try {
      var url = "${Api.allBookings}?society_id=$societyID";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allBookingsModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }
}

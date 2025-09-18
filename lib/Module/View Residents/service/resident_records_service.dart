import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/View%20Residents/Model/resident_bills_model.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_complaint_model.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_emergency_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class ResidentRecordsService {
  static Future<dynamic> getAllResidentEmergenciese(
      {String? residetId, String? startDate, String? endDate}) async {
    try {
      var url =
          "${Api.residentDetails}/$residetId/emergencies?&start_date=$startDate&end_date=$endDate";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return residentEmergencyModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllResidenComplaint(
      {String? residetId, String? startDate, String? endDate}) async {
    try {
      var url =
          "${Api.residentDetails}/$residetId/complains?&start_date=$startDate&end_date=$endDate";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return residentComplaintModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllResidentBills(
      {String? residetId, String? startDate, String? endDate}) async {
    try {
      var url =
          "${Api.residentDetails}/$residetId/bills?&start_date=$startDate&end_date=$endDate";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return residentBillsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

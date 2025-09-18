import 'package:societyadminapp/Module/View%20Residents/Model/all_residens_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AllResidentSerVice {
  static Future<dynamic> getAllResidentList(
      {String? subadminId, int? pageKey, int? limit}) async {
    try {
      var url = "${Api.viewResidents}/$subadminId?&page=$pageKey&length=$limit";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allResidentModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

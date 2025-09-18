import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/luggage_pass/model/get_all_luggage_pass_model.dart';
import 'package:societyadminapp/Module/luggage_pass/model/update_luggage_pass_status_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class MakeLuggagePassService {
  static Future<dynamic> getAllLuggagePass({
    String? societyId,
  }) async {
    try {
      var url = "${Api.getAllLuggagePass}/$societyId";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllLuggagePassModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateLuggagePassStatus({
    String? passId,
  }) async {
    try {
      var url = "${Api.approvedLuggagePass}/$passId";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return updateLuggagePassStatusModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

import 'package:societyadminapp/Module/voting/model/ganerate_poll_model.dart';
import 'package:societyadminapp/Module/voting/model/get_all_poll_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class GeneratePollService {
  static Future<dynamic> generatePoll({
    String? societyId,
    String? title,
    String? endDate,
    String? endTime,
    int? isResonable,
    List<String>? options,
    String? subadminId,
  }) async {
    try {
      var url = "${Api.generatePoll}";

      Map data = {
        "society_id": societyId,
        "title": title,
        "end_date": endDate,
        "end_time": endTime,
        "is_resonable": isResonable,
        "options": options,
        "subadminid": subadminId
      };
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return generatePollModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAllPoll({
    String? societyId,
  }) async {
    try {
      var url = "${Api.getAllPoll}/$societyId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllPollModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

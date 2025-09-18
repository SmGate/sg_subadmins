import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

import '../model/visitors_logs_model.dart';

class VisitorsLogsService {
  static Future<dynamic> getVisitorsLogs({
    String? societyId,
    int? page,
    int? limit,
  }) async {
    try {
      var url = "${Api.getVisitorsLogs}/$societyId?page=$page&length=$limit";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return visitorsLogsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

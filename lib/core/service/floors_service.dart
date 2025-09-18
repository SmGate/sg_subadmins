import 'package:http/http.dart' as http;
import 'package:societyadminapp/core/models/add_floors_model.dart';
import 'package:societyadminapp/core/models/get_all_floors_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class AddFloorsService {
  static Future<dynamic> addFloors({
    String? buildingId,
    String? name,
    String? category,
    String? from,
    String? to,
  }) async {
    try {
      var url = Api.addFloorsUpdated;

      // Prepare the request body
      Map<String, dynamic> body = {
        "buildingid": buildingId,
        "name": name,
        "category": category,
        "from": from,
        "to": to,
      };

      // Make POST request
      var res = await BaseClientClass.post(url, body);

      if (res is http.Response) {
        return floorResponseFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getBuilDIngFloors({required int buildingId}) async {
    try {
      var url = "${Api.getAllFoors}/$buildingId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllFloorsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

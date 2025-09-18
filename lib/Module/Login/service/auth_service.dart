import 'package:societyadminapp/Module/Login/Model/delete_user_account_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<dynamic> deleteUserAccount({String? userId}) async {
    try {
      Map data = {"user_id": userId};
      var url = "${Api.deleteAccount}";
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return deleteAccountModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e.toString();
    }
  }
}

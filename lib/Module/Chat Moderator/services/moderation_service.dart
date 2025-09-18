import 'package:societyadminapp/Module/Chat%20Moderator/model/blocked_residents_model.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/model/make_moderator_model.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/model/residents_model.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/model/unblocke_resident_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class ModerationService {
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

  static Future<dynamic> makeModerator(
      {String? society_id, List? residentIds}) async {
    try {
      Map data = {"society_id": society_id, "resident_ids": residentIds};
      var url = Api.makeModerator;
      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return makeModeratorModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  /////// get all bloc user in chat

  static Future<dynamic> getAllBlockedUserList(
      {String? societyId, int? pageKey, int? limit}) async {
    try {
      var url =
          "${Api.blockedResidents}/$societyId?&page=$pageKey&length=$limit";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return blockedResidentsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  ///////  unblock residents
  static Future<dynamic> unBlockResident({String? residentId}) async {
    try {
      var url = "${Api.unblockResidents}/$residentId";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return unBlockResidentsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

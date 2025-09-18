import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/support_ticket/model/all_ticker_model.dart';
import 'package:societyadminapp/Module/support_ticket/model/ticket_status_update.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class SupportTicketsService {
  static Future<dynamic> getAllTickets({required String societyId}) async {
    try {
      var url = "${Api.getAllTickets}/$societyId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllTicketsFromjson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updateTicket(
      {required String status, required int ticketId}) async {
    try {
      Map data = {"status": status};
      var url = "${Api.updateTickets}/$ticketId";

      var res = await BaseClientClass.put(url, data);

      if (res is http.Response) {
        return ticketStatusUpdateFromjson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

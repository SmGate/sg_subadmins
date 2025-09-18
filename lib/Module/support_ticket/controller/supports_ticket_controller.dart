import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/support_ticket/model/all_ticker_model.dart';
import 'package:societyadminapp/Module/support_ticket/model/ticket_status_update.dart';
import 'package:societyadminapp/Module/support_ticket/service/support_tickets_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../../Model/User.dart';

class SupportTiccketsController extends GetxController {
  var userdata = Get.arguments;
  late final User user;

  @override
  void onInit() {
    super.onInit();

    user = userdata;
  }

  RxBool loading1 = false.obs;
  var error1 = "";
  var getAllTickets = GetAllTicketsModel();

  RxBool loading = false.obs;
  var error = "";
  var updateAllTickets = TicketStatusUpdate();

  Future<GetAllTicketsModel?> getAllTicketsMeth(
      {required String societyId}) async {
    var fibalID = user.structureType == 6 ? user.userid ?? 0 : societyId;
    try {
      loading1.value = true;
      error1 = "";

      var res = await SupportTicketsService.getAllTickets(
          societyId: fibalID.toString());

      if (res is GetAllTicketsModel) {
        getAllTickets = res;
        return res;
      } else {
        error1 = res;
        Get.snackbar("Message", error1);
        return null;
      }
    } finally {
      loading1.value = false;
    }
  }

  //==================================

  Future<void> updateTicket(
      {required String status,
      required int ticketId,
      BuildContext? context}) async {
    try {
      loading.value = true;
      error = "";

      var res = await SupportTicketsService.updateTicket(
          status: status, ticketId: ticketId);

      if (res is TicketStatusUpdate) {
        updateAllTickets = res;
        Navigator.of(context!).pop();

        Get.offNamed(homescreen, arguments: user);
      } else {
        error = res;
        Get.snackbar("Message", error);
        return null;
      }
    } finally {
      loading.value = false;
    }
  }
}

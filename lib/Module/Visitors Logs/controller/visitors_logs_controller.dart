// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/User.dart';
import '../model/visitors_logs_model.dart';
import '../service/visitors_logs_service.dart';

class VisitorsLogsController extends GetxController {
  ScrollController scrollController = ScrollController();
  var user = Get.arguments;
  late final User userdata;
  var isLoading = false.obs;
  bool hasMoreData = true;
  var visitorsLogsModel = VisitorsLogsModel();
  RxString error = "".obs;
  RxList<Datum>? visitorsList = <Datum>[].obs;
  RxString searchValue = "".obs;
  int page = 1;
  int limit = 10;

  @override
  void onInit() {
    userdata = user;
    super.onInit();

    getVisitorsLogs(
        societyId: userdata.structureType == 6
            ? userdata.subadminid.toString()
            : userdata.societyid.toString(),
        page: page,
        limit: limit);
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> getVisitorsLogs({
    String? societyId,
    int? page,
    int? limit,
  }) async {
    if (isLoading.value || !hasMoreData) return; 

    error.value = "";
    isLoading.value = true;

    var res = await VisitorsLogsService.getVisitorsLogs(
      societyId: societyId,
      page: page,
      limit: limit,
    );

    isLoading.value = false;

    if (res is VisitorsLogsModel) {
      List<Datum> newData = res.data?.data ?? [];

      if (newData.isNotEmpty) {
        visitorsList?.addAll(newData);

        if (newData.length < (limit ?? 0)) {
          hasMoreData = false;
        }
      } else {
        hasMoreData = false;
      }
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

  void _scrollListener() {
    if (isLoading.value || !hasMoreData) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      getVisitorsLogs(
        societyId: userdata.societyid.toString(),
        page: page,
        limit: limit,
      );
    }
  }
}

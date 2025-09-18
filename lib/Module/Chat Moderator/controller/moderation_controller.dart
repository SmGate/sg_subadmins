import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:societyadminapp/Module/Chat%20Moderator/model/make_moderator_model.dart'
    as mk;
import 'package:societyadminapp/Module/Chat%20Moderator/model/residents_model.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/services/moderation_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../Model/User.dart';

class ModerationController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  RxList<int> selectedResidentIds = <int>[].obs;
  RxString searchVal = "".obs;
  var pageSize = 10;
  RxString error = "".obs;
  List<Datum> residentRecordList = [];
  var allResidentModel = AllResidentModel();

//////////   MAke Moderator
  RxBool loading = false.obs;
  RxBool loading2 = false.obs;
  RxString errorMakingModerator = "".obs;
  var makeModeratorModel = mk.MakeModeratorModel();

  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    print("init");
    userdata = this.user;

    pagingController.addPageRequestListener((pageKey) {
      viewResidentsApi(
          pageKey: pageKey,
          limit: pageSize,
          subAdminId: userdata.userid.toString());
    });
  }

  //////// handling check box

  void addResident(int id) {
    selectedResidentIds.add(id);
    print(selectedResidentIds);
    update();
  }

  void removeResident(int id) {
    selectedResidentIds.remove(id);
    print(selectedResidentIds);
    update();
  }

  viewResidentsApi({
    String? subAdminId,
    int? pageKey,
    int? limit,
  }) async {
    print("this method call");
    error.value = "";

    var res = await ModerationService.getAllResidentList(
      subadminId: subAdminId,
      pageKey: pageKey,
      limit: limit,
    );

    if (res is AllResidentModel) {
      allResidentModel = res;
      residentRecordList = allResidentModel.data?.data ?? [];
      // Add IDs of residents who are moderators to selectedResidentIds
      for (var resident in residentRecordList) {
        if (resident.isModerator == 1) {
          selectedResidentIds.add(resident.id ?? 0);
        }
      }

      print("total moderator are${selectedResidentIds}");
      final isLastPage = residentRecordList.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(residentRecordList);
      } else {
        final nextPageKey = pageKey! + 1;
        pagingController.appendPage(residentRecordList, nextPageKey);
      }
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

  ///////// make moderator
  void makeModerator(
      {String? society_id, List? residentIds, bool? isChangeStatus}) async {
    isChangeStatus == true ? loading2.value : loading.value = true;
    error.value = "";

    var res = await ModerationService.makeModerator(
        society_id: society_id, residentIds: residentIds);
    isChangeStatus == true ? loading2.value : loading.value = false;
    if (res is mk.MakeModeratorModel) {
      makeModeratorModel = res;
      Get.snackbar("Message", makeModeratorModel.message.toString());
      Get.offNamed(homescreen, arguments: userdata);
    } else {
      isChangeStatus == true ? loading2.value : loading.value = false;
      errorMakingModerator.value = res.toString();
      Get.snackbar("Error", errorMakingModerator.value);
    }
  }

  //////////// getting blocked user in chat
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/domestic_help/model/all_bookings_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/delete_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/domestic_helper_profile.dart';
import 'package:societyadminapp/Module/domestic_help/model/get_all_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/register_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/model/update_domestic_helper.dart';
import 'package:societyadminapp/Module/domestic_help/sevices/domestic_helper_servic.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../Model/User.dart';

class DomesticHelpCOntroller extends GetxController {
  var data = Get.arguments;
  User userdata = User();

  void onInit() {
    userdata = data;
    super.onInit();
  }

  RxBool registerDomesticHelperLoading = false.obs;
  String registerDomesticHelperError = "";
  var registerDomesticHelperModel = RegisterDomesticHelperModel();

  RxBool updateDomesticHelperLoading = false.obs;
  String updateDomesticHelperError = "";
  var updateDomesticHelperModel = UpdateDomesticHelperModel();

  RxBool deleteDomesticHelperLoading = false.obs;
  String deleteDomesticHelperError = "";
  var deleteDomesticHelperModel = DeleteDomesticHelperModel();

  RxBool getAllDomesticHelperLoading = false.obs;
  String getAllDomesticHelperError = "";
  var getAllDomesticHelperModel = GetAllDomesticHelperModel();

  RxBool viewDomesticHelperProfileLoading = false.obs;
  String viewDomesticHelperProfileError = "";
  var viewDomesticHelperProfileModel = DomesticHelperProfileModel();

  String getAllBookingsError = "";
  RxBool getAllbookingLoading = false.obs;
  var getAllbookingsModel = AllBookingsModel();

  void registerDomesticHelper({
    String? societyId,
    String? name,
    String? phone,
    String? cnic,
    String? age,
    String? address,
    String? occupation,
    bool? avialble,
    String? visitingFee,
    String? subadminId,
  }) async {
    registerDomesticHelperLoading.value = true;
    registerDomesticHelperError = "";

    var res = await DomesticHelperService.registerDomesticHelper(
        societyId: societyId,
        name: name,
        phone: phone,
        cnic: cnic,
        age: age,
        address: address,
        occupation: occupation,
        visitingFee: visitingFee,
        avialble: avialble,
        subadminId: subadminId);
    registerDomesticHelperLoading.value = false;

    if (res is RegisterDomesticHelperModel) {
      registerDomesticHelperModel = res;
      Get.snackbar("Message", "Job Added Successfully");
      Get.offNamed(allDomesticHelp, arguments: userdata);
    } else {
      registerDomesticHelperError = res.toString();
      registerDomesticHelperLoading.value = false;
      Get.snackbar("Error", registerDomesticHelperError);
    }
  }

  Future<GetAllDomesticHelperModel?> getAllDomesticHelper({
    int? societyId,
    String? occupation,
    int? isAvaiable,
  }) async {
    var userID = userdata.structureType == 6 ? userdata.userid ?? 0 : societyId;
    try {
      getAllDomesticHelperLoading.value = true;
      getAllDomesticHelperError = "";

      final res = await DomesticHelperService.getAllDomesticHelper(
        societyId: userID,
        occupation: occupation ?? "",
        isAvaiable: 0,
      );

      getAllDomesticHelperLoading.value = false;

      if (res is GetAllDomesticHelperModel) {
        return res;
      } else {
        getAllDomesticHelperError = res.toString();
        return null;
      }
    } catch (e) {
      getAllDomesticHelperLoading.value = false;
      getAllDomesticHelperError = e.toString();
      return null;
    }
  }

  void updateDomesticHelper({
    String? societyId,
    String? name,
    String? phone,
    String? cnic,
    String? age,
    String? address,
    String? occupation,
    String? visitingFee,
    String? workerId,
    bool? avialble,
  }) async {
    updateDomesticHelperLoading.value = true;
    updateDomesticHelperError = "";

    var res = await DomesticHelperService.updateDomesticHelper(
        societyId: societyId,
        name: name,
        phone: phone,
        cnic: cnic,
        age: age,
        address: address,
        occupation: occupation,
        avialble: avialble,
        visitingFee: visitingFee,
        workerId: workerId);

    updateDomesticHelperLoading.value = false;
    if (res is UpdateDomesticHelperModel) {
      updateDomesticHelperModel = res;
      Get.snackbar("Message", "Updated Successfully");
      Get.offNamed(allDomesticHelp, arguments: userdata);
    } else {
      updateDomesticHelperLoading.value = false;
      updateDomesticHelperError = res.toString();
      Get.snackbar("Error", updateDomesticHelperError);
    }
  }

  void deleteDomesticHelper({String? workerId, BuildContext? context}) async {
    deleteDomesticHelperLoading.value = true;
    deleteDomesticHelperError = "";

    var res =
        await DomesticHelperService.deleteDomesticHelper(workerId: workerId);
    deleteDomesticHelperLoading.value = false;
    if (res is DeleteDomesticHelperModel) {
      deleteDomesticHelperModel = res;
      Navigator.of(context!).pop();
      Get.snackbar("Message", "Helper Deleted Successfully");
    } else {
      deleteDomesticHelperError = res.toString();
      deleteDomesticHelperLoading.value = false;
      Get.snackbar("Error", deleteDomesticHelperError);
    }
  }

  Future<DomesticHelperProfileModel?> getDomesticHelperProfile({
    String? workerId,
  }) async {
    viewDomesticHelperProfileLoading.value = true;
    viewDomesticHelperProfileError = "";

    var res = await DomesticHelperService.getAllDomesticHelperProfile(
      workerId: workerId,
    );

    viewDomesticHelperProfileLoading.value = false;

    if (res is DomesticHelperProfileModel) {
      viewDomesticHelperProfileModel = res;
      Get.snackbar("Message", res.message ?? 'Success');
      return res;
    } else {
      viewDomesticHelperProfileError = res.toString();
      Get.snackbar("Error", viewDomesticHelperProfileError);
      return null;
    }
  }

  Future<AllBookingsModel?> getAllBookings({
    int? societyId,
  }) async {
    var id =
        userdata.structureType == 6 ? userdata.userid ?? 0 : societyId ?? 0;
    try {
      getAllbookingLoading.value = true;
      getAllBookingsError = "";

      final res = await DomesticHelperService.getAllBookings(
        societyID: id.toString(),
      );

      getAllbookingLoading.value = false;

      if (res is AllBookingsModel) {
        return res;
      } else {
        getAllBookingsError = res.toString();
        return null;
      }
    } catch (e) {
      getAllbookingLoading.value = false;
      getAllBookingsError = e.toString();
      return null;
    }
  }
}

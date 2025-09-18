import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/parking%20managment/model/add_parking_model.dart';
import 'package:societyadminapp/Module/parking%20managment/model/assign_parking_model.dart';
import 'package:societyadminapp/Module/parking%20managment/model/get_area_slots_model.dart';
import 'package:societyadminapp/Module/parking%20managment/service/parking_management_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../Model/User.dart';
import '../model/update_parking_model.dart';

class ParkingManagementController extends GetxController {
  var userdata = Get.arguments;
  late final User user;

  TextEditingController parkingAreaNameController = TextEditingController();
  TextEditingController slotsContingController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final formKey1 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  RxString errorAddingParking = "".obs;
  var addParkingModel = AddParkingModel();
  var getParkingSlotsModel = GetAreaAndSlotsModel();
  final focus = FocusNode();
  final focus2 = FocusNode();
  TextEditingController searchSlotsController = TextEditingController();
  TextEditingController searchResidentController = TextEditingController();

  RxInt parkingAreaSelectedIndex = 0.obs;
  RxString errorAssigningParking = "".obs;
  RxString errorGettingParking = "".obs;

  var assignParkingModel = AssignParkingModel();
  int? residentId;
  RxString selectedStatus = "".obs;
  RxString parkingLotName = "".obs;

  /// ALL BOOL NEEDED
  RxBool loading = false.obs;

  RxBool loadingAddingParkingData = false.obs;
  RxBool loadingAssignParking = false.obs;
  RxString searchResidentValue = "".obs;
  ////// REFRESH PARKING SLOTS DATA
  RxBool loading1 = false.obs;
  RxString errorRefreshingSlots = "".obs;

  //////// UPDATE PARKING
  RxBool loadingUpdatingParking = false.obs;
  RxString errorUpdatingParking = "".obs;
  var updateParkingModel = UpdateParkingModel();
  @override
  void onInit() async {
    super.onInit();
    user = this.userdata;

    await getParkingSlots(
        societyId: user.societyid.toString(),
        status: selectedStatus.value,
        area: parkingLotName.value);
  }

  @override
  void dispose() {
    searchSlotsController.dispose();
    searchResidentController.dispose();
    focus.dispose();
    focus2.dispose();
    super.dispose();
  }

  void addParking({
    String? societyId,
    String? parkingAreaName,
    String? totalSlots,
    String? subadminId,
  }) async {
    loadingAddingParkingData.value = true;
    errorAddingParking.value = "";

    var res = await ParkingManagmentService.addparking(
        societyId: societyId,
        parkingAreaName: parkingAreaName,
        totalSlots: totalSlots,
        subadmin: subadminId);
    loadingAddingParkingData.value = false;
    if (res is AddParkingModel) {
      addParkingModel = res;
      parkingAreaNameController.text = "";
      slotsContingController.text = "";

      Get.snackbar("Message", addParkingModel.message.toString());
      Get.offNamed(assignedParking, arguments: user);
    } else {
      errorAddingParking.value = res.toString();
      loadingAddingParkingData.value = false;
      Get.snackbar("Error", errorAddingParking.value);
    }
  }

  void updateParking(
      {String? slotId,
      String? residentId,
      String? status,
      BuildContext? context}) async {
    loadingUpdatingParking.value = true;
    errorUpdatingParking.value = "";

    var res = await ParkingManagmentService.updateParking(
        slotId: slotId, residentId: residentId, status: status);
    loadingUpdatingParking.value = false;
    if (res is UpdateParkingModel) {
      updateParkingModel = res;
      searchResidentController.text = "";

      Get.snackbar("Message", updateParkingModel.message.toString());
      Navigator.of(context!).pop();
      // Get.offNamed(assignedParking, arguments: user);
    } else {
      errorUpdatingParking.value = res.toString();
      loadingUpdatingParking.value = false;
      Get.snackbar("Error", errorUpdatingParking.value);
    }
  }

  Future<GetAreaAndSlotsModel> getParkingSlots(
      {String? societyId, String? area = "", String? status = ""}) async {
    var userId = user.structureType == 6 ? user.userid ?? "" : societyId ?? "";
    errorGettingParking.value = "";
    loading.value = true;

    var res = await ParkingManagmentService.getParkingSlots(
        societyId: userId.toString(), status: status, area: area);
    loading.value = false;

    if (res is GetAreaAndSlotsModel) {
      getParkingSlotsModel = res;

      return getParkingSlotsModel;
    } else {
      loading.value = false;
      errorGettingParking.value = res.toString();
      Get.snackbar("Error", errorGettingParking.value);
    }

    return getParkingSlotsModel;
  }

  void assignParking(
      {String? slotId,
      String? residentId,
      String? starDate,
      BuildContext? context}) async {
    loadingAssignParking.value = true;
    errorAssigningParking.value = "";

    var res = await ParkingManagmentService.assignparking(
        slotId: slotId, residentId: residentId, starDate: starDate);
    loadingAssignParking.value = false;
    if (res is AssignParkingModel) {
      assignParkingModel = res;
      Get.snackbar("Message", "Parking Assigned Successfully");
      searchResidentController.text = "";
      Navigator.of(context!).pop();
    } else {
      errorAssigningParking.value = res.toString();
      loadingAssignParking.value = false;
      Get.snackbar("Error", errorAssigningParking.value);
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/add_shortterm_rental_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_all_shortterm_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_apartments_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_floors_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/rentSettlement_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/service/add_short_term_rental_service.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../../Model/User.dart';
import '../model/get_society_buildings_model.dart';

class ShortTermRentalController extends GetxController {
  var user = Get.arguments;
  late Future data;

  late final User userdata;
  final formKey = new GlobalKey<FormState>();
  TextEditingController guestNameController = TextEditingController();

  TextEditingController guestPhoneController = TextEditingController();

  TextEditingController guestCNicController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController annualIncreamentController = TextEditingController();
  TextEditingController monthlyRentController = TextEditingController();

  RxList<SocietyBuilding> societyBuildings = <SocietyBuilding>[].obs;
  RxList<BuildingFloor> buildingFloors = <BuildingFloor>[].obs;

  RxInt selectedBuildingId = 0.obs;
  RxInt selectedFloorId = 0.obs;

  RxBool loadingBuildings = false.obs;
  RxBool loadingFloors = false.obs;

  // =============================
  RxList<BuildingApartment> buildingApartments = <BuildingApartment>[].obs;
  RxInt selectedApartmentId = 0.obs;
  RxBool loadingApartments = false.obs;

  //================

  late AllShortTermRentalModel allShortTermRentalModel;
  String error1 = "";

  // =========================

  RxBool addRentSettleMentLoading = false.obs;
  String errorRentSettlement = "";
  var rentSettlementModel = RentSettlementModel();
  void onInit() {
    super.onInit();
    print("init");
    userdata = this.user;
    fetchBuildings();
  }

  var addShortTermRentalModel = AddShortTermRentalModel();
  RxBool addingRentalLoading = false.obs;
  String error = "";

  void addShortTermRental({
    required String guestName,
    required String guestPhone,
    required String guestCnic,
    required File cnicPhoto,
    required String checkInDate,
    required String checkOutDate,
    required String totalPrice,
    required String description,
    required String vehicleNumber,
    required String apartmentId,
    required String buildingId,
    required String societyId,
    required String subadminId,
  }) async {
    addingRentalLoading.value = true;
    error = "";
    var response = await AddShortTermRentalService.addShortTermRental(
        guestName: guestName,
        guestPhone: guestPhone,
        guestCnic: guestCnic,
        cnicPhoto: cnicPhoto,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        totalPrice: totalPrice,
        description: description,
        vehicleNumber: vehicleNumber,
        apartmentId: apartmentId,
        buildingId: buildingId,
        societyId: societyId,
        subAdminId: subadminId,
        token: userdata.bearerToken ?? "");

    addingRentalLoading.value = false;

    if (response is AddShortTermRentalModel) {
      addShortTermRentalModel = response;
      addingRentalLoading.value = false;
      Get.offNamed(allShortTermRental, arguments: userdata);
      Get.snackbar(
        "Success",
        addShortTermRentalModel.message.toString(),
      );
    } else {
      error = response.toString();
      addingRentalLoading.value = false;
      Get.snackbar(
        "Error",
        error,
      );
    }
  }

  Future<void> fetchBuildings() async {
    loadingBuildings.value = true;
    var response = await AddShortTermRentalService.getSocietyBuildings(
        subadminId: userdata.userid ?? 0);
    loadingBuildings.value = false;

    if (response is GetSocietyBuildingsModel) {
      societyBuildings.value = response.data ?? [];
    } else {
      Get.snackbar("Error", response.toString());
    }
  }

  Future<void> fetchFloors(int buildingId) async {
    loadingFloors.value = true;
    selectedFloorId.value = 0; // Reset floor selection
    var response = await AddShortTermRentalService.getBuilDIngFloors(
        buildingId: buildingId);
    loadingFloors.value = false;

    if (response is GetBuildingFloorsModel) {
      buildingFloors.value = response.data ?? [];
    } else {
      Get.snackbar("Error", response.toString());
    }
  }

  //==============
  Future<void> fetchApartments(int floorId) async {
    loadingApartments.value = true;
    selectedApartmentId.value = 0; // Reset apartment selection
    var response = await AddShortTermRentalService.getBuilDIngFloorsApartment(
        floorId: floorId);
    loadingApartments.value = false;

    if (response is GetBuildingApartmentsModel) {
      buildingApartments.value = response.data ?? [];
    } else {
      Get.snackbar("Error", response.toString());
    }
  }

  //=====================

  Future<AllShortTermRentalModel> viewAllShortTermRentals() async {
    error = "";
    var res = await AddShortTermRentalService.getAllShortTermRental();

    if (res is AllShortTermRentalModel) {
      allShortTermRentalModel = res;
      return allShortTermRentalModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return allShortTermRentalModel;
  }

  //==============
  Future<void> rentSettleMent(
      {String? apartmentId,
      String? monthlyRent,
      String? anualIncrement,
      String? startDate,
      String? residentId}) async {
    addRentSettleMentLoading.value = true;
    errorRentSettlement = "";
    var response = await AddShortTermRentalService.rentSettlement(
        apartmentId: apartmentId,
        monthlyRent: monthlyRent,
        anualIncrement: anualIncrement,
        startDate: startDate,
        residentId: residentId);
    addRentSettleMentLoading.value = false;

    if (response is RentSettlementModel) {
      rentSettlementModel = response;
      Get.snackbar("Message", response.message ?? "");
      Get.offNamed(homescreen, arguments: userdata);
    } else {
      Get.snackbar("Error", response.toString());
    }
  }
}

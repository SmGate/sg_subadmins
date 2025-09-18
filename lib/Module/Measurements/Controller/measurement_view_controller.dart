import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_apartments_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_floors_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_society_buildings_model.dart'
    as sb;
import 'package:societyadminapp/Module/ShortTermRental/service/add_short_term_rental_service.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/MeasurementModel.dart';

class MeasurementViewController extends GetxController {
  var userdata = Get.arguments;
  late final User user;

  //=============
  RxList<sb.SocietyBuilding> societyBuildings = <sb.SocietyBuilding>[].obs;
  RxList<BuildingFloor> buildingFloors = <BuildingFloor>[].obs;

  RxInt selectedBuildingId = 0.obs;
  RxInt selectedFloorId = 0.obs;

  RxBool loadingBuildings = false.obs;
  RxBool loadingFloors = false.obs;

  // =============================
  RxList<BuildingApartment> buildingApartments = <BuildingApartment>[].obs;
  RxInt selectedApartmentId = 0.obs;
  RxBool loadingApartments = false.obs;

  @override
  void onInit() {
    super.onInit();

    user = userdata;
    fetchHouseData();
    fetchApartmentData();
    fetchBuildings();
  }

  var houseFuture = Rxn<Future<MeasurementModel>>();
  var apartmentFuture = Rxn<Future<MeasurementModel>>();

  void fetchHouseData() {
    houseFuture.value = housesApartmentsModelApi(
      subadminid: user.userid!,
      token: user.bearerToken!,
      type: 'house',
      buildingId: selectedBuildingId.value == 0
          ? null
          : selectedBuildingId.value.toString(),
      floorId:
          selectedFloorId.value == 0 ? null : selectedFloorId.value.toString(),
      apartmentId: selectedApartmentId.value == 0
          ? null
          : selectedApartmentId.value.toString(),
    );
  }

  void fetchApartmentData() {
    apartmentFuture.value = housesApartmentsModelApi(
      subadminid: user.userid!,
      token: user.bearerToken!,
      type: 'apartment',
      buildingId: selectedBuildingId.value == 0
          ? null
          : selectedBuildingId.value.toString(),
      floorId:
          selectedFloorId.value == 0 ? null : selectedFloorId.value.toString(),
      apartmentId: selectedApartmentId.value == 0
          ? null
          : selectedApartmentId.value.toString(),
    );
  }

  Future<MeasurementModel> housesApartmentsModelApi({
    required int subadminid,
    required String token,
    required String type,
    String? buildingId,
    String? floorId,
    String? apartmentId,
  }) async {
    // Base URL
    final userId = user.structureType == 6
        ? subadminid.toString()
        : user.societyid.toString();
    final String bId = buildingId ?? '0';
    final String fId = floorId ?? '0';
    final String aId = apartmentId ?? '0';
    String baseUrl =
        "${Api.housesApartmentMeasurements}/$userId/$type/?building_id=$bId&floor_id=$fId&appartment_id=$aId";

    debugPrint("URL IS $baseUrl");
    // Build query parameters dynamically

    final response = await Http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return MeasurementModel.fromJson(data);
    }
    return MeasurementModel.fromJson(data);
  }

  /// ================

  Future<void> fetchBuildings() async {
    final userId =
        user.structureType == 6 ? user.userid ?? 0 : user.societyid ?? 0;
    loadingBuildings.value = true;
    var response =
        await AddShortTermRentalService.getSocietyBuildings(subadminId: userId);
    loadingBuildings.value = false;

    if (response is sb.GetSocietyBuildingsModel) {
      societyBuildings.value = response.data ?? [];
    } else {
      Get.snackbar("Error", response.toString());
    }
  }

  Future<void> fetchFloors(int buildingId) async {
    loadingFloors.value = true;
    selectedFloorId.value = 0; 
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
}

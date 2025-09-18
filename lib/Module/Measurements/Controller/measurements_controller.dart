import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/Measurements/Model/MeasurementModel.dart'
    as m;
import 'package:societyadminapp/Module/Measurements/Model/add_measurment_model.dart';
import 'package:societyadminapp/Module/Measurements/service/measurement_service.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_apartments_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_building_floors_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_society_buildings_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/service/add_short_term_rental_service.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';
import '../../../Routes/set_routes.dart';

class AddMeasurementController extends GetxController {
  String? propertyVal;
  String? unitVal;
  String? categoryValue;

  bool isLoading = false;
  final TextEditingController chargesController = TextEditingController();
  final TextEditingController chargesAfterDueDateController =
      TextEditingController();
  final TextEditingController lateChargesController = TextEditingController();
  final TextEditingController appChargesController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController monthlyRentController = TextEditingController();
  final TextEditingController annualIncreamentController =
      TextEditingController();
  var userdata = Get.arguments;
  late final User user;
  final formKey = new GlobalKey<FormState>();
  RxBool isUpdating = false.obs;

  // =========. NEW CHANGES =========

  RxBool loadingAddingMeasurement = false.obs;
  String errorAddMeasurement = '';
  var measurementModel = AddMeasurement();

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

  var apartmentTypeValue = ''.obs;

  @override
  void onInit() {
    super.onInit();

    user = userdata;
    fetchBuildings();
  }

  String? unitLabel;

  bool isArea = false;
  List<String> property_types = ['house', 'apartment'];
  List<String> measurements_types = [];

  setPropertyVal(val) {
    propertyVal = val;
    update();
  }

  setMeasurementVal(val) {
    unitVal = val;
    update();
  }

  setCategoryValueVal(val) {
    categoryValue = val;
    update();
  }

  setArea() {
    isArea = true;
    update();
  }

  void setApartmentType(String? val) {
    apartmentTypeValue.value = val ?? '';
  }

  // ======== ADD MEASURMENR NEW FUNCTIONS ========

  addMeasurement({
    String? userId,
    String? type,
    String? category,
    String? societyId,
    String? societyBuildingId,
    String? societyBuildingFloorId,
    String? societyBuildingApartmentId,
    String? apartmentType,
    String? unitType,
    String? charges,
    String? area,
    String? lateCharges,
    String? appCharges,
    String? tax,
  }) async {
    loadingAddingMeasurement.value = true;
    errorAddMeasurement = "";

    var res = await MeasurementService.addMeasurement(
        userId: userId,
        type: type,
        category: category,
        societyId: societyId,
        societyBuildingId: societyBuildingId,
        societyBuildingFloorId: societyBuildingFloorId,
        societyBuildingApartmentId: societyBuildingApartmentId,
        apartmentType: apartmentType,
        unitType: unitType,
        charges: charges,
        area: area,
        lateCharges: lateCharges,
        appCharges: appCharges,
        tax: tax);

    if (res is AddMeasurement) {
      measurementModel = res;
      Get.snackbar("Message", measurementModel.message.toString());

      Get.offNamed(measurementview, arguments: user);
    } else {
      errorAddMeasurement = res.toString();
      Get.snackbar("Error", errorAddMeasurement);
    }
    loadingAddingMeasurement.value = false;
    update();
  }

  /// ================

  Future<void> fetchBuildings() async {
    loadingBuildings.value = true;
    var response = await AddShortTermRentalService.getSocietyBuildings(
        subadminId: user.userid ?? 0);
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

  // Future addMeasurementApi({
  //   required int userid,
  //   required String bearerToken,
  //   required String propertyType,
  //   required String unitType,
  //   required String charges,
  //   required String area,
  //   required String lateCharges,
  //   String? appCharges,
  //   String? monthlyRent,
  //   String? annualIncreament,
  //   String? category,
  //   required String tax,
  // }) async {
  //   isLoading = true;
  //   update();
  //   final response = await Http.post(
  //     Uri.parse(Api.addMeasurement),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': "Bearer $bearerToken"
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "subadminid": userid,
  //       'type': propertyType,
  //       'unit': unitType,
  //       'charges': charges,
  //       'area': area,
  //       "status": 0,
  //       "latecharges": lateCharges,
  //       "appcharges": double.tryParse(appCharges ?? ""),
  //       "tax": tax,
  //       "monthly_rent": monthlyRent,
  //       "annual_increment": annualIncreament,
  //       "category": category,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     Get.snackbar("Successful", "Measurement Added !");
  //     isLoading = false;
  //     update();
  //     propertyVal = null;
  //     unitVal = null;
  //     clearText();

  //     Get.offNamed(measurementview, arguments: user);
  //   } else if (response.statusCode == 403) {
  //     var data = jsonDecode(response.body.toString());
  //     (data['errors'] as List)
  //         .map((e) => Get.snackbar(
  //               "Error",
  //               e.toString(),
  //             ))
  //         .toList();

  //     propertyVal = null;
  //     unitVal = null;

  //     chargesController.clear();
  //     areaController.clear();
  //     isLoading = false;
  //     update();
  //   } else {
  //     isLoading = false;
  //     update();
  //     Get.snackbar("Error", "Failed to Add Measurement");
  //   }
  // }

  Future updateMeasurementApi({
    int? measurementId,
    int? userid,
    String? bearerToken,
    String? type,
    String? category,
    String? societyId,
    String? societyBuildingId,
    String? societyBuildingFloorId,
    String? societyBuildingApartmentId,
    String? apartmentType,
    String? unitType,
    String? charges,
    String? area,
    String? lateCharges,
    String? appCharges,
    String? tax,
  }) async {
    isUpdating.value = true;

    Map<String, dynamic> requestBody = {
      "measurement_id": measurementId,
      "subadminid": userid,
      "type": type,
      "category": category,
      "society_id": societyId,
      "societybuilding_id": societyBuildingId,
      "societybuildingfloor_id": societyBuildingFloorId,
      "societybuildingapartment_id": societyBuildingApartmentId,
      "appartment_type": apartmentType,
      "unit": unitType,
      "charges": charges,
      "area": area ?? "",
      "status": 0,
      "latecharges": lateCharges,
      "appcharges": double.tryParse(appCharges ?? ""),
      "tax": tax,
    };

    /// 🔍 Debug: Print request body
    debugPrint("Request Body: ${jsonEncode(requestBody)}");

    final response = await Http.post(
      Uri.parse(Api.updateMeasurment),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
      body: jsonEncode(requestBody),
    );

    /// 🔍 Debug: Print full response
    debugPrint("Response Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Get.snackbar("Successful", "Measurement Updated!");
      isUpdating.value = false;
      update();
      propertyVal = null;
      unitVal = null;
      clearText();
      Get.offNamed(measurementview, arguments: user);
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());
      (data['errors'] as List)
          .map((e) => Get.snackbar(
                "Error",
                e.toString(),
              ))
          .toList();

      propertyVal = null;
      unitVal = null;

      chargesController.clear();
      areaController.clear();
      isUpdating.value = false;
    } else {
      isUpdating.value = false;
      Get.snackbar("Error", "Failed to Update Measurement");
    }
  }

  Future<m.MeasurementModel> housesApartmentsModelApi(
      {required int subadminid,
      required String token,
      required String type}) async {
    isLoading = true;
    update();
    final response = await Http.get(
      Uri.parse(Api.housesApartmentMeasurements +
          "/" +
          subadminid.toString() +
          "/" +
          type.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      return m.MeasurementModel.fromJson(data);
    }
    return m.MeasurementModel.fromJson(data);
  }

  calculate(servicecharges) {
    double? serviceCharges = double.tryParse(servicecharges) ?? 0.0;
    double app_percentage = 2;
    double tax_percentage = 15;
    double after_due_date_fine = 0.05;
    double app_charges = serviceCharges * (app_percentage / 100);
    double tax_charges = serviceCharges * (tax_percentage / 100);
    double late_charges = (serviceCharges * after_due_date_fine);
    double after_duedate_charges =
        (serviceCharges * after_due_date_fine) + serviceCharges;

    taxController.text = tax_charges.toString();
    appChargesController.text = app_charges.toString();
    chargesAfterDueDateController.text = after_duedate_charges.toString();
    lateChargesController.text = late_charges.toString();

    update();
  }

  clearText() {
    taxController.text = '';
    appChargesController.text = '';
    chargesAfterDueDateController.text = '';
    chargesController.text = '';
    areaController.text = '';
    update();
  }
}

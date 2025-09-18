import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/Measurements/Model/MeasurementModel.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/Resident Model/ApartmentResidentModel.dart'
    as ApartmentResidentModel;
import 'package:societyadminapp/Module/parking%20managment/model/get_area_slots_model.dart';
import 'package:societyadminapp/Module/parking%20managment/service/parking_management_service.dart';

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../Model/Resident Model/ApartmentResidentModel.dart';

class ApartmentResidentVerificationController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  var data = Get.arguments;
  User userdata = User();
  late ApartmentResidentModel.Data resident;
  bool loading = false;

  String country = '';
  String state = '';
  String city = '';
  String propertyType = 'House';
  String residentalType = 'Rental';
  Building? building;
  Floor? floor;
  Apartment? apartment;

  RxString emptyDataMsg = "".obs;

  /* for apartments */
  var buildingli = <Building>[];
  var floorli = <Floor>[];
  var apartmentli = <Apartment>[];

  var housesApartments = <Measurement>[];
  Measurement? measurementModel;

  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController houseaddressdetailController = TextEditingController();

  // =========================================================
  TextEditingController apartmentRentController = TextEditingController();
  TextEditingController serviceChargesController = TextEditingController();
  TextEditingController waterChargesController = TextEditingController();
  TextEditingController increamentPercentController = TextEditingController();
  TextEditingController securityAMountController = TextEditingController();
  TextEditingController parkingRateController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneCOntroller = TextEditingController();
  MeasurementModel measurementModeln = MeasurementModel();

  Rx<DateTime?> rentStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> incrementDate = Rx<DateTime?>(null);
  RxBool showIncrementContainer = false.obs;
  RxBool isRentStartDateValid = true.obs;

  ///====================
  RxString selectedParkingArea = ''.obs;
  Rxn<Slot> selectedParkingSlot = Rxn<Slot>();

  late GetAreaAndSlotsModel getParkingSlotsModel;
  RxBool loadingParking = false.obs;
  RxString errorGettingParking = ''.obs;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  SelectedHousesApartments(val) {
    measurementModel = val;

    update();
  }

  SelectedBuilding(val) async {
    apartmentli.clear();
    apartment = null;
    floor = null;
    floorli.clear();
    measurementModel = null;

    housesApartments.clear();
    houseaddressdetailController.clear();
    building = val;

    update();
  }

  SelectedFloor(val) async {
    apartmentli.clear();
    apartment = null;
    measurementModel = null;
    housesApartments.clear();
    houseaddressdetailController.clear();

    floor = val;

    update();
  }

  SelectedApartment(val) async {
    measurementModel = null;
    housesApartments.clear();

    apartment = val;

    housesApartmentsModelApis(
        type: "apartment",
        subadminid: userdata.userid ?? 0,
        buildingId: building?.id.toString(),
        floorId: floor?.id.toString(),
        apartmentId: apartment?.id.toString(),
        token: userdata.bearerToken ?? "");

    update();
  }

  Future<List<Measurement>> housesApartmentsModelApi(
      {required int subadminid,
      required String token,
      required String type}) async {
    print(subadminid);
    print(token);
    print(type);

    var response = await Dio().get(
        Api.housesApartmentMeasurements +
            '/' +
            subadminid.toString() +
            '/' +
            type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }));
    var data = response.data['data'];

    housesApartments = (data as List)
        .map((e) => Measurement(
            id: e['id'],
            subadminid: e['subadminid'],
            charges: e['charges'],
            area: e['area'] == null ? e['category'] : e['area'],
            bedrooms: e['bedrooms'],
            status: e['status'],
            type: e['type'],
            unit: e['unit'] == null ? "" : e['unit']))
        .toList();

    return housesApartments;
  }

  Future<List<Building>> viewAllBuildingApi(
      {required subAdminId, required bearerToken}) async {
    var response = await Dio().get(
        Api.allSocietyBuildings + '/' + subAdminId.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    buildingli = (data as List)
        .map((e) => Building(
            id: e['id'],
            subadminid: e['pid'],
            societybuildingname: e['societybuildingname'],
            type: e['type'],
            societyid: e['societyid'],
            dynamicid: e['dynamicid'],
            superadminid: e['superadminid']))
        .toList();

    return buildingli;
  }

  Future<List<Floor>> viewAllFloorApi(
      {required buildingid, required bearerToken}) async {
    print(buildingid);
    var response = await Dio().get(
        Api.viewSocietyBuildingFloors + '/' + buildingid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    floorli = (data as List)
        .map((e) => Floor(
              id: e['id'],
              buildingid: e['pid'],
              name: e['name'],
            ))
        .toList();

    return floorli;
  }

  Future<List<Apartment>> viewAllApartmentApi(
      {required floorid, required bearerToken}) async {
    print(floorid);
    var response = await Dio().get(
        Api.viewSocietyBuildingApartments + '/' + floorid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    apartmentli = (data as List)
        .map((e) => Apartment(
              id: e['id'],
              name: e['name'],
              societybuildingfloorid: e['societybuildingfloorid'],
            ))
        .toList();

    return apartmentli;
  }

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
    getParkingSlots(societyId: userdata.societyid.toString(), status: "all");

    // Set Selected Building if available
    if (resident.building != null && resident.building!.isNotEmpty) {
      SelectedBuilding(Building(
        type: resident.building!.first.type ?? "",
        superadminid: resident.building!.first.superadminid ?? 0,
        dynamicid: resident.building!.first.dynamicid ?? 0,
        societyid: resident.building!.first.societyid ?? 0,
        subadminid: resident.building!.first.subadminid ?? 0,
        id: resident.building!.first.id ?? 0,
        updatedAt: resident.building!.first.updatedAt ?? "",
        createdAt: resident.building!.first.createdAt ?? "",
        societybuildingname: resident.building!.first.societybuildingname ?? "",
      ));
    }

    // Set Selected Floor if available
    if (resident.floor != null && resident.floor!.isNotEmpty) {
      SelectedFloor(Floor(
        createdAt: resident.floor!.first.createdAt ?? "",
        updatedAt: resident.floor!.first.updatedAt ?? "",
        id: resident.floor!.first.id ?? 0,
        name: resident.floor!.first.name ?? "",
        buildingid: resident.floor!.first.buildingid ?? 0,
      ));
    }

    // Set Selected Apartment if available
    if (resident.apartment != null && resident.apartment!.isNotEmpty) {
      SelectedApartment(Apartment(
        name: resident.apartment!.first.name ?? "",
        id: resident.apartment!.first.id ?? 0,
        createdAt: resident.apartment!.first.createdAt ?? "",
        updatedAt: resident.apartment!.first.updatedAt ?? "",
        type: resident.apartment!.first.type ?? "",
        typeid: resident.apartment!.first.typeid ?? 0,
        societybuildingfloorid:
            resident.apartment!.first.societybuildingfloorid ?? 0,
      ));
    }

    // Set Measurement if available
    if (resident.measurement != null && resident.measurement!.isNotEmpty) {
      SelectedHousesApartments(Measurement(
        id: resident.measurement!.first.id ?? 0,
        subadminid: resident.measurement!.first.subadminid ?? 0,
        charges: resident.measurement!.first.charges ?? "",
        area: resident.measurement!.first.area ?? "",
        bedrooms: resident.measurement!.first.bedrooms ?? 0,
        status: resident.measurement!.first.status ?? 0,
        type: resident.measurement!.first.type ?? "",
        unit: resident.measurement!.first.unit ?? "",
        chargesafterduedate:
            resident.measurement!.first.chargesafterduedate ?? "",
        appcharges: resident.measurement!.first.appcharges ?? "",
        tax: resident.measurement!.first.tax ?? "",
        createdAt: resident.measurement!.first.createdAt ?? "",
        updatedAt: resident.measurement!.first.updatedAt ?? "",

        // ✅ Newly added fields
        societyId: resident.measurement!.first.societyId ?? 0,
        societyBuildingId: resident.measurement!.first.societyBuildingId ?? 0,
        societyBuildingFloorId:
            resident.measurement!.first.societyBuildingFloorId ?? 0,
        societyBuildingApartmentId:
            resident.measurement!.first.societyBuildingApartmentId ?? 0,
        appartmentType: resident.measurement!.first.appartmentType ?? "",
        category: resident.measurement!.first.category ?? "",
        monthlyRent: resident.measurement!.first.monthlyRent ?? "",
        annualIncrement: resident.measurement!.first.annualIncrement ?? "",
      ));
    }

    // Set text fields
    houseaddressdetailController.text = resident.houseaddress?.toString() ?? "";
    vehiclenoController.text = resident.vechileno?.toString() ?? "";
  }

  Future verifyApartmentResidentApi({
    required int residentid,
    required int status,
    int? propertyid,
    int? buildingid,
    int? societybuildingfloorid,
    int? societybuildingapartmentid,
    required int measurementid,
    String? vechileno,
    String? houseaddress,
    double? monthly_rent,
    double? service_charge,
    double? water_charge,
    String? rent_start_date,
    String? increment_date,
    double? increment_percentage,
    double? security_amount,
    bool? parking,
    double? parking_rate,
    int? parking_slot,
    required String token,
    String? ownerName,
    String? ownerPhone,
  }) async {
    loading = true;
    update();

    final Map<String, dynamic> bodyData = {
      "residentid": residentid,
      "status": status,
      "propertyid": propertyid,
      "buildingid": buildingid,
      "societybuildingfloorid": societybuildingfloorid,
      "societybuildingapartmentid": societybuildingapartmentid,
      "measurementid": measurementid,
      "vechileno": vechileno,
      "houseaddress": houseaddress,
      "monthly_rent": monthly_rent,
      "service_charge": service_charge,
      "water_charge": water_charge,
      "rent_start_date": rent_start_date,
      "increment_date": increment_date,
      "increment_percentage": increment_percentage,
      "security_amount": security_amount,
      "parking": parking,
      "parking_rate": parking_rate,
      "parking_slot": parking_slot,
      "ownername": ownerName,
      "ownermobileno": ownerPhone
    };

    print("Sending data: $bodyData");

    final response = await Http.post(
      Uri.parse(Api.verifyApartmentResident),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(bodyData),
    );

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      Get.offNamed(unverifiedresident, arguments: userdata);
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());
      var errors = data['errors'] as List;
      for (int i = 0; i < errors.length; i++) {
        Get.snackbar('Error', errors[i].toString());
      }
    } else if (response.statusCode == 409) {
      var data = jsonDecode(response.body.toString());
      Get.snackbar(data['message'], "");
    } else {
      Get.snackbar('Something went wrong.', "");
    }

    loading = false;
    update();
  }

  Future<GetAreaAndSlotsModel> getParkingSlots(
      {String? societyId, String? area = "", String? status = ""}) async {
    errorGettingParking.value = "";
    loadingParking.value = true;

    var res = await ParkingManagmentService.getParkingSlots(
        societyId: societyId, status: status, area: area);
    loadingParking.value = false;

    if (res is GetAreaAndSlotsModel) {
      getParkingSlotsModel = res;

      return getParkingSlotsModel;
    } else {
      loadingParking.value = false;
      errorGettingParking.value = res.toString();
      Get.snackbar("Error", errorGettingParking.value);
    }

    return getParkingSlotsModel;
  }

  void housesApartmentsModelApis({
    required int subadminid,
    required String token,
    required String type,
    String? buildingId,
    String? floorId,
    String? apartmentId,
  }) async {
    String baseUrl =
        "${Api.housesApartmentMeasurements}/$subadminid/$type/?building_id=$buildingId&floor_id=$floorId&appartment_id=$apartmentId";

    final response = await Http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        body["data"] is List &&
        body["data"].isNotEmpty) {
      final first = body["data"][0];

      measurementModel = Measurement(
        id: first["id"],
        subadminid: first["subadminid"],
        charges: first["charges"],
        area: first["area"],
        bedrooms: first["bedrooms"],
        status: first["status"],
        type: first["type"],
        unit: first["unit"],
        chargesafterduedate: first["latecharges"],
        appcharges: first["appcharges"],
        tax: first["tax"],
        createdAt: first["created_at"],
        updatedAt: first["updated_at"],

        // Optional nested fields with safety
        societyId: first["society"]?["id"] ?? 0,
        societyBuildingId: first["society_building"]?["id"] ?? 0,
        societyBuildingFloorId: first["society_building_floor"]?["id"] ?? 0,
        societyBuildingApartmentId:
            first["society_building_floor_appartment"]?["id"] ?? 0,
        appartmentType: first["appartment_type"] ?? "",
        category: first["category"] ?? "",
        monthlyRent: first["monthly_rent"]?.toString() ?? "",
        annualIncrement: first["annual_increment"]?.toString() ?? "",
      );
      print(measurementModel?.toJson());
      update();
    } else {
      throw Exception("Measurement data not found");
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/Resident Model/LocalBuildingApartmentResidentModel.dart';

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../Model/Resident Model/LocalBuildingApartmentResidentModel.dart'
    as LocalBuildingApartmentResidentModel;

class LocalBuildingApartmentResidentVerificationController
    extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  late LocalBuildingApartmentResidentModel.Data resident;
  bool loading = false;

  String country = '';
  String state = '';
  String city = '';
  String propertyType = 'House';
  String residentalType = 'Rental';
  Localbuilding? localbuilding;
  Localbuildingfloor? floor;
  Localbuildingapartment? apartment;

  /* for apartments */
  var buildingli = <Localbuilding>[];
  var floorli = <Localbuildingfloor>[];
  var apartmentli = <Localbuildingapartment>[];

  var housesApartments = <Measurement>[];
  Measurement? measurementModel;

  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController houseaddressdetailController = TextEditingController();

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
    localbuilding = val;

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
            area: e['area'],
            bedrooms: e['bedrooms'],
            status: e['status'],
            type: e['type'],
            unit: e['unit']))
        .toList();

    return housesApartments;
  }

  Future<List<Localbuilding>> viewAllBuildingApi(
      {required type, required bearerToken}) async {
    var response = await Dio().get(Api.viewAllSocieties + '/' + type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    buildingli = (data as List)
        .map((e) => Localbuilding(
            id: e['id'],
            name: e['name'],
            type: e['type'],
            superadminid: e['superadminid']))
        .toList();

    return buildingli;
  }

  Future<List<Localbuildingfloor>> viewAllFloorApi(
      {required buildingid, required bearerToken}) async {
    print(buildingid);
    var response = await Dio().get(
        Api.viewLocalBuildingFloors + '/' + buildingid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    floorli = (data as List)
        .map((e) => Localbuildingfloor(
              id: e['id'],
              buildingid: e['pid'],
              name: e['name'],
            ))
        .toList();

    return floorli;
  }

  Future<List<Localbuildingapartment>> viewAllApartmentApi(
      {required floorid, required bearerToken}) async {
    print(floorid);
    var response = await Dio().get(
        Api.viewLocalBuildingApartments + '/' + floorid.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    apartmentli = (data as List)
        .map((e) => Localbuildingapartment(
              id: e['id'],
              name: e['name'],
              localbuildingfloorid: e['localbuildingfloorid'],
            ))
        .toList();

    return apartmentli;
  }

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];

    SelectedBuilding(Localbuilding(
      type: resident.localbuilding?.first.type,
      superadminid: resident.localbuilding!.first.superadminid,
      id: resident.localbuilding!.first.id,
      updatedAt: resident.localbuilding!.first.updatedAt,
      createdAt: resident.localbuilding!.first.createdAt,
      name: resident.localbuilding!.first.name,
    ));
    SelectedFloor(Localbuildingfloor(
        createdAt: resident.localbuildingfloor!.first.createdAt,
        updatedAt: resident.localbuildingfloor!.first.updatedAt,
        id: resident.localbuildingfloor!.first.id,
        name: resident.localbuildingfloor!.first.name,
        buildingid: resident.localbuildingfloor!.first.buildingid));
    SelectedApartment(Localbuildingapartment(
      name: resident.localbuildingapartment!.first.name,
      id: resident.localbuildingapartment!.first.id,
      createdAt: resident.localbuildingapartment!.first.createdAt,
      updatedAt: resident.localbuildingapartment!.first.updatedAt,
      localbuildingfloorid:
          resident.localbuildingapartment!.first.localbuildingfloorid,
    ));
    SelectedHousesApartments(Measurement(
        id: resident.measurement!.first.id,
        subadminid: resident.measurement!.first.subadminid,
        charges: resident.measurement!.first.charges,
        area: resident.measurement!.first.area,
        bedrooms: resident.measurement!.first.bedrooms,
        status: resident.measurement!.first.status,
        type: resident.measurement!.first.type,
        unit: resident.measurement!.first.unit));
    houseaddressdetailController.text = resident.houseaddress!.toString();
    vehiclenoController.text = resident.vechileno.toString();
  }

  Future verifyApartmentResidentApi({
    residentid,
    required int status,
    localbuildingid,
    localbuildingfloorid,
    localbuildingapartmentid,
    measurementid,
    vechileno,
    houseaddress,
    required String token,
  }) async {
    loading = true;
    update();

    final response =
        await Http.post(Uri.parse(Api.verifyLocalBuildingApartmentResident),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
            body: jsonEncode(<String, dynamic>{
              "residentid": residentid,
              "status": status,
              'localbuildingid': localbuildingid,
              'fid': localbuildingfloorid,
              'aid': localbuildingapartmentid,
              'measurementid': measurementid,
              "vechileno": vechileno,
              "houseaddress": houseaddress
            }));

    print(response.body);

    if (response.statusCode == 200) {
      Get.offNamed(unverifiedresident, arguments: userdata);
      loading = false;
      update();
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());
      var errors = data['errors'] as List;

      for (int i = 0; i < errors.length; i++) {
        Get.snackbar('Error', errors[i].toString());
        loading = false;
        update();
      }
    } else if (response.statusCode == 409) {
      var data = jsonDecode(response.body.toString());

      Get.snackbar(data['message'], "");
      loading = false;
      update();
    } else {
      Get.snackbar('Something went wrong.', "");
      loading = false;
      update();
    }
  }
}

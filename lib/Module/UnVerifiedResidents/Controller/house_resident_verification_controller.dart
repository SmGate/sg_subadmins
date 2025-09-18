import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/Resident Model/HouseResident.dart'
    as HouseResident;
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/block.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/house.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/measurement.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/phases.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/society.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Model/street.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';

class HouseResidentVerificationController extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  late HouseResident.Data resident;
  String country = '';
  String state = '';
  String city = '';
  var isProperty = false;
  bool loading = false;

  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController houseAddressDetailController = TextEditingController();

  Society? societies;
  Phase? phases;
  Block? blocks;
  Street? streets;
  House? houses;
  Measurement? measurementModel;

  /*  for  houses */
  var phaseList = <Phase>[];
  var blockList = <Block>[];
  var streetList = <Street>[];
  var houseList = <House>[];
  var measurementList = <Measurement>[];

  Future<List<Phase>> viewAllPhasesApi(
      {required dynamicId, required bearerToken}) async {
    print('phases api');

    print(bearerToken);
    print(dynamicId);

    var response = await Dio().get(
        Api.viewAllPhases + '/' + dynamicId.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    phaseList = (data as List)
        .map((e) => Phase(
            id: e['id'],
            address: e['address'],
            subadminid: e['subadminid'],
            societyid: e['societyid'],
            iteration: e['iteration'],
            dynamicId: e['dynamicid']))
        .toList();

    return phaseList;
  }

  Future<List<Block>> viewAllBlocksApi(
      {required dynamicId, required type, required bearerToken}) async {
    print('Block aya');
    print(bearerToken);
    print(dynamicId);
    print(type);

    var response = await Dio().get(
        Api.blocks + '/' + dynamicId.toString() + '/' + type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];
    print(data);
    blockList = (data as List)
        .map((e) => Block(
            id: e['id'],
            address: e['address'],
            dynamicId: e['dynamicid'],
            iteration: e['iteration']))
        .toList();

    return blockList;
  }

  Future<List<Street>> viewAllStreetsApi(
      {required dynamicId, required type, required bearerToken}) async {
    print('Street aya');
    print(bearerToken);
    print(dynamicId);
    print(type);
    var response = await Dio().get(
        Api.streets + '/' + dynamicId.toString() + '/' + type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    streetList = (data as List)
        .map((e) => Street(
            id: e['id'],
            address: e['address'],
            dynamicId: e['dynamicid'],
            iteration: e['iteration'],
            subadminid: e['subadminid']))
        .toList();

    return streetList;
  }

  Future<List<House>> viewAllHousesApi(
      {required dynamicId, required bearerToken, required type}) async {
    print(bearerToken);
    print(dynamicId);

    var response = await Dio().get(
        Api.viewPropertiesForResidents +
            '/' +
            dynamicId.toString() +
            '/' +
            type.toString(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${bearerToken}"
        }));
    var data = response.data['data'];

    print(
      Api.viewPropertiesForResidents +
          '/' +
          dynamicId.toString() +
          '/' +
          type.toString(),
    );

    houseList = (data as List)
        .map((e) => House(
              id: e['id'],
              address: e['address'],
              dynamicid: e['dynamicid'],
              type: e['type'],
              iteration: e['iteration'],
            ))
        .toList();

    return houseList;
  }

  SelectedProperty(val) async {
    blocks = null;
    streets = null;

    measurementModel = null;

    blockList.clear();
    streetList.clear();
    houseList.clear();
    measurementList.clear();
    houseAddressDetailController.clear();

    update();
  }

  SelectedHouse(val) {
    houses = val;
    measurementList.clear();
    measurementModel = null;
    update();
  }

  SelectedSociety(val) async {
    phases = null;
    blocks = null;
    streets = null;
    houses = null;

    phaseList.clear();
    blockList.clear();
    streetList.clear();
    houseList.clear();
    houseAddressDetailController.clear();
    societies = val;

    update();
  }

  SelectedPhase(val) async {
    blocks = null;
    streets = null;
    houses = null;

    measurementModel = null;

    blockList.clear();
    streetList.clear();
    houseList.clear();

    measurementList.clear();
    houseAddressDetailController.clear();

    phases = val;

    update();
  }

  SelectedBlock(val) async {
    print('dropdown val $val');

    houses = null;
    streets = null;
    streetList.clear();
    houseList.clear();

    blocks = val;
    update();
  }

  SelectedStreet(val) async {
    print('dropdown val $val');
    houses = null;
    houseList.clear();

    houseAddressDetailController.clear();
    streets = val;

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

    measurementList = (data as List)
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

    return measurementList;
  }

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];

    print(resident.street);

    print(resident.society?.first.structuretype.runtimeType);
    if (resident.society?.first.structuretype == 1) {
      SelectedStreet(Street(
          id: resident.street?.first.id,
          address: resident.street?.first.address,
          dynamicId: resident.street?.first.dynamicid,
          iteration: resident.street?.first.iteration,
          subadminid: resident.street?.first.subadminid));
      SelectedHouse(House(
          type: resident.property?.first.type,
          id: resident.property?.first.id,
          address: resident.property?.first.address,
          dynamicid: resident.property?.first.dynamicid,
          iteration: resident.property?.first.iteration));
      SelectedMeasurement(Measurement(
          id: resident.measurement?.first.id,
          subadminid: resident.measurement?.first.subadminid,
          charges: resident.measurement?.first.charges,
          area: resident.measurement?.first.area,
          bedrooms: resident.measurement?.first.bedrooms,
          status: resident.measurement?.first.status,
          type: resident.measurement?.first.type,
          unit: resident.measurement?.first.unit));

      houseAddressDetailController.text =
          "${resident.society?.first.name}${','}${resident.street?.first.address}${','}${resident.property?.first.address.toString()}";
    } else if (resident.society?.first.structuretype == 2) {
      SelectedBlock(Block(
          id: resident.block?.first.id,
          address: resident.block?.first.address,
          iteration: resident.block?.first.iteration,
          dynamicId: resident.block?.first.dynamicid));
      SelectedStreet(Street(
          id: resident.street?.first.id,
          address: resident.street?.first.address,
          dynamicId: resident.street?.first.dynamicid,
          iteration: resident.street?.first.iteration,
          subadminid: resident.street?.first.subadminid));
      SelectedHouse(House(
          type: resident.property?.first.type,
          id: resident.property?.first.id,
          address: resident.property?.first.address,
          dynamicid: resident.property?.first.dynamicid,
          iteration: resident.property?.first.iteration));
      SelectedMeasurement(Measurement(
          id: resident.measurement?.first.id,
          subadminid: resident.measurement?.first.subadminid,
          charges: resident.measurement?.first.charges,
          area: resident.measurement?.first.area,
          bedrooms: resident.measurement?.first.bedrooms,
          status: resident.measurement?.first.status,
          type: resident.measurement?.first.type,
          unit: resident.measurement?.first.unit));

      houseAddressDetailController.text =
          "${resident.society?.first.name.toString()}${','}${resident.block?.first.address.toString()}${','}${resident.street?.first.address.toString()}${','}${resident.property?.first.address.toString()}";
    } else if (resident.society?.first.structuretype == 3) {
      SelectedPhase(Phase(
          id: resident.phase?.first.id,
          address: resident.phase?.first.address,
          subadminid: resident.phase?.first.subadminid,
          societyid: resident.phase?.first.societyid,
          iteration: resident.phase?.first.iteration,
          dynamicId: resident.phase?.first.dynamicid));
      SelectedBlock(Block(
          id: resident.block?.first.id,
          address: resident.block?.first.address,
          iteration: resident.block?.first.iteration,
          dynamicId: resident.block?.first.dynamicid));
      SelectedStreet(Street(
          id: resident.street?.first.id,
          address: resident.street?.first.address,
          dynamicId: resident.street?.first.dynamicid,
          iteration: resident.street?.first.iteration,
          subadminid: resident.street?.first.subadminid));
      SelectedHouse(House(
          type: resident.property?.first.type,
          id: resident.property?.first.id,
          address: resident.property?.first.address,
          dynamicid: resident.property?.first.dynamicid,
          iteration: resident.property?.first.iteration));
      SelectedMeasurement(Measurement(
          id: resident.measurement?.first.id,
          subadminid: resident.measurement?.first.subadminid,
          charges: resident.measurement?.first.charges,
          area: resident.measurement?.first.area,
          bedrooms: resident.measurement?.first.bedrooms,
          status: resident.measurement?.first.status,
          type: resident.measurement?.first.type,
          unit: resident.measurement?.first.unit));

      houseAddressDetailController.text =
          "${resident.society?.first.name}${','}${resident.phase?.first.address.toString()}${','}${resident.block?.first.address.toString()}${','}${resident.street?.first.address.toString()}${','}${resident.property?.first.address.toString()}";
    }
    if (resident.society?.first.structuretype == 5) {
      SelectedHouse(House(
          type: resident.property?.first.type,
          id: resident.property?.first.id,
          address: resident.property?.first.address,
          dynamicid: resident.property?.first.dynamicid,
          iteration: resident.property?.first.iteration));
      SelectedMeasurement(Measurement(
          id: resident.measurement?.first.id,
          subadminid: resident.measurement?.first.subadminid,
          charges: resident.measurement?.first.charges,
          area: resident.measurement?.first.area,
          bedrooms: resident.measurement?.first.bedrooms,
          status: resident.measurement?.first.status,
          type: resident.measurement?.first.type,
          unit: resident.measurement?.first.unit));
      houseAddressDetailController.text =
          "${resident.society?.first.name}${','} ${resident.property?.first.address.toString()}";
    }

    state = resident.state ?? "";
    city = resident.city ?? "";
    vehicleNoController.text = resident.vechileno ?? '';

    update();
  }

  Future verifyResidentApi({
    residentid,
    required int status,
    pid,
    bid,
    sid,
    propertyid,
    measurementid,
    vechileno,
    houseaddress,
    required String token,
  }) async {
    loading = true;
    update();
    final response = await Http.post(Uri.parse(Api.verifyHouseResident),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(<String, dynamic>{
          "residentid": residentid,
          "status": status,
          'pid': pid,
          'bid': bid,
          'sid': sid,
          'propertyid': propertyid,
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
      Get.snackbar('Something Went Wrong.', "");
      loading = false;
      update();
    }
  }

  SelectedMeasurement(val) {
    measurementModel = val;

    update();
  }
}

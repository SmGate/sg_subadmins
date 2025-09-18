import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/core/models/get_all_floors_model.dart';
import 'package:societyadminapp/core/service/floors_service.dart';
import '../../../../Model/User.dart';

class SocietyBuildingFloorsController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;

  String? noofphases;

  var allFloorsModel = GetAllFloorsModel();
  String error = "";

  int? buildingid;
  int apiCount = 0;
  late final User user;

  // late Future<SocietyBuildingFloor> futureFloors;

  late Future<GetAllFloorsModel> futureFloors;
  @override
  void onInit() {
    super.onInit();
    user = data[0];
    buildingid = data[1];

    futureFloors = FloorsApi(
      buildingid: buildingid!,
    );
  }

  // Future<SocietyBuildingFloor> FloorsApi(
  //     {required buildingid, required token}) async {
  //   print('count ${apiCount++}');
  //   print("${buildingid.toString()}");
  //   print(token);

  //   final response = await Http.get(
  //     Uri.parse(Api.viewSocietyBuildingFloors + "/" + buildingid.toString()),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': "Bearer $token"
  //     },
  //   );

  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     return SocietyBuildingFloor.fromJson(data);
  //   }

  //   return SocietyBuildingFloor.fromJson(data);
  // }

  Future<GetAllFloorsModel> FloorsApi({
    required buildingid,
  }) async {
    error = "";

    var res = await AddFloorsService.getBuilDIngFloors(buildingId: buildingid);

    if (res is GetAllFloorsModel) {
      allFloorsModel = res;
      return allFloorsModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return allFloorsModel;
  }
}

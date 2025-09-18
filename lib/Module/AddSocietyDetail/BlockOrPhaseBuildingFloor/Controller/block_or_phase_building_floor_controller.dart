import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/core/models/get_all_floors_model.dart';
import 'package:societyadminapp/core/service/floors_service.dart';
import '../../../../Model/User.dart';

class BlockOrPhaseBuildingFloorsController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;

  String? noofphases;

  int? buildingid;
  int? dynamicid;

  late final User user;
  final List<TextEditingController> fromController = [];
  final List<TextEditingController> toController = [];
  List<Map<String, dynamic>> myApiData = [];
  bool isLoading = false;

  var allFloorsModel = GetAllFloorsModel();
  String error = "";
  @override
  void onInit() {
    super.onInit();
    user = data[0];
    buildingid = data[1];
    dynamicid = data[2];
  }

  // Future<BlockOrPhaseBuildingFloor> FloorsApi(
  //     {required buildingid, required token}) async {
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
  //     return BlockOrPhaseBuildingFloor.fromJson(data);
  //   }

  //   return BlockOrPhaseBuildingFloor.fromJson(data);
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

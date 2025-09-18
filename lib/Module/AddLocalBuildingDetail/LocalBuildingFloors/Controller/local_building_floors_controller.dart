import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/core/models/get_all_floors_model.dart';
import 'package:societyadminapp/core/service/floors_service.dart';
import '../../../../Model/User.dart';

class LocalBuildingFloorsController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var data = Get.arguments;

  String? noofphases;

  int? buildingid;
  late final User user;
  final List<TextEditingController> fromController = [];
  final List<TextEditingController> toController = [];
  List<Map<String, dynamic>> myApiData = [];
  bool isLoading = false;

  ///
  var allFloorsModel = GetAllFloorsModel();
  String error = "";
  @override
  void onInit() {
    super.onInit();
    user = data;
  }

  // Future<LocalBuildingFloor> FloorsApi(
  //     {required buildingid, required token}) async {
  //   print("${buildingid.toString()}");
  //   print(token);

  //   final response = await Http.get(
  //     Uri.parse(Api.viewLocalBuildingFloors + "/" + buildingid.toString()),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': "Bearer $token"
  //     },
  //   );

  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     return LocalBuildingFloor.fromJson(data);
  //   }

  //   return LocalBuildingFloor.fromJson(data);
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

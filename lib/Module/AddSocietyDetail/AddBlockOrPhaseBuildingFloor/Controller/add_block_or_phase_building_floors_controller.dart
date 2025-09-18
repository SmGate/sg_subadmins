import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_society_buildings_model.dart';
import 'package:societyadminapp/Module/ShortTermRental/service/add_short_term_rental_service.dart';
import 'package:societyadminapp/core/models/add_floors_model.dart';
import 'package:societyadminapp/core/service/floors_service.dart';
import '../../../../Model/User.dart';

class AAddBlockOrPhaseBuildingFloorsController extends GetxController {
  var data = Get.arguments;
  int? index;
  int? buildingid;
  int? dynamicid;

  var bearertoken;
  late final User user;

  bool isLoading = false;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  RxList<SocietyBuilding> societyBuildings = <SocietyBuilding>[].obs;
  RxInt selectedBuildingId = 0.obs;

  RxBool loadingBuildings = false.obs;
  final floorTypes = ['Residential', 'Corporate', 'Commercial'];
  final selectedFloorType = ''.obs; // Default empty or set to a default value

  @override
  void onInit() {
    super.onInit();

    user = data[0];
    buildingid = data[1];
    dynamicid = data[2];

    fetchBuildings();
  }

  final fromController = TextEditingController();
  final toController = TextEditingController();

  TextEditingController customFloorsController = TextEditingController();

  //============ ADD FLOORS NEW DATA
  var loadingAddingFloors = false.obs;
  String error = "";
  var addFloorsModel = FloorResponse();

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

  void addFloors({
    String? buildingId,
    String? name,
    String? category,
    String? from,
    String? to,
  }) async {
    error = "";
    loadingAddingFloors.value = true;

    var res = await AddFloorsService.addFloors(
        buildingId: buildingId,
        name: name,
        category: category,
        from: from,
        to: to);

    loadingAddingFloors.value = false;

    if (res is FloorResponse) {
      addFloorsModel = res;
      Get.snackbar("Message", addFloorsModel.message.toString());
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
      loadingAddingFloors.value = false;
    }
  }

  // addSocietybuildingFloorsApi({
  //   required String bearerToken,
  //   required int buildingid,
  //   required String from,
  //   required String to,
  // }) async {
  //   isLoading = true;
  //   update();

  //   Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
  //   var request =
  //       Http.MultipartRequest('POST', Uri.parse(Api.addSocietyBuildingFloors));
  //   request.headers.addAll(headers);

  //   request.fields['from'] = from;
  //   request.fields['to'] = to;

  //   request.fields['buildingid'] = buildingid.toString();

  //   var responsed = await request.send();
  //   var response = await Http.Response.fromStream(responsed);

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body.toString());
  //     print(data);
  //     print(response.body);
  //     Get.snackbar("Floors Add Successfully", "");

  //     Get.offAndToNamed(blockorphasebuildingfloorsscreen,
  //         arguments: [user, buildingid, dynamicid]);

  //     isLoading = false;
  //     update();
  //   } else if (response.statusCode == 403) {
  //     var data = jsonDecode(response.body.toString());

  //     Get.snackbar(
  //       "Error",
  //       data.toString(),
  //     );

  //     isLoading = false;
  //     update();
  //   } else {
  //     Get.snackbar("Failed to Add Phases", "");
  //     isLoading = false;
  //     update();
  //   }
  // }
}

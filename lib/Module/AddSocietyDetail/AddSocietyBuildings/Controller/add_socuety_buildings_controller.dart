// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as Http;
// import 'package:societyadminapp/Module/AddSocietyDetail/AddSocietyBuildings/model/get_all_subadmin_model.dart';
// import 'package:societyadminapp/Routes/set_routes.dart';

// import '../../../../utils/Constants/api_routes.dart';
// import '../../../../Model/User.dart';

// class AddSocietyBuildingController extends GetxController {
//   var data = Get.arguments;
//   late final User user;
//   bool isLoading = false;
//   GlobalKey<FormState> formKey = new GlobalKey<FormState>();

//   final societyBuildingNameController = TextEditingController();

//   List<SubAdminData> subAdmins = [];
//   int? selectedSubAdminId;

//   @override
//   void onInit() {
//     super.onInit();
//     user = data;
//   }

//   addSocietyBuildingApi({
//     required String bearerToken,
//     required int subadminid,
//     required int societyid,
//     required int superadminid,
//     required int dynamicid,
//     required String BuildingName,
//     required String type,
//   }) async {
//     print(bearerToken);

//     print(BuildingName);

//     isLoading = true;
//     update();

//     Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
//     var request =
//         Http.MultipartRequest('POST', Uri.parse(Api.addSocietyBuilding));
//     request.headers.addAll(headers);
//     request.fields['societybuildingname'] = BuildingName;
//     request.fields['subadminid'] = subadminid.toString();
//     request.fields['societyid'] = societyid.toString();
//     request.fields['superadminid'] = superadminid.toString();
//     request.fields['dynamicid'] = dynamicid.toString();
//     request.fields['type'] = type;

//     var responsed = await request.send();
//     var response = await Http.Response.fromStream(responsed);

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body.toString());
//       print(data);
//       print(response.body);
//       Get.snackbar("Building Addedd Successfully", "");
//       Get.offAndToNamed(societybuildingscreen, arguments: user);

//       isLoading = false;
//       update();
//     } else if (response.statusCode == 403) {
//       var data = jsonDecode(response.body.toString());

//       Get.snackbar(
//         "Error",
//         data.toString(),
//       );

//       isLoading = false;
//       update();
//     } else {
//       Get.snackbar("Failed to Add Blocks", "");

//       isLoading = false;
//       update();
//     }
//   }

//   Future<GetAllSubAdminModel> getAllSubadmin({
//     required int subadmin,
//     required String token,
//   }) async {
//     final response = await Http.get(
//       Uri.parse(Api.getAllAdmins + "/" + subadmin.toString()),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': "Bearer $token"
//       },
//     );

//     var data = jsonDecode(response.body.toString());

//     if (response.statusCode == 200) {
//       print(response.body);

//       return GetAllSubAdminModel.fromJson(data);
//     }

//     return GetAllSubAdminModel.fromJson(data);
//   }
// }

// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/AddSocietyDetail/AddSocietyBuildings/model/get_all_subadmin_model.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

class AddSocietyBuildingController extends GetxController {
  var data = Get.arguments;
  late final User user;
  bool isLoading = false; // button loading
  bool isSubAdminsLoading = false; // dropdown loading

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final societyBuildingNameController = TextEditingController();

  List<SubAdminData> subAdmins = [];
  int? selectedSubAdminId;

  @override
  void onInit() {
    super.onInit();
    user = data;

    // Prefetch sub-admins
    _loadSubAdmins(
      societyId: user.societyid ?? 0,
      token: user.bearerToken ?? '',
    );
  }

  @override
  void onClose() {
    societyBuildingNameController.dispose();
    super.onClose();
  }

  // Dropdown selection handling removed (no subadmin assignment on add)

  Future<void> _loadSubAdmins({
    required int societyId,
    required String token,
  }) async {
    isSubAdminsLoading = true;
    update();

    try {
      final response = await Http.get(
        Uri.parse('${Api.getAllAdmins}/$societyId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      final body = jsonDecode(response.body.toString());

      // Parse regardless; backend might still send a valid payload with 200
      final model = GetAllSubAdminModel.fromJson(body);

      if (response.statusCode == 200 && (model.data != null)) {
        subAdmins = model.data!;
      } else {
        subAdmins = [];
        selectedSubAdminId = null;
      }
    } catch (e) {
      subAdmins = [];
      selectedSubAdminId = null;
    } finally {
      isSubAdminsLoading = false;
      update();
    }
  }

  addSocietyBuildingApi({
    required String bearerToken,
    required int societyid,
    required int superadminid,
    required int dynamicid,
    required String BuildingName,
    required String type,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};
    var request =
        Http.MultipartRequest('POST', Uri.parse(Api.addSocietyBuilding));
    request.headers.addAll(headers);
    request.fields['societybuildingname'] = BuildingName;
    // Send current user's userid as subadminid
    if (user.userid != null) {
      request.fields['subadminid'] = user.userid!.toString();
    }
    request.fields['societyid'] = societyid.toString();
    request.fields['superadminid'] = superadminid.toString();
    request.fields['dynamicid'] = dynamicid.toString();
    request.fields['type'] = type;

    try {
      var responsed = await request.send();
      var response = await Http.Response.fromStream(responsed);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body.toString());
        Get.snackbar("Building Addedd Successfully", "");
        Get.offAndToNamed(societybuildingscreen, arguments: user);
      } else if (response.statusCode == 403) {
        final res = jsonDecode(response.body.toString());
        Get.snackbar("Error", res.toString());
      } else {
        Get.snackbar("Failed to Add Blocks", "");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}

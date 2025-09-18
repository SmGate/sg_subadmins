// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:societyadminapp/Routes/set_routes.dart';
// import '../../component/Cutom_Add_Building_Screen.dart';
// import '../Controller/add_socuety_buildings_controller.dart';

// class AddSocietyBuildingScreen extends GetView {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AddSocietyBuildingController>(
//         init: AddSocietyBuildingController(),
//         builder: (controller) {
//           return WillPopScope(
//             onWillPop: () async {
//               Get.offAndToNamed(societybuildingscreen,
//                   arguments: controller.user);

//               return false;
//             },
//             child: SafeArea(
//               child: Scaffold(
//                   body: AddBuildingCustomScreen(
//                 fKey: controller.formKey,
//                 appBarText: 'Add Society Building',
//                 backonTap: () {
//                   Get.offAndToNamed(societybuildingscreen,
//                       arguments: controller.user);
//                 },
//                 nameController: controller.societyBuildingNameController,
//                 buttonLoading: controller.isLoading,
//                 buttonOnPressed: () {
//                   if (!controller.isLoading) {
//                     String type;
//                     if (controller.user.structureType == 1) {
//                       type = 'street society building';
//                     } else if (controller.user.structureType == 2) {
//                       type = 'block society building';
//                     } else if (controller.user.structureType == 6) {
//                       type = 'building floor building';
//                     } else {
//                       type = 'phase society building';
//                     }

//                     controller.addSocietyBuildingApi(
//                         dynamicid: controller.user.societyid!,
//                         societyid: controller.user.societyid!,
//                         subadminid: controller.user.userid!,
//                         superadminid: controller.user.superadminid!,
//                         bearerToken: controller.user.bearerToken!,
//                         BuildingName: controller
//                             .societyBuildingNameController.text
//                             .toString(),
//                         type: type);
//                   }
//                 },
//               )),
//             ),
//           );
//         });
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import '../../component/Cutom_Add_Building_Screen.dart';
import '../Controller/add_socuety_buildings_controller.dart';

class AddSocietyBuildingScreen extends GetView<AddSocietyBuildingController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSocietyBuildingController>(
      init: AddSocietyBuildingController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            Get.offAndToNamed(societybuildingscreen,
                arguments: controller.user);
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: AddBuildingCustomScreen(
                fKey: controller.formKey,
                appBarText: 'Add Society Building',
                backonTap: () {
                  Get.offAndToNamed(societybuildingscreen,
                      arguments: controller.user);
                },
                nameController: controller.societyBuildingNameController,
                buttonLoading: controller.isLoading,
                // NEW ↓↓↓ pass dropdown data
                subAdmins: controller.subAdmins,
                isSubAdminsLoading: controller.isSubAdminsLoading,
                selectedSubAdminId: controller.selectedSubAdminId,
                onSelectSubAdmin: controller.onSelectSubAdmin,
                // ↑↑↑

                buttonOnPressed: () {
                  if (!controller.isLoading) {
                    String type;
                    if (controller.user.structureType == 1) {
                      type = 'street society building';
                    } else if (controller.user.structureType == 2) {
                      type = 'block society building';
                    } else if (controller.user.structureType == 6) {
                      type = 'building floor building';
                    } else {
                      type = 'phase society building';
                    }

                    // Use selectedSubAdminId if chosen; otherwise keep previous behavior
                    final subadminIdToSend = controller.selectedSubAdminId ??
                        controller.user.userid!;

                    controller.addSocietyBuildingApi(
                      dynamicid: controller.user.societyid!,
                      societyid: controller.user.societyid!,
                      subadminid: subadminIdToSend,
                      superadminid: controller.user.superadminid!,
                      bearerToken: controller.user.bearerToken!,
                      BuildingName:
                          controller.societyBuildingNameController.text.trim(),
                      type: type,
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

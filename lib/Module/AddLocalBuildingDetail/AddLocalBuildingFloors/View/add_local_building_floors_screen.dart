// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Routes/set_routes.dart';
import '../../../AddSocietyDetail/component/Cutom_Add_Building_Floor_Screen.dart';
import '../Controller/add_local_building_floors_controller.dart';

class AddLocalBuildingFloors extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocalBuildingFloorsController>(
        init: AddLocalBuildingFloorsController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offAndToNamed(localbuildingfloorsscreen,
                    arguments: controller.user);

                return true;
              },
              child: AddBuildingFloorCustom(
                fKey: controller.formKey,
                backonTap: () {
                  Get.offAndToNamed(localbuildingfloorsscreen,
                      arguments: controller.user);
                },
                fromController: controller.fromController,
                toController: controller.toController,
                buttonLoading: controller.loadingAddingFloors,
                // Dropdown: Floor Type
                floorTypes: controller.floorTypes,
                selectedFloorType: controller.selectedFloorType,
                onFloorTypeChanged: (value) =>
                    controller.selectedFloorType.value = value!,

                // Dropdown: Building
                buildings: controller.societyBuildings,
                selectedBuildingId: controller.selectedBuildingId,
                onBuildingChanged: (value) =>
                    controller.selectedBuildingId.value = value!,

                // Custom Floor Field
                customFloorsController: controller.customFloorsController,

                // Loading state for building dropdown
                loadingBuildings: controller.loadingBuildings,
                buttonOnPressed: () {
                  controller.addFloors(
                    buildingId: controller.selectedBuildingId.value.toString(),
                    name: controller.customFloorsController.text,
                    category: controller.selectedFloorType.value,
                    from: controller.fromController.text.toString(),
                    to: controller.toController.text.toString(),
                  );

                  // addLocalbuildingFloorsApi(
                  //   bearerToken: controller.user.bearerToken!,
                  //   from: controller.fromController.text.toString(),
                  //   to: controller.toController.text.toString(),
                  //   buildingid: controller.user.societyid!,
                  //   subadminid: controller.user.userid!,
                  // );
                },
              ));
        });
  }
}

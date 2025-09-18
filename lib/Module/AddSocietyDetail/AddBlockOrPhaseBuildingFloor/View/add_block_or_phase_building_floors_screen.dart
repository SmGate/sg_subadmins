// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Routes/set_routes.dart';
import '../../component/Cutom_Add_Building_Floor_Screen.dart';
import '../Controller/add_block_or_phase_building_floors_controller.dart';

class AddBlockOrPhaseBuildingFloors extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AAddBlockOrPhaseBuildingFloorsController>(
        init: AAddBlockOrPhaseBuildingFloorsController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offAndToNamed(blockorphasebuildingfloorsscreen, arguments: [
                  controller.user,
                  controller.buildingid,
                  controller.dynamicid
                ]);

                return false;
              },
              child: AddBuildingFloorCustom(
                fKey: controller.formKey,
                backonTap: () {
                  Get.offAndToNamed(blockorphasebuildingfloorsscreen,
                      arguments: [
                        controller.user,
                        controller.buildingid,
                        controller.dynamicid
                      ]);
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

                  // if (!controller.isLoading) {
                  //   controller.addSocietybuildingFloorsApi(
                  //       bearerToken: controller.user.bearerToken!,
                  //       from: controller.fromController.text.toString(),
                  //       to: controller.toController.text.toString(),
                  //       buildingid: controller.buildingid!);
                  // }
                },
              ));
        });
  }
}

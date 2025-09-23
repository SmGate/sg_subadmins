// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Routes/set_routes.dart';
import '../../component/Cutom_Add_Building_Floor_Screen.dart';
import '../Controller/add_society_building_floor_controller.dart';
import '../../../../utils/Constants/session_controller.dart';

class AddSocietyBuildingFloors extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSocietyBuildingFloorsController>(
        init: AddSocietyBuildingFloorsController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offAndToNamed(societybuildingfloorsscreen,
                    arguments: [controller.user, controller.buildingid]);

                return false;
              },
              child: AddBuildingFloorCustom(
                fKey: controller.formKey,
                backonTap: () {
                  Get.offAndToNamed(societybuildingfloorsscreen,
                      arguments: [controller.user, controller.buildingid]);
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
                  final String selectedType =
                      controller.selectedFloorType.value;
                  if (selectedType.isEmpty || selectedType == 'Floor Type') {
                    Get.snackbar(
                        'Validation', 'Select floor type from dropdown');
                    return;
                  }
                  final String bid = SessionController().selectedBuildingId;
                  if (bid.isEmpty) {
                    Get.snackbar('Validation', 'No building selected');
                    return;
                  }
                  controller.addFloors(
                    buildingId: bid,
                    name: controller.customFloorsController.text,
                    category: controller.selectedFloorType.value,
                    from: controller.fromController.text.toString(),
                    to: controller.toController.text.toString(),
                  );
                },
              ));
        });
  }
}

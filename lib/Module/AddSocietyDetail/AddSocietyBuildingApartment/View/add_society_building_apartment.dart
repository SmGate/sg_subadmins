// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Routes/set_routes.dart';
import '../../component/Cutom_Add_Building_Apartment_Screen.dart';
import '../Controller/add_society_building_controller.dart';

class AddSocietyBuildingApartmentsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSocietyBuildingApartmentsController>(
        init: AddSocietyBuildingApartmentsController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offAndToNamed(societybuildingapartmentscreen, arguments: [
                  controller.user,
                  controller.fid,
                  controller.bid
                ]);

                return false;
              },
              child: AddBuildingApartmentCustom(
                fKey: controller.formKey,
                backonTap: () {
                  Get.offAndToNamed(societybuildingapartmentscreen, arguments: [
                    controller.user,
                    controller.fid,
                    controller.bid
                  ]);
                },
                fromController: controller.fromController,
                toController: controller.toController,
                buttonLoading: controller.isLoading,
                floorCategory: (controller.argumnet is List &&
                        controller.argumnet.length > 3)
                    ? controller.argumnet[3]?.toString()
                    : null,
                onSubmit: (
                    {String? name,
                    required String from,
                    required String to,
                    required int typeId,
                    required String type}) {
                  if (controller.isLoading) return;
                  debugPrint(
                      'Submit Apartments -> typeId: $typeId, type: $type, name: $name, from:$from to:$to');
                  controller.addApartmentsApi(
                    bearerToken: controller.user.bearerToken!,
                    from: from,
                    to: to,
                    fid: controller.fid!,
                    name: name,
                    typeId: typeId,
                    type: type,
                  );
                },
              ));
        });
  }
}

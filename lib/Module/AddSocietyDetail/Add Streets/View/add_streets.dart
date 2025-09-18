// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Streets/Controller/add_streets_controller.dart';

import '../../../../Routes/set_routes.dart';
import '../../component/custom_add_screen.dart';

class AddStreets extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStreetsController>(
        init: AddStreetsController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.user.structureType == 1) {
                Get.offAndToNamed(streets, arguments: controller.user);
              } else if (controller.user.structureType == 2) {
                Get.offAndToNamed(streets,
                    arguments: [controller.user, controller.blockid]);
              } else if (controller.user.structureType == 3) {
                Get.offAndToNamed(streets, arguments: [
                  controller.user,
                  controller.blockid,
                  controller.phaseid
                ]);
              }

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                body: CustomAddScreen(
                  fKey: controller.formKey,
                  appBarText: 'Add Streets',
                  backonTap: () {
                    if (controller.user.structureType == 1) {
                      Get.offAndToNamed(streets, arguments: controller.user);
                    } else if (controller.user.structureType == 2) {
                      Get.offAndToNamed(streets,
                          arguments: [controller.user, controller.blockid]);
                    } else if (controller.user.structureType == 3) {
                      Get.offAndToNamed(streets, arguments: [
                        controller.user,
                        controller.blockid,
                        controller.phaseid
                      ]);
                    }
                  },
                  nameController: controller.addressController,
                  from: 'From',
                  to: 'To',
                  fromImg: 'assets/addstreetsvg.svg',
                  toImg: 'assets/addstreetsvg.svg',
                  fromController: controller.fromController,
                  toController: controller.toController,
                  buttonLoading: controller.isLoading,
                  buttonOnPressed: () {
                    // print(controller.user.userid);
                    // print(controller.user.bearerToken);
                    if (controller.user.structureType == 1) {
                      if (!controller.isLoading) {
                        controller.addStreetsApi(
                          address: controller.addressController.text,
                          dynamicid: controller.user.societyid!,
                          societyid: controller.user.societyid!,
                          subadminid: controller.user.userid!,
                          superadminid: controller.user.superadminid!,
                          bearerToken: controller.user.bearerToken!,
                          from: controller.fromController.text.toString(),
                          to: controller.toController.text.toString(),
                        );
                      }
                    } else {
                      if (!controller.isLoading) {
                        controller.addStreetsApi(
                          address: controller.addressController.text,
                          dynamicid: controller.blockid!,
                          societyid: controller.user.societyid!,
                          subadminid: controller.user.userid!,
                          superadminid: controller.user.superadminid!,
                          bearerToken: controller.user.bearerToken!,
                          from: controller.fromController.text.toString(),
                          to: controller.toController.text.toString(),
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}

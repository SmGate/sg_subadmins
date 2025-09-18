// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Houses/Controller/add_houses_controller.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../../Routes/set_routes.dart';
import '../../component/custom_add_screen.dart';

class AddHouses extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<AddHousesController>(
            init: AddHousesController(),
            builder: (controller) {
              return WillPopScope(
                  onWillPop: () async {
                    if (controller.user.structureType == 5) {
                      Get.offNamed(houses, arguments: controller.user);
                    } else if (controller.user.structureType == 1) {
                      Get.offNamed(houses,
                          arguments: [controller.user, controller.streetid]);
                    } else if (controller.user.structureType == 2) {
                      Get.offNamed(houses, arguments: [
                        controller.user,
                        controller.streetid,
                        controller.blockid
                      ]);
                    } else if (controller.user.structureType == 3) {
                      Get.offNamed(houses, arguments: [
                        controller.user,
                        controller.streetid,
                        controller.blockid,
                        controller.phaseid
                      ]);
                    }
                    return false;
                  },
                  child: CustomAddScreen(
                    fKey: controller.formKey,
                    appBarText: 'Add Houses',
                    backonTap: () {
                      if (controller.user.structureType == 5) {
                        Get.offNamed(houses, arguments: controller.user);
                      } else if (controller.user.structureType == 1) {
                        Get.offNamed(houses,
                            arguments: [controller.user, controller.streetid]);
                      } else if (controller.user.structureType == 2) {
                        Get.offNamed(houses, arguments: [
                          controller.user,
                          controller.streetid,
                          controller.blockid
                        ]);
                      } else if (controller.user.structureType == 3) {
                        Get.offNamed(houses, arguments: [
                          controller.user,
                          controller.streetid,
                          controller.blockid,
                          controller.phaseid
                        ]);
                      }
                    },
                    nameController: controller.addressController,
                    from: 'From',
                    to: 'To',
                    fromImg: 'assets/addhousesvg.svg',
                    toImg: 'assets/addhousesvg.svg',
                    fromController: controller.fromController,
                    toController: controller.toController,
                    buttonLoading: controller.isLoading,
                    buttonOnPressed: () {
                      if (!controller.isLoading) {
                        if (controller.user.structureType == 5) {
                          controller.addHousesApi(
                            societyid: controller.user.societyid!,
                            subadminid: controller.user.userid!,
                            superadminid: controller.user.superadminid!,
                            address:
                                controller.addressController.text.toString(),
                            bearerToken: controller.user.bearerToken!,
                            from: controller.fromController.text.toString(),
                            to: controller.toController.text.toString(),
                            dynamicid: controller.user.societyid!,
                          );
                        } else {
                          if (!controller.isLoading) {
                            controller.addHousesApi(
                              societyid: controller.user.societyid!,
                              subadminid: controller.user.userid!,
                              superadminid: controller.user.superadminid!,
                              address:
                                  controller.addressController.text.toString(),
                              bearerToken: controller.user.bearerToken!,
                              from: controller.fromController.text.toString(),
                              to: controller.toController.text.toString(),
                              dynamicid: controller.streetid!,
                            );
                          }
                        }
                      }
                    },
                  ));
            }),
      ),
    );
  }
}

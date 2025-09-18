// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../../Routes/set_routes.dart';
import '../../component/custom_add_screen.dart';
import '../Controller/add_phases_controller.dart';

class AddPhases extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<AddPhasesController>(
            init: AddPhasesController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(phasess, arguments: controller.user);

                  return false;
                },
                child: CustomAddScreen(
                  fKey: controller.formKey,
                  appBarText: 'Add Phases',
                  backonTap: () {
                    Get.offNamed(phasess, arguments: controller.user);
                  },
                  nameController: controller.addressController,
                  from: 'From',
                  to: 'To',
                  fromImg: 'assets/addphasesvg.svg',
                  toImg: 'assets/addphasesvg.svg',
                  fromController: controller.fromController,
                  toController: controller.toController,
                  buttonLoading: controller.isLoading,
                  buttonOnPressed: () {
                    // print(controller.user.userid);
                    // print(controller.user.bearerToken);
                    print(controller.user.societyid);
                    if (!controller.isLoading) {
                      controller.addPhaseApi(
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
                  },
                ),
              );
            }),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Blocks/Controller/add_block_controller.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../../Routes/set_routes.dart';
import '../../component/custom_add_screen.dart';

class AddBlocks extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBlockController>(
        init: AddBlockController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.user.structureType == 2) {
                Get.offNamed(blocks, arguments: controller.user);
              } else {
                Get.offNamed(blocks,
                    arguments: [controller.user, controller.phaseid]);
              }
              return false;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: CustomAddScreen(
                  fKey: controller.formKey,
                  appBarText: 'Add Blocks',
                  backonTap: () {
                    if (controller.user.structureType == 2) {
                      Get.offNamed(blocks, arguments: controller.user);
                    } else {
                      Get.offNamed(blocks,
                          arguments: [controller.user, controller.phaseid]);
                    }
                  },
                  nameController: controller.addressController,
                  from: 'From',
                  to: 'To',
                  fromImg: 'assets/addblocksvg.svg',
                  toImg: 'assets/addblocksvg.svg',
                  fromController: controller.fromController,
                  toController: controller.toController,
                  buttonLoading: controller.isLoading,
                  buttonOnPressed: () {
                    print('save button');
                    // print(controller.user.bearerToken);
                    if (controller.user.structureType == 2) {
                      if (!controller.isLoading) {
                        controller.addBlocksApi(
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
                      print('idhr aaaa');
                      if (!controller.isLoading) {
                        controller.addBlocksApi(
                          address: controller.addressController.text,
                          dynamicid: controller.phaseid!,
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

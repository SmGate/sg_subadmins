// // ignore_for_file: deprecated_member_use

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';

import 'package:societyadminapp/Widgets/my_back_button.dart';
import '../../../../Routes/set_routes.dart';
import '../../component/Custom_Grid.dart';
import '../Controller/block_or_society_building_controller.dart';

class BlockOrSocietyBuilding extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockOrSocietyBuildingController>(
        init: BlockOrSocietyBuildingController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offAndToNamed(homescreen, arguments: controller.user);

              return true;
            },
            child: SafeArea(
              child: Scaffold(
                  body: Column(children: [
                MyBackButton(
                  text: 'Block Or Building',
                  onTap: () {
                    Get.offAndToNamed(homescreen, arguments: controller.user);
                  },
                ),
                16.ph,
                Expanded(
                  child: GridView(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                    ),
                    children: controller.user.structureType == 6
                        ? [
                            CustomGrid(
                              onTap: () async {
                                Get.offAndToNamed(societybuildingscreen,
                                    arguments: controller.user);
                              },
                              text: 'Add Buildings',
                            ),
                          ]
                        : [
                            CustomGrid(
                              onTap: () async {
                                Get.toNamed(blocks, arguments: controller.user);
                              },
                              text: 'Add Blocks',
                            ),
                            CustomGrid(
                              onTap: () async {
                                Get.offAndToNamed(societybuildingscreen,
                                    arguments: controller.user);
                              },
                              text: 'Add Buildings',
                            ),
                          ],
                  ),
                ),
              ])),
            ),
          );
        });
  }
}

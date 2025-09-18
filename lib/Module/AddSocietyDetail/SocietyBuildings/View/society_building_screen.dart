// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/component/Custom_Grid.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Widgets/My_Floating_Button.dart';
import '../Controller/society_building_controller.dart';

class SocietyBuildingScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocietyBuildingController>(
        init: SocietyBuildingController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.user.structureType == 1) {
                Get.offAndToNamed(streetorbuildingscreen,
                    arguments: controller.user);
              } else if (controller.user.structureType == 2) {
                Get.offAndToNamed(blockorsocietybuilding,
                    arguments: controller.user);
              } else if (controller.user.structureType == 3) {
                Get.offAndToNamed(phaseorsocietybuilding,
                    arguments: controller.user);
              } else if (controller.user.structureType == 5) {
                Get.offAndToNamed(structureType5HouseOrBuildingMiddlewareScreen,
                    arguments: controller.user);
              } else if (controller.user.structureType == 6) {
                Get.offAndToNamed(homescreen, arguments: controller.user);
              }

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.background,
                  floatingActionButton: MyFloatingButton(onPressed: () {
                    Get.offAndToNamed(addsocietybuildingscreen,
                        arguments: controller.user);
                  }),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyBackButton(
                        onTap: () {
                          if (controller.user.structureType == 1) {
                            Get.offAndToNamed(streetorbuildingscreen,
                                arguments: controller.user);
                          } else if (controller.user.structureType == 2) {
                            Get.offAndToNamed(blockorsocietybuilding,
                                arguments: controller.user);
                          } else if (controller.user.structureType == 3) {
                            Get.offAndToNamed(phaseorsocietybuilding,
                                arguments: controller.user);
                          } else if (controller.user.structureType == 5) {
                            Get.offAndToNamed(
                                structureType5HouseOrBuildingMiddlewareScreen,
                                arguments: controller.user);
                          } else if (controller.user.structureType == 6) {
                            Get.offAndToNamed(homescreen,
                                arguments: controller.user);
                          }
                        },
                        text: 'Buildings',
                      ),
                      32.ph,
                      Expanded(
                          child: FutureBuilder(
                              future: controller.societyBuildingApi(
                                  dynamicid: controller.user.structureType == 6
                                      ? controller.user.userid ?? 0
                                      : controller.user.societyid ?? 0,
                                  token: controller.user.bearerToken!),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                    padding: EdgeInsets.only(
                                        left: 28.w, right: 27.w),
                                    itemCount: snapshot.data.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 35,
                                            mainAxisSpacing: 15),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomGrid(
                                        onTap: () async {
                                          Get.offAndToNamed(
                                              societybuildingfloorsscreen,
                                              arguments: [
                                                controller.user,
                                                snapshot.data.data[index].id,
                                              ]);
                                        },
                                        text: snapshot.data.data[index]
                                            .societybuildingname,
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Icon(Icons.error_outline);
                                } else {
                                  return Center(
                                      child: CircularIndicatorUnderWhiteBox());
                                }
                              })),
                    ],
                  )),
            ),
          );
        });
  }
}

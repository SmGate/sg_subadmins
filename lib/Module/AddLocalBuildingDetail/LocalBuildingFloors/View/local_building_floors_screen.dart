// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Widgets/My_Floating_Button.dart';
import '../../../AddSocietyDetail/component/Custom_List.dart';
import '../Controller/local_building_floors_controller.dart';

class LocalBuildingFloorsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalBuildingFloorsController>(
        init: LocalBuildingFloorsController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offAndToNamed(localbuildingscreen,
                  arguments: controller.user);

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                  floatingActionButton: MyFloatingButton(onPressed: () {
                    Get.offAndToNamed(
                      addlocalbuildingfloors,
                      arguments: controller.user,
                    );
                  }),
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Floors',
                        onTap: () {
                          Get.offAndToNamed(localbuildingscreen,
                              arguments: controller.user);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: FutureBuilder(
                              future: controller.FloorsApi(
                                buildingid: controller.user.societyid ?? 0,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomList(
                                        onTap: () {
                                          Get.offAndToNamed(
                                              localbuildingapartmentscreen,
                                              arguments: [
                                                controller.user,
                                                snapshot.data.data[index].id,
                                              ]);
                                        },
                                        text: controller.allFloorsModel
                                                .data?[index].name ??
                                            "",
                                        text2: controller
                                                .allFloorsModel
                                                .data?[index]
                                                .building
                                                ?.societybuildingname ??
                                            "",
                                        text3: controller.allFloorsModel
                                                .data?[index].category ??
                                            "",
                                        label2: "Building",
                                        label3: "Floor Type",
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Icon(Icons.error_outline);
                                } else {
                                  return CircularIndicatorUnderWhiteBox();
                                }
                              })),
                    ],
                  )),
            ),
          );
        });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:societyadminapp/Module/parking%20managment/controller/parking_management_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../../Widgets/my_back_button.dart';

class AddAndAssignParking extends StatelessWidget {
  const AddAndAssignParking({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ParkingManagementController>();
//////////////////////

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(assignedParking, arguments: controller.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                MyBackButton(
                  text: "Add Parking",
                  onTap: () {
                    Get.offNamed(assignedParking, arguments: controller.user);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Card(
                      elevation: 0,
                      child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Add Parking",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 18.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                controller:
                                    controller.parkingAreaNameController,
                                validator: emptyStringValidator,
                                hintText: 'Parking Area Name',
                                labelText: 'Parking Area Name',
                              ),
                              MyTextFormField(
                                controller: controller.slotsContingController,
                                validator: emptyStringValidator,
                                hintText: 'Number Of Slots',
                                labelText: 'Number Of Slots',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Obx(() => MyButton(
                                      loading: controller
                                          .loadingAddingParkingData.value,
                                      gradient: AppGradients.buttonGradient,
                                      name: "Add",
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.addParking(
                                              societyId: controller
                                                  .user.societyid
                                                  .toString(),
                                              parkingAreaName: controller
                                                  .parkingAreaNameController
                                                  .text,
                                              totalSlots: controller
                                                  .slotsContingController.text,
                                              subadminId: controller.user.userid
                                                  .toString());
                                        }
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

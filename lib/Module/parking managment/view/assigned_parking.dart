// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/parking%20managment/controller/parking_management_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/My_Floating_Button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';

import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/helpers/date_helpers.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../../Widgets/my_back_button.dart';

class AssignedParking extends StatelessWidget {
  AssignedParking({super.key});
  var controller = Get.find<ParkingManagementController>();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    double gridWidth = mediaQuery.width * 0.4; // 40% of screen width
    return WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.background,
            floatingActionButton: MyFloatingButton(onPressed: () {
              Get.offNamed(addAndAssignparking, arguments: controller.user);
            }),
            body: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Obx(
                  () => controller.loading.value
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 300),
                          child: CircularIndicatorUnderWhiteBox(),
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyBackButton(
                              text:
                                  controller.user.societyorbuildingname ?? "NA",
                              onTap: () {
                                Get.offNamed(homescreen,
                                    arguments: controller.user);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                top: 20,
                                right: 20,
                              ),
                              child: Text(
                                "Select Parking Area",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 18.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection:
                                    Axis.horizontal, // Set to horizontal
                                itemCount: controller
                                    .getParkingSlotsModel
                                    .data!
                                    .areas!
                                    .length, // No need to add extra count
                                itemBuilder: (context, i) {
                                  double rightPadding = i ==
                                          controller.getParkingSlotsModel.data!
                                                  .areas!.length -
                                              1
                                      ? 10
                                      : 0;

                                  return GestureDetector(
                                    onTap: () {
                                      controller
                                          .parkingAreaSelectedIndex.value = i;

                                      controller.parkingLotName.value =
                                          controller.getParkingSlotsModel.data!
                                              .areas![i];

                                      controller.getParkingSlots(
                                          societyId: controller.user.societyid
                                              .toString(),
                                          area: controller.parkingLotName.value,
                                          status:
                                              controller.selectedStatus.value);
                                    },
                                    child: Obx(() => Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                            right: rightPadding,
                                          ),
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: controller
                                                        .parkingAreaSelectedIndex
                                                        .value ==
                                                    i
                                                ? AppColors.appThem
                                                : AppColors.globalWhite,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller.getParkingSlotsModel
                                                      .data!.areas?[i] ??
                                                  "",
                                              style: TextStyle(
                                                color: controller
                                                            .parkingAreaSelectedIndex
                                                            .value ==
                                                        i
                                                    ? AppColors.globalWhite
                                                    : AppColors.textBlack,
                                              ),
                                            ),
                                          ),
                                        )),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 150,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Rounded edges
                                      border: Border.all(
                                        color: AppColors.appThem,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Obx(() {
                                      // Ensure the status list is not null or empty
                                      var statusList = controller
                                              .getParkingSlotsModel
                                              .data
                                              ?.status ??
                                          [];

                                      var formattedStatusList = statusList
                                          .map((status) => status
                                              .toLowerCase()
                                              .replaceAll('-', ''))
                                          .toList();

                                      if (formattedStatusList.isNotEmpty &&
                                          controller
                                              .selectedStatus.value.isEmpty) {
                                        controller.selectedStatus.value =
                                            formattedStatusList.first;
                                      }

                                      return DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        // Use the formatted selectedStatus value
                                        value: controller.selectedStatus.value,
                                        items: formattedStatusList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          if (newValue != null) {
                                            controller.selectedStatus.value =
                                                newValue;

                                            controller.getParkingSlots(
                                                societyId: controller
                                                    .user.societyid
                                                    .toString(),
                                                status: controller
                                                    .selectedStatus.value,
                                                area: controller
                                                    .parkingLotName.value);
                                          }
                                        },
                                        icon: Icon(Icons.arrow_drop_down),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      );
                                    }),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Available Slots",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "Occupied",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "Un-Ocuupied",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            controller.getParkingSlotsModel.data
                                                    ?.counts?.availableSlots
                                                    .toString() ??
                                                "",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            controller.getParkingSlotsModel.data
                                                    ?.counts?.occupiedSlots
                                                    .toString() ??
                                                "",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            controller.getParkingSlotsModel.data
                                                    ?.counts?.unOccupiedSlots
                                                    .toString() ??
                                                "",
                                            style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                            controller.getParkingSlotsModel.data?.slots
                                        ?.length ==
                                    0
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.only(top: 150),
                                    child: Text(
                                      "No Data Found",
                                      style: reusableTextStyle(
                                          textStyle: GoogleFonts.dmSans(),
                                          fontSize: 14.0,
                                          color: AppColors.textBlack,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                : Container(
                                    height: 600,
                                    margin: EdgeInsets.all(12),
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: gridWidth,
                                        childAspectRatio: 0.9,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: controller.getParkingSlotsModel
                                              .data?.slots?.length ??
                                          0,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .status ==
                                                          "occupied" ||
                                                      controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .status ==
                                                          "unoccupied"
                                                  ? _showOccupiedParkingDialog(
                                                      context: context,
                                                      slotId: controller
                                                          .getParkingSlotsModel
                                                          .data
                                                          ?.slots?[index]
                                                          .id,
                                                      slotNo: controller
                                                          .getParkingSlotsModel
                                                          .data
                                                          ?.slots?[index]
                                                          .slotNumber
                                                          .toString(),
                                                      occupiedBy: controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .userName ??
                                                          "NA",
                                                      status: controller
                                                          .getParkingSlotsModel
                                                          .data
                                                          ?.slots?[index]
                                                          .status,
                                                    )
                                                  : controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .status ==
                                                          "available"
                                                      ? _showAssignParkingDialog(
                                                          context: context,
                                                          slotId: controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .id,
                                                          startDate:
                                                              DateTime.now(),
                                                          slotNo: controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .slotNumber
                                                              .toString(),
                                                          status: controller
                                                              .getParkingSlotsModel
                                                              .data
                                                              ?.slots?[index]
                                                              .status)
                                                      : null;
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.globalWhite,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: controller
                                                                        .getParkingSlotsModel
                                                                        .data
                                                                        ?.slots?[
                                                                            index]
                                                                        .status ==
                                                                    "available"
                                                                ? Colors.green
                                                                : controller
                                                                            .getParkingSlotsModel
                                                                            .data
                                                                            ?.slots?[
                                                                                index]
                                                                            .status ==
                                                                        "unoccupied"
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      12.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      12.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text(
                                                              controller
                                                                      .getParkingSlotsModel
                                                                      .data
                                                                      ?.slots?[
                                                                          index]
                                                                      .status
                                                                      .toString() ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .globalWhite),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 10,
                                                                right: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Slot No",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      11.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                              controller
                                                                      .getParkingSlotsModel
                                                                      .data
                                                                      ?.slots?[
                                                                          index]
                                                                      .slotNumber
                                                                      .toString() ??
                                                                  "",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      12.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Resident :",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      12.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 120,
                                                              child: Text(
                                                                controller
                                                                        .getParkingSlotsModel
                                                                        .data
                                                                        ?.slots?[
                                                                            index]
                                                                        .userName ??
                                                                    "NA",
                                                                style: reusableTextStyle(
                                                                    textStyle:
                                                                        GoogleFonts
                                                                            .dmSans(),
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        AppColors
                                                                            .dark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                    ),
                                  )
                          ],
                        ),
                ),
              ),
            ),
          ),
        ));
  }

  void _showAssignParkingDialog({
    required BuildContext context,
    int? slotId,
    DateTime? startDate,
    String? slotNo,
    String? status,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppColors.globalWhite,
          backgroundColor: AppColors.globalWhite,
          title: Center(child: Text("Slot $slotNo")),
          content: Obx(() => SizedBox(
                width:
                    double.maxFinite, // Ensures content stretches horizontally
                child: Form(
                  key: controller.formKey1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search Resident",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      MyTextFormField(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: double.infinity, // Ensure it takes full width
                        controller: controller.searchResidentController,
                        hintText: "Search Resident Here",
                        labelText: "Search Resident Here",
                        validator: emptyStringValidator,
                        onChanged: (v) {
                          controller.searchResidentValue.value = v;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 150,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: controller
                              .getParkingSlotsModel.data?.resident?.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              if (controller.getParkingSlotsModel.data
                                      ?.resident![index].firstname!
                                      .toLowerCase()
                                      .contains(controller
                                          .searchResidentValue.value) ??
                                  false ||
                                      controller.searchResidentValue.value
                                          .isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.searchResidentController.text =
                                          "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}";

                                      controller.residentId = controller
                                          .getParkingSlotsModel
                                          .data
                                          ?.resident![index]
                                          .residentid;
                                    },
                                    child: Container(
                                      height: 30,
                                      child: Text(
                                          "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}"),
                                    ),
                                  ),
                                );
                              } else if (controller
                                  .searchResidentValue.value.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.searchResidentController.text =
                                          "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}";

                                      controller.residentId = controller
                                          .getParkingSlotsModel
                                          .data
                                          ?.resident![index]
                                          .residentid;
                                    },
                                    child: Container(
                                      height: 30,
                                      child: Text(
                                          "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}"),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                          child: MyButton(
                        loading: controller.loadingAssignParking.value,
                        gradient: AppGradients.buttonGradient,
                        name: "ASSIGN",
                        onPressed: () {
                          if (controller.formKey1.currentState!.validate()) {
                            controller.assignParking(
                                slotId: slotId.toString(),
                                residentId: controller.residentId.toString(),
                                starDate: DateHelpers()
                                    .formatDate(startDate.toString()),
                                context: context);
                          }
                        },
                      ))
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  void _showOccupiedParkingDialog({
    required BuildContext context,
    int? slotId,
    String? slotNo,
    String? occupiedBy,
    String? status,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppColors.globalWhite,
          backgroundColor: AppColors.globalWhite,
          //  title: Center(child: Text("Occupied Parking Data")),
          content: Form(
            key: controller.formKey3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Search Resident",
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
                MyTextFormField(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity, // Ensure it takes full width
                  controller: controller.searchResidentController,
                  hintText: "Search Resident",
                  labelText: "Search Resident ",
                  validator: emptyStringValidator,
                  onChanged: (v) {
                    controller.searchResidentValue.value = v;
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 80,
                      color: AppColors.background,
                      child: ListView.builder(
                        itemCount: controller
                            .getParkingSlotsModel.data?.resident?.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            if (controller.getParkingSlotsModel.data
                                    ?.resident![index].firstname!
                                    .toLowerCase()
                                    .contains(
                                        controller.searchResidentValue.value) ??
                                false ||
                                    controller
                                        .searchResidentValue.value.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.searchResidentController.text =
                                        "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}";

                                    controller.residentId = controller
                                        .getParkingSlotsModel
                                        .data
                                        ?.resident![index]
                                        .residentid;
                                  },
                                  child: Container(
                                    height: 30,
                                    child: Text(
                                        "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}"),
                                  ),
                                ),
                              );
                            } else if (controller
                                .searchResidentValue.value.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.searchResidentController.text =
                                        "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}";

                                    controller.residentId = controller
                                        .getParkingSlotsModel
                                        .data
                                        ?.resident![index]
                                        .residentid;
                                  },
                                  child: Container(
                                    height: 30,
                                    child: Text(
                                        "${controller.getParkingSlotsModel.data?.resident![index].firstname ?? ""}  ${controller.getParkingSlotsModel.data?.resident![index].lastname ?? ""}"),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Resident ",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 12.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Parking Slot ",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 12.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Parking Status ",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 12.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            occupiedBy ?? "NA",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          slotNo ?? "NA",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 12.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          status ?? "NA",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 12.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Center(
                    child: Obx(() => MyButton(
                          loading: controller.loadingUpdatingParking.value,
                          gradient: AppGradients.buttonGradient,
                          name: "UPDATE",
                          onPressed: () {
                            if (controller.formKey3.currentState!.validate()) {
                              controller.updateParking(
                                  slotId: slotId.toString(),
                                  status: status,
                                  context: context,
                                  residentId: controller.residentId.toString());
                            }
                          },
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}

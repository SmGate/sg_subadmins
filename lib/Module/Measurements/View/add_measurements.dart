// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societyadminapp/Module/Measurements/Controller/measurements_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../Widgets/my_drop_down.dart';
import '../Widget/Custom_TextField.dart';

class AddMeasurements extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMeasurementController>(
        init: AddMeasurementController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offNamed(measurementview, arguments: controller.user);

              return true;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyBackButton(
                            text: 'Add Measurements',
                            onTap: () {
                              Get.offNamed(measurementview,
                                  arguments: controller.user);
                            }),
                        28.ph,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Measurements Below:',
                                style: GoogleFonts.quicksand(
                                  color: AppColors.appThem,
                                  fontSize: 16.font,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              22.ph,
                              // Building Dropdown
                              // ==========================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SpanText(
                                    text: 'Buildings',
                                    hasValidator: false,
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() {
                                    if (controller.loadingBuildings.value) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                        ),
                                      );
                                    }
                                    return DropdownButtonFormField<int>(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color: AppColors.globalWhite),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color: AppColors.globalWhite,
                                              width: 2),
                                        ),
                                      ),
                                      value: controller
                                                  .selectedBuildingId.value ==
                                              0
                                          ? null
                                          : controller.selectedBuildingId.value,
                                      hint: Text(
                                        'Select Building',
                                        style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      items: controller.societyBuildings
                                          .map((building) {
                                        return DropdownMenuItem<int>(
                                          value: building.id,
                                          child: Text(
                                            building.societybuildingname ??
                                                'No Name',
                                            style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.selectedBuildingId.value =
                                            value!;
                                        controller.selectedFloorId.value =
                                            0; // Reset floor
                                        controller.selectedApartmentId.value =
                                            0; // Reset apartment
                                        controller.fetchFloors(value);
                                      },
                                    );
                                  }),

                                  SizedBox(height: 20),

                                  // ==========================
                                  // Floor Dropdown
                                  // ==========================
                                  Obx(() {
                                    if (controller.selectedBuildingId.value !=
                                            0 &&
                                        controller.buildingFloors.isEmpty &&
                                        !controller.loadingFloors.value) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                            'No floors available for this building.',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      );
                                    }

                                    return Visibility(
                                      visible: controller
                                                  .selectedBuildingId.value !=
                                              0 &&
                                          controller.buildingFloors.isNotEmpty,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SpanText(
                                            text: 'Floors',
                                            hasValidator: false,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          controller.loadingFloors.value
                                              ? Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                    ),
                                                  ),
                                                )
                                              : DropdownButtonFormField<int>(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .globalWhite),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .globalWhite,
                                                          width: 2),
                                                    ),
                                                  ),
                                                  value: controller
                                                              .selectedFloorId
                                                              .value ==
                                                          0
                                                      ? null
                                                      : controller
                                                          .selectedFloorId
                                                          .value,
                                                  hint: Text(
                                                    'Select Floor',
                                                    style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  items: controller
                                                      .buildingFloors
                                                      .map((floor) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: floor.id,
                                                      child: Text(
                                                        floor.name ?? 'No Name',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller.selectedFloorId
                                                        .value = value!;
                                                    controller
                                                            .selectedApartmentId
                                                            .value =
                                                        0; // Reset apartment
                                                    controller
                                                        .fetchApartments(value);
                                                  },
                                                ),
                                        ],
                                      ),
                                    );
                                  }),

                                  SizedBox(height: 20),

                                  // ==========================
                                  // Apartment Dropdown
                                  // ==========================
                                  Obx(() {
                                    if (controller.selectedFloorId.value != 0 &&
                                        controller.buildingApartments.isEmpty &&
                                        !controller.loadingApartments.value) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                            'No apartments available for this floor.',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      );
                                    }

                                    return Visibility(
                                      visible:
                                          controller.selectedFloorId.value !=
                                                  0 &&
                                              controller.buildingApartments
                                                  .isNotEmpty,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SpanText(
                                            text: 'Apartment',
                                            hasValidator: false,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          controller.loadingApartments.value
                                              ? Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                    ),
                                                  ),
                                                )
                                              : DropdownButtonFormField<int>(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 10),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .globalWhite),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .globalWhite,
                                                          width: 2),
                                                    ),
                                                  ),
                                                  value: controller
                                                              .selectedApartmentId
                                                              .value ==
                                                          0
                                                      ? null
                                                      : controller
                                                          .selectedApartmentId
                                                          .value,
                                                  hint: Text(
                                                    'Select Apartment',
                                                    style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  items: controller
                                                      .buildingApartments
                                                      .map((apartment) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: apartment.id,
                                                      child: Text(
                                                        apartment.name ??
                                                            'No Name',
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    controller
                                                        .selectedApartmentId
                                                        .value = value!;
                                                  },
                                                ),
                                        ],
                                      ),
                                    );
                                  }),

                                  SizedBox(height: 20),

                                  Obx(() => MyDropDown(
                                        upperHeading: 'Apartment Type',
                                        onTap: () {},
                                        value:
                                            controller.apartmentTypeValue.value,
                                        items: [
                                          'apartment',
                                          'office',
                                          'shop',
                                          'penthouse',
                                          'parking',
                                        ].map<DropdownMenuItem<String>>(
                                            (String e) {
                                          return DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(
                                              e.toString(),
                                              style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          controller.setApartmentType(val);
                                          print(
                                              'Selected Apartment Type: ${controller.apartmentTypeValue}');
                                        },
                                      )),
                                  SizedBox(height: 16),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              MyDropDown(
                                  upperHeading: 'Property Type',
                                  onTap: () {
                                    controller.measurements_types.clear();
                                    controller.unitVal = null;
                                  },
                                  value: controller.propertyVal,
                                  items: controller.property_types
                                      .map<DropdownMenuItem<String>>(
                                          (String e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: GoogleFonts.ubuntu(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              )))
                                      .toList(),
                                  onChanged: (val) {
                                    controller.setPropertyVal(val);
                                    print(controller.propertyVal);

                                    if (controller.propertyVal == 'house') {
                                      controller.measurements_types.clear();
                                      controller.measurements_types.addAll([
                                        'marla',
                                        'kanal',
                                        'choose by category'
                                      ]);
                                      controller.clearText();
                                    } else if (controller.propertyVal ==
                                        'apartment') {
                                      controller.measurements_types.clear();
                                      controller.measurements_types.add('sqft');
                                      controller.measurements_types
                                          .add('choose by category');
                                      controller.clearText();
                                    }
                                  }),
                              16.ph,
                              MyDropDown(
                                  upperHeading: 'Unit Type',
                                  onTap: () {},
                                  value: controller.unitVal.toString(),
                                  items: controller.measurements_types
                                      .map<DropdownMenuItem<String>>(
                                          (String e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                                style: GoogleFonts.ubuntu(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              )))
                                      .toList(),
                                  onChanged: (val) {
                                    controller.setMeasurementVal(val);
                                    print(controller.unitVal);

                                    if (controller.unitVal != null) {
                                      controller.setArea();
                                      controller.unitLabel = controller.unitVal;
                                    }
                                  }),
                              16.ph,
                              controller.unitVal == 'choose by category'
                                  ? MyDropDown(
                                      upperHeading: 'Category',
                                      onTap: () {},
                                      value:
                                          controller.categoryValue.toString(),
                                      items: [
                                        'Studio',
                                        '1 Bedroom',
                                        '2 Bedroom',
                                        '3 Bedroom',
                                        '4 Bedroom',
                                        '5 Bedroom',
                                        '6 Bedroom',
                                        'Pent House'
                                      ]
                                          .map<DropdownMenuItem<String>>(
                                              (String e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e.toString(),
                                                    style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  )))
                                          .toList(),
                                      onChanged: (val) {
                                        controller.setCategoryValueVal(val);
                                        print(controller.categoryValue);
                                      })
                                  : SizedBox(),
                              16.ph,
                              SpanText(text: 'Services Charges'),
                              8.ph,
                              CustomTextField(
                                  textInputType: TextInputType.number,
                                  controller: controller.chargesController,
                                  hintText: '5000'),
                              16.ph,
                              SpanText(text: 'Late Charges %'),
                              8.ph,
                              CustomTextField(
                                  textInputType: TextInputType.number,
                                  controller: controller.lateChargesController,
                                  hintText: 'Late Charges'),
                              16.ph,
                              // SpanText(
                              //   text: 'Monthly Rent',
                              //   hasValidator: false,
                              // ),
                              // 8.ph,
                              // CustomTextField(
                              //     hasValidator: false,
                              //     controller: controller.monthlyRentController,
                              //     hintText: 'Monthly Rent'),
                              // 16.ph,
                              // SpanText(
                              //   text: 'Annual Increament %',
                              //   hasValidator: false,
                              // ),
                              // 8.ph,
                              // CustomTextField(
                              //     hasValidator: false,
                              //     controller:
                              //         controller.annualIncreamentController,
                              //     hintText: 'Annual Increament'),
                              // 16.ph,
                              SpanText(text: 'Tax%'),
                              8.ph,
                              CustomTextField(
                                  textInputType: TextInputType.number,
                                  controller: controller.taxController,
                                  hintText: '20.0'),
                              16.ph,
                              if (controller.isArea) ...[
                                controller.unitVal == 'choose by category'
                                    ? SizedBox()
                                    : SpanText(text: 'Size'),
                                8.ph,
                                controller.unitVal == 'choose by category'
                                    ? SizedBox()
                                    : CustomTextField(
                                        textInputType: TextInputType.number,
                                        controller: controller.areaController,
                                        hintText: "200 Sqft",
                                      )
                              ]
                            ],
                          ),
                        ),
                        29.ph,
                        Center(
                            child: Obx(() => MyButton(
                                  gradient: AppGradients.buttonGradient,
                                  width: 328.w,
                                  height: 52.h,
                                  name: 'Add',
                                  loading:
                                      controller.loadingAddingMeasurement.value,
                                  onPressed: () async {
                                    // if (!controller.isLoading)

                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      await controller.addMeasurement(
                                          userId:
                                              controller.user.userid.toString(),
                                          type: controller.propertyVal ?? "",
                                          category: controller.categoryValue
                                              .toString(),
                                          societyId: controller.user.societyid
                                              .toString(),
                                          societyBuildingId:
                                              controller.selectedBuildingId.value == 0
                                                  ? ""
                                                  : controller
                                                      .selectedBuildingId.value
                                                      .toString(),
                                          societyBuildingFloorId: controller
                                              .selectedFloorId.value
                                              .toString(),
                                          societyBuildingApartmentId:
                                              controller.selectedApartmentId.value == 0
                                                  ? ""
                                                  : controller
                                                      .selectedApartmentId.value
                                                      .toString(),
                                          apartmentType: controller
                                              .apartmentTypeValue.value,
                                          unitType: controller.unitVal ==
                                                  "choose by category"
                                              ? ""
                                              : controller.unitVal ?? "",
                                          charges: controller.chargesController.text,
                                          area: controller.areaController.text,
                                          lateCharges: controller.lateChargesController.text,
                                          tax: controller.taxController.text);
                                      // await controller.addMeasurementApi(
                                      //     userid: controller.user.userid!,
                                      //     bearerToken:
                                      //         controller.user.bearerToken.toString(),
                                      //     propertyType: controller.propertyVal!,
                                      //     charges: controller.chargesController.text,
                                      //     unitType:
                                      //         controller.unitVal == "choose by category"
                                      //             ? ""
                                      //             : controller.unitVal ?? "",
                                      //     area: controller.areaController.text,
                                      //     appCharges:
                                      //         controller.appChargesController.text,
                                      //     lateCharges:
                                      //         controller.lateChargesController.text,
                                      //     tax: controller.taxController.text,
                                      //     monthlyRent:
                                      //         controller.monthlyRentController.text,
                                      //     annualIncreament: controller
                                      //         .annualIncreamentController.text,
                                      //     category:
                                      //         controller.categoryValue.toString());
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    }
                                  },
                                ))),
                        17.ph,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/Measurements/Controller/measurements_controller.dart';
import 'package:societyadminapp/Module/Measurements/Model/MeasurementModel.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../Widgets/my_drop_down.dart';
import '../Widget/Custom_TextField.dart';

class EditMeasurementScreen extends StatefulWidget {
  const EditMeasurementScreen({super.key});

  @override
  State<EditMeasurementScreen> createState() => _EditMeasurementScreenState();
}

class _EditMeasurementScreenState extends State<EditMeasurementScreen> {
  AddMeasurementController controller = Get.put(AddMeasurementController());

  Data measurementModel = SessionController().measurementModel!;

  @override
  @override
  void initState() {
    super.initState();

    controller.chargesController.text = measurementModel.charges.toString();
    controller.lateChargesController.text =
        measurementModel.lateCharges.toString();
    controller.taxController.text = measurementModel.tax.toString();
    controller.areaController.text = measurementModel.area.toString();

    controller.propertyVal = measurementModel.type;

    // ✅ Populate measurements_types based on property type
    if (controller.propertyVal == 'house') {
      controller.measurements_types.clear();
      controller.measurements_types
          .addAll(['marla', 'kanal', 'choose by category']);
    } else if (controller.propertyVal == 'apartment') {
      controller.measurements_types.clear();
      controller.measurements_types.addAll(['sqft', 'choose by category']);
    }

    controller.unitVal =
        measurementModel.unit == "" || measurementModel.unit == null
            ? 'choose by category'
            : measurementModel.unit.toString();

    controller.categoryValue = measurementModel.category;

    controller.apartmentTypeValue.value =
        measurementModel.societyBuildingFloorApartment?.type ?? 'apartment';

    controller.selectedBuildingId.value =
        measurementModel.societyBuilding?.id ?? 0;

    /// 🔥 Correct sequence: fetch floors -> set selectedFloorId -> fetch apartments -> set selectedApartmentId
    if (controller.selectedBuildingId.value != 0) {
      controller.fetchFloors(controller.selectedBuildingId.value).then((_) {
        /// ✅ After floors are loaded, set selected floor
        controller.selectedFloorId.value =
            measurementModel.societyBuildingFloor?.id ?? 0;

        /// 🔥 Now fetch apartments
        controller.fetchApartments(controller.selectedFloorId.value).then((_) {
          /// ✅ After apartments are loaded, set selected apartment
          controller.selectedApartmentId.value =
              measurementModel.societyBuildingFloorApartment?.id ?? 0;
        });
      });
    }
  }

  @override
  void dispose() {
    Get.delete<AddMeasurementController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      text: 'Edit Measurements',
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
                        MyDropDown(
                            upperHeading: 'Property Type',
                            onTap: () {
                              controller.measurements_types.clear();
                              controller.unitVal = null;
                              setState(() {});
                            },
                            value: controller.propertyVal,
                            items: controller.property_types
                                .map<DropdownMenuItem<String>>((String e) =>
                                    DropdownMenuItem(
                                        value: e, child: Text(e.toString())))
                                .toList(),
                            onChanged: (val) {
                              controller.setPropertyVal(val);
                              if (controller.propertyVal == 'house') {
                                controller.measurements_types.clear();
                                controller.measurements_types.addAll(
                                    ['marla', 'kanal', 'choose by category']);
                                controller.clearText();
                              } else if (controller.propertyVal ==
                                  'apartment') {
                                controller.measurements_types.clear();
                                controller.measurements_types.add('sqft');
                                controller.measurements_types
                                    .add('choose by category');
                                controller.clearText();
                              }
                              setState(() {});
                            }),
                        16.ph,
                        MyDropDown(
                            upperHeading: 'Unit Type',
                            onTap: () {},
                            value: controller.unitVal.toString(),
                            items: controller.measurements_types
                                .map<DropdownMenuItem<String>>((String e) =>
                                    DropdownMenuItem(
                                        value: e, child: Text(e.toString())))
                                .toList(),
                            onChanged: (val) {
                              controller.setMeasurementVal(val);
                              if (controller.unitVal != null) {
                                controller.setArea();
                                controller.unitLabel = controller.unitVal;
                              }
                              setState(() {});
                            }),
                        16.ph,
                        controller.unitVal == 'choose by category'
                            ? MyDropDown(
                                upperHeading: 'Category',
                                onTap: () {},
                                value: controller.categoryValue.toString(),
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
                                    .map<DropdownMenuItem<String>>((String e) =>
                                        DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toString())))
                                    .toList(),
                                onChanged: (val) {
                                  controller.setCategoryValueVal(val);
                                  setState(() {});
                                })
                            : const SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
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
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.appThem,
                                ));
                              }
                              return DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: AppColors.globalWhite),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: AppColors.globalWhite, width: 2),
                                  ),
                                ),
                                value: controller.selectedBuildingId.value == 0
                                    ? null
                                    : controller.selectedBuildingId.value,
                                hint: Text(
                                  'Select Building',
                                  style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                items:
                                    controller.societyBuildings.map((building) {
                                  return DropdownMenuItem<int>(
                                    value: building.id,
                                    child: Text(
                                      building.societybuildingname ?? 'No Name',
                                      style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectedBuildingId.value = value!;
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
                              if (controller.selectedBuildingId.value != 0 &&
                                  controller.buildingFloors.isEmpty &&
                                  !controller.loadingFloors.value) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                      'No floors available for this building.',
                                      style: TextStyle(color: Colors.red)),
                                );
                              }

                              return Visibility(
                                visible:
                                    controller.selectedBuildingId.value != 0 &&
                                        controller.buildingFloors.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SpanText(
                                      text: 'Floors',
                                      hasValidator: false,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    controller.loadingFloors.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: AppColors.appThem,
                                          ))
                                        : DropdownButtonFormField<int>(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.globalWhite),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.globalWhite,
                                                    width: 2),
                                              ),
                                            ),
                                            value: controller.selectedFloorId
                                                        .value ==
                                                    0
                                                ? null
                                                : controller
                                                    .selectedFloorId.value,
                                            hint: Text(
                                              'Select Floor',
                                              style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                            items: controller.buildingFloors
                                                .map((floor) {
                                              return DropdownMenuItem<int>(
                                                value: floor.id,
                                                child: Text(
                                                  floor.name ?? 'No Name',
                                                  style: GoogleFonts.ubuntu(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.selectedFloorId.value =
                                                  value!;
                                              controller.selectedApartmentId
                                                  .value = 0; // Reset apartment
                                              controller.fetchApartments(value);
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                      'No apartments available for this floor.',
                                      style: TextStyle(color: Colors.red)),
                                );
                              }

                              return Visibility(
                                visible: controller.selectedFloorId.value !=
                                        0 &&
                                    controller.buildingApartments.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SpanText(
                                      text: 'Apartment',
                                      hasValidator: false,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    controller.loadingApartments.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: AppColors.appThem,
                                          ))
                                        : DropdownButtonFormField<int>(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.globalWhite),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.globalWhite,
                                                    width: 2),
                                              ),
                                            ),
                                            value: controller
                                                        .selectedApartmentId
                                                        .value ==
                                                    0
                                                ? null
                                                : controller
                                                    .selectedApartmentId.value,
                                            hint: Text(
                                              'Select Apartment',
                                              style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                            items: controller.buildingApartments
                                                .map((apartment) {
                                              return DropdownMenuItem<int>(
                                                value: apartment.id,
                                                child: Text(
                                                  apartment.name ?? 'No Name',
                                                  style: GoogleFonts.ubuntu(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.selectedApartmentId
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
                                  value: controller.apartmentTypeValue.value,
                                  items: [
                                    'apartment',
                                    'office',
                                    'shop',
                                    'penthouse',
                                    'parking',
                                  ].map<DropdownMenuItem<String>>((String e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e.toString()),
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
                        16.ph,
                        SpanText(text: 'Services Charges'),
                        8.ph,
                        CustomTextField(
                            controller: controller.chargesController,
                            hintText: '5000'),
                        16.ph,
                        SpanText(text: 'Late Charges%'),
                        8.ph,
                        CustomTextField(
                            controller: controller.lateChargesController,
                            hintText: 'Late Charges'),
                        16.ph,
                        SpanText(text: 'Tax%'),
                        8.ph,
                        CustomTextField(
                            controller: controller.taxController,
                            hintText: '20.0'),
                        16.ph,
                        if (controller.isArea) ...[
                          SpanText(text: 'Size'),
                          8.ph,
                          CustomTextField(
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
                            name: 'Update',
                            loading: controller.isUpdating.value,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                await controller.updateMeasurementApi(
                                    measurementId: measurementModel.id,
                                    userid: controller.user.userid ?? 0,
                                    bearerToken:
                                        controller.user.bearerToken ?? "",
                                    type: controller.propertyVal ?? "",
                                    apartmentType:
                                        controller.apartmentTypeValue.value,
                                    charges: controller.chargesController.text,
                                    societyId:
                                        controller.user.societyid.toString(),
                                    unitType: controller.unitVal ==
                                            "choose by category"
                                        ? ""
                                        : controller.unitVal ?? "",
                                    societyBuildingId: controller
                                        .selectedBuildingId.value
                                        .toString(),
                                    societyBuildingApartmentId: controller
                                        .selectedApartmentId.value
                                        .toString(),
                                    societyBuildingFloorId: controller
                                        .selectedFloorId.value
                                        .toString(),
                                    area: controller.areaController.text,
                                    appCharges:
                                        controller.appChargesController.text,
                                    lateCharges:
                                        controller.lateChargesController.text,
                                    tax: controller.taxController.text,
                                    category:
                                        controller.categoryValue.toString());
                                FocusManager.instance.primaryFocus?.unfocus();
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
  }
}

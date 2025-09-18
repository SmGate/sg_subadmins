// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:societyadminapp/Module/Measurements/Controller/measurement_view_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/My_Floating_Button.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../Widget/Dynamic_Conatiner.dart';

class MeasurementView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeasurementViewController>(
        init: MeasurementViewController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.user);

              return true;
            },
            child: DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  floatingActionButton: MyFloatingButton(
                    onPressed: () {
                      Get.offNamed(addmeasurements, arguments: controller.user);
                    },
                  ),

                  // IconButton(
                  //     iconSize: MediaQuery.of(context).size.height * 0.065,
                  //     icon: SvgPicture.asset('assets/floatingbutton.svg'),
                  //     onPressed: () {
                  //       Get.offNamed(addmeasurements,
                  //           arguments: controller.user);
                  //     }),
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Measurement View',
                        onTap: () {
                          Get.offNamed(homescreen, arguments: controller.user);
                        },
                      ),
                      32.ph,
                      Container(
                        margin: EdgeInsets.only(left: 23.w, right: 23.w),
                        width: 329.w,
                        height: 39.h,
                        decoration: ShapeDecoration(
                            color: AppColors.globalWhite,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.w, color: AppColors.appThem),
                              borderRadius: BorderRadius.circular(8.r),
                            )),
                        child: TabBar(
                          unselectedLabelColor: Color(0xFF5A5A5A),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.white,
                          indicator: ShapeDecoration(
                            color: AppColors.appThem,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          indicatorColor: AppColors.appThem,
                          tabs: [
                            Tab(
                                child: Text(
                              'Houses',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 14.sp),
                            )),
                            Tab(
                              child: Text(
                                'Apartments',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Obx(() {
                                          if (controller
                                              .loadingBuildings.value) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                              ),
                                            );
                                          }
                                          return DropdownButtonFormField<int>(
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
                                            value: controller.selectedBuildingId
                                                        .value ==
                                                    0
                                                ? null
                                                : controller
                                                    .selectedBuildingId.value,
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
                                              controller.selectedBuildingId
                                                  .value = value!;
                                              controller.selectedFloorId.value =
                                                  0; // Reset floor
                                              controller.selectedApartmentId
                                                  .value = 0; // Reset apartment
                                              controller.fetchFloors(value);
                                              controller.fetchHouseData();
                                              controller.fetchApartmentData();
                                            },
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // ==========================
                                      // Floor Dropdown
                                      // ==========================
                                      SizedBox(
                                        width: 200,
                                        child: Obx(() {
                                          if (controller.selectedBuildingId
                                                      .value !=
                                                  0 &&
                                              controller
                                                  .buildingFloors.isEmpty &&
                                              !controller.loadingFloors.value) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                  'No floors available for this building.',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            );
                                          }

                                          return Visibility(
                                            visible: controller
                                                        .selectedBuildingId
                                                        .value !=
                                                    0 &&
                                                controller
                                                    .buildingFloors.isNotEmpty,
                                            child: controller
                                                    .loadingFloors.value
                                                ? Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      height: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
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
                                                            BorderRadius
                                                                .circular(6),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .globalWhite),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
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
                                                          floor.name ??
                                                              'No Name',
                                                          style: GoogleFonts
                                                              .ubuntu(
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
                                                          .fetchApartments(
                                                              value);
                                                      controller
                                                          .fetchHouseData();

                                                      controller
                                                          .fetchApartmentData();
                                                    },
                                                  ),
                                          );
                                        }),
                                      ),

                                      SizedBox(width: 20),

                                      // ==========================
                                      // Apartment Dropdown
                                      // ==========================
                                      SizedBox(
                                        width: 200,
                                        child: Obx(() {
                                          if (controller
                                                      .selectedFloorId.value !=
                                                  0 &&
                                              controller
                                                  .buildingApartments.isEmpty &&
                                              !controller
                                                  .loadingApartments.value) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                  'No apartments available for this floor.',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            );
                                          }

                                          return Visibility(
                                            visible: controller.selectedFloorId
                                                        .value !=
                                                    0 &&
                                                controller.buildingApartments
                                                    .isNotEmpty,
                                            child: controller
                                                    .loadingApartments.value
                                                ? Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      height: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
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
                                                            BorderRadius
                                                                .circular(6),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .globalWhite),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
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
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14)),
                                                    items: controller
                                                        .buildingApartments
                                                        .map((apartment) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value: apartment.id,
                                                        child: Text(
                                                            apartment.name ??
                                                                'No Name',
                                                            style: GoogleFonts
                                                                .ubuntu(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14)),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller
                                                          .selectedApartmentId
                                                          .value = value!;
                                                      controller
                                                          .fetchHouseData();
                                                      controller
                                                          .fetchApartmentData();
                                                    },
                                                  ),
                                          );
                                        }),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.appThem,
                                  borderRadius: BorderRadius.circular(6)),
                              child: IconButton(
                                  onPressed: () {
                                    controller.selectedBuildingId.value = 0;
                                    controller.selectedFloorId.value = 0;
                                    controller.selectedApartmentId.value = 0;

                                    // You can also re-fetch all data if needed
                                    controller.fetchHouseData();
                                    controller.fetchApartmentData();
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: AppColors.globalWhite,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Obx(() => FutureBuilder(
                                  future: controller.houseFuture.value,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularIndicatorUnderWhiteBox();
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Icon(Icons.error_outline));
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data.data != null &&
                                        snapshot.data.data.isNotEmpty) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              SessionController()
                                                      .measurementModel =
                                                  snapshot.data.data[index];
                                              await Get.toNamed(editMeasurment,
                                                  arguments: controller.user);
                                            },
                                            child: DynamicContainer(
                                              heading: 'House details',
                                              unitType: snapshot
                                                  .data.data[index].unit,
                                              serviceCharges: snapshot
                                                  .data.data[index].charges,
                                              tax:
                                                  snapshot.data.data[index].tax,
                                              appCharges: snapshot
                                                  .data.data[index].appcharges,
                                              area: snapshot
                                                  .data.data[index].area,
                                              building: snapshot
                                                  .data
                                                  .data[index]
                                                  .societyBuilding
                                                  ?.societybuildingname,
                                              floor: snapshot.data.data[index]
                                                  .societyBuildingFloor?.name,
                                              apartment: snapshot
                                                  .data
                                                  .data[index]
                                                  .societyBuildingFloorApartment
                                                  ?.name,
                                              category: snapshot.data
                                                      .data[index].category ??
                                                  '',
                                              lateCharges: snapshot
                                                      .data
                                                      .data[index]
                                                      .lateCharges ??
                                                  '',
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(
                                          child: Text('No records found.'));
                                    }
                                  },
                                )),
                            Obx(() => FutureBuilder(
                                  future: controller.apartmentFuture.value,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularIndicatorUnderWhiteBox();
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Icon(Icons.error_outline));
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data.data != null &&
                                        snapshot.data.data.isNotEmpty) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              SessionController()
                                                      .measurementModel =
                                                  snapshot.data.data[index];
                                              await Get.toNamed(editMeasurment,
                                                  arguments: controller.user);
                                            },
                                            child: DynamicContainer(
                                              heading: 'Appartment details',
                                              unitType: snapshot
                                                  .data.data[index].unit,
                                              serviceCharges: snapshot
                                                  .data.data[index].charges,
                                              tax:
                                                  snapshot.data.data[index].tax,
                                              appCharges: snapshot
                                                  .data.data[index].appcharges,
                                              area: snapshot
                                                  .data.data[index].area,
                                              building: snapshot
                                                  .data
                                                  .data[index]
                                                  .societyBuilding
                                                  ?.societybuildingname,
                                              floor: snapshot.data.data[index]
                                                  .societyBuildingFloor?.name,
                                              apartment: snapshot
                                                  .data
                                                  .data[index]
                                                  .societyBuildingFloorApartment
                                                  ?.name,
                                              category: snapshot.data
                                                      .data[index].category ??
                                                  '',
                                              lateCharges: snapshot
                                                      .data
                                                      .data[index]
                                                      .lateCharges ??
                                                  '',
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(
                                          child: Text('No records found.'));
                                    }
                                  },
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:societyadminapp/Module/UnVerifiedResidents/Controller/unverified_resident_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../Widget/unverified_resident_custom_widget.dart';

class UnVerifiedResident extends GetView {
  const UnVerifiedResident({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnVerifiedResidentController>(
      init: UnVerifiedResidentController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);
          return true;
        },
        child: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: (controller.userdata.structureType == 4)
                  // ================= LOCAL BUILDING (single list) =================
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyBackButton(
                          text: 'Unverified Residents',
                          onTap: () {
                            Get.offNamed(homescreen,
                                arguments: controller.user);
                          },
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: controller
                                .viewUnVerifiedLocalBuildingApartmentResidentApi(
                              subadminid: controller.userdata.userid!,
                              token: controller.userdata.bearerToken!,
                              status: 0,
                            ),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularIndicatorUnderWhiteBox(),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Icon(Icons.error_outline);
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data.data == null ||
                                  snapshot.data.data!.isEmpty) {
                                return EmptyList(
                                  name: 'No Resident for Verification',
                                );
                              }

                              return ListView.builder(
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (context, index) {
                                  final item = snapshot.data.data[index];

                                  // Helper to extract residentId robustly
                                  int residentId() {
                                    final dynamic raw =
                                        item.residentid ?? item.id;
                                    if (raw is int) return raw;
                                    if (raw is String) {
                                      return int.tryParse(raw) ?? 0;
                                    }
                                    return 0;
                                  }

                                  return UnverifiedCard(
                                    name:
                                        '${item.firstname ?? ''} ${item.lastname ?? ''}',
                                    mobileno: '${item.mobileno ?? ''}',
                                    onTap: () {
                                      Get.offNamed(
                                        localBuildingApartmentResidentVerification,
                                        arguments: [controller.userdata, item],
                                      );
                                    },
                                    onRejectTap: (reason) async {
                                      await controller
                                          .rejectResidentVerification(
                                        token: controller.userdata.bearerToken!,
                                        residentId: residentId(),
                                        reason: reason,
                                      );
                                      // (Optional) refresh or remove from list:
                                      // snapshot.data.data.removeAt(index);
                                      // (You can also trigger a refetch if needed)
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    )
                  // ================= HOUSE / APARTMENT (tabs) =================
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyBackButton(
                          text: 'Unverified Residents',
                          onTap: () {
                            Get.offNamed(homescreen,
                                arguments: controller.user);
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
                                width: 1.w,
                                color: AppColors.appThem,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: TabBar(
                            unselectedLabelColor: const Color(0xFF5A5A5A),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            indicator: ShapeDecoration(
                              color: AppColors.appThem,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            indicatorColor: AppColors.appThem,
                            tabs: [
                              Tab(
                                child: Text(
                                  'House',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Apartment',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        30.ph,
                        Expanded(
                          child: TabBarView(
                            children: [
                              // ================= HOUSE TAB =================
                              GetBuilder<UnVerifiedResidentController>(
                                id: 'houseTab',
                                builder: (controller) {
                                  final cachedData = controller
                                      .getCachedUnverifiedResidentData(
                                    controller.userdata.userid!,
                                    controller.userdata.bearerToken!,
                                    0,
                                  );

                                  if (cachedData != null) {
                                    return ListView.builder(
                                      itemCount: cachedData.length,
                                      itemBuilder: (context, index) {
                                        final item = cachedData[index];

                                        int residentId() {
                                          final dynamic raw =
                                              item.residentid ?? item.id;
                                          if (raw is int) return raw;
                                          if (raw is String) {
                                            return int.tryParse(raw) ?? 0;
                                          }
                                          return 0;
                                        }

                                        return UnverifiedCard(
                                          name:
                                              '${item.firstname ?? ''} ${item.lastname ?? ''}',
                                          mobileno: '${item.mobileno ?? ''}',
                                          onTap: () {
                                            Get.offNamed(
                                              houseresidentverification,
                                              arguments: [
                                                controller.userdata,
                                                item,
                                              ],
                                            );
                                          },
                                          onRejectTap: (reason) async {
                                            await controller
                                                .rejectResidentVerification(
                                              token: controller
                                                  .userdata.bearerToken!,
                                              residentId: residentId(),
                                              reason: reason,
                                            );
                                            // Optional: remove from cache & update UI
                                            // cachedData.removeAt(index);
                                            // controller.update(['houseTab']);
                                          },
                                        );
                                      },
                                    );
                                  }

                                  return FutureBuilder(
                                    future:
                                        controller.viewUnVerifiedResidentApi(
                                      subadminid: controller.userdata.userid!,
                                      token: controller.userdata.bearerToken!,
                                      status: 0,
                                    ),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularIndicatorUnderWhiteBox();
                                      }
                                      if (snapshot.hasError) {
                                        return const Icon(Icons.error_outline);
                                      }
                                      if (!snapshot.hasData ||
                                          snapshot.data.data == null ||
                                          snapshot.data.data!.isEmpty) {
                                        return EmptyList(
                                          name: 'No Resident for Verification',
                                        );
                                      }

                                      controller.cacheUnverifiedResidentData(
                                        snapshot.data.data,
                                        0,
                                      );

                                      return ListView.builder(
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              snapshot.data.data[index];

                                          int residentId() {
                                            final dynamic raw =
                                                item.residentid ?? item.id;
                                            if (raw is int) return raw;
                                            if (raw is String) {
                                              return int.tryParse(raw) ?? 0;
                                            }
                                            return 0;
                                          }

                                          return UnverifiedCard(
                                            name:
                                                '${item.firstname ?? ''} ${item.lastname ?? ''}',
                                            mobileno: '${item.mobileno ?? ''}',
                                            onTap: () {
                                              Get.offNamed(
                                                houseresidentverification,
                                                arguments: [
                                                  controller.userdata,
                                                  item
                                                ],
                                              );
                                            },
                                            onRejectTap: (reason) async {
                                              await controller
                                                  .rejectResidentVerification(
                                                token: controller
                                                    .userdata.bearerToken!,
                                                residentId: residentId(),
                                                reason: reason,
                                              );
                                              // Optional: controller.update(['houseTab']);
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),

                              // ================= APARTMENT TAB =================
                              GetBuilder<UnVerifiedResidentController>(
                                id: 'apartmentTab',
                                builder: (controller) {
                                  final cachedData = controller
                                      .getCachedUnverifiedResidentData(
                                    controller.userdata.userid!,
                                    controller.userdata.bearerToken!,
                                    1,
                                  );

                                  if (cachedData != null) {
                                    return ListView.builder(
                                      itemCount: cachedData.length,
                                      itemBuilder: (context, index) {
                                        final item = cachedData[index];

                                        int residentId() {
                                          final dynamic raw =
                                              item.residentid ?? item.id;
                                          if (raw is int) return raw;
                                          if (raw is String) {
                                            return int.tryParse(raw) ?? 0;
                                          }
                                          return 0;
                                        }

                                        return UnverifiedCard(
                                          name:
                                              '${item.firstname ?? ''} ${item.lastname ?? ''}',
                                          mobileno: '${item.mobileno ?? ''}',
                                          onTap: () {
                                            Get.offNamed(
                                              apartmentresidentverification,
                                              arguments: [
                                                controller.userdata,
                                                item,
                                              ],
                                            );
                                          },
                                          onRejectTap: (reason) async {
                                            await controller
                                                .rejectResidentVerification(
                                              token: controller
                                                  .userdata.bearerToken!,
                                              residentId: residentId(),
                                              reason: reason,
                                            );
                                            // Optional: cachedData.removeAt(index); controller.update(['apartmentTab']);
                                          },
                                        );
                                      },
                                    );
                                  }

                                  return FutureBuilder(
                                    future: controller
                                        .viewUnVerifiedApartmentResidentApi(
                                      subadminid: controller.userdata.userid!,
                                      token: controller.userdata.bearerToken!,
                                      status: 0,
                                    ),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularIndicatorUnderWhiteBox();
                                      }
                                      if (snapshot.hasError) {
                                        return const Icon(Icons.error_outline);
                                      }
                                      if (!snapshot.hasData ||
                                          snapshot.data.data == null ||
                                          snapshot.data.data!.isEmpty) {
                                        return EmptyList(
                                          name: 'No Resident for Verification',
                                        );
                                      }

                                      controller.cacheUnverifiedResidentData(
                                        snapshot.data.data,
                                        1,
                                      );

                                      return ListView.builder(
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              snapshot.data.data[index];

                                          int residentId() {
                                            final dynamic raw =
                                                item.residentid ?? item.id;
                                            if (raw is int) return raw;
                                            if (raw is String) {
                                              return int.tryParse(raw) ?? 0;
                                            }
                                            return 0;
                                          }

                                          return UnverifiedCard(
                                            name:
                                                '${item.firstname ?? ''} ${item.lastname ?? ''}',
                                            mobileno: '${item.mobileno ?? ''}',
                                            onTap: () {
                                              Get.offNamed(
                                                apartmentresidentverification,
                                                arguments: [
                                                  controller.userdata,
                                                  item
                                                ],
                                              );
                                            },
                                            onRejectTap: (reason) async {
                                              await controller
                                                  .rejectResidentVerification(
                                                token: controller
                                                    .userdata.bearerToken!,
                                                residentId: residentId(),
                                                reason: reason,
                                              );
                                              // Optional: controller.update(['apartmentTab']);
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

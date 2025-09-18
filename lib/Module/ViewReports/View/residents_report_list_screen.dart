// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../Routes/set_routes.dart';
import '../Controller/resident_reports_controller.dart';
import '../Model/ResidentReports.dart';

class UserReportsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResidentReportsController>(
      init: ResidentReportsController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(viewreportscreen, arguments: controller.userdata);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                MyBackButton(
                  text: 'Complaints By Residents',
                  onTap: () {
                    Get.offNamed(viewreportscreen,
                        arguments: controller.userdata);
                  },
                ),
                Expanded(
                  child: FutureBuilder<List<ResidentReports>>(
                    future: controller.viewResidentsReportsApi(
                      controller.userdata.userid!,
                      controller.residentId,
                      controller.userdata.bearerToken!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppColors.globalWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title.toString(),
                                        style: GoogleFonts.dmSans(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        snapshot.data![index].description
                                            .toString(),
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      // Name Section - Bold and Black Label
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: AppColors.dark),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Name: ",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors
                                                  .textBlack, // Bold and Black label
                                            ),
                                          ),
                                          SizedBox(width: 5.w), // Adjust space
                                          Text(
                                            "${controller.residentName ?? ""}",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      // Mobile Section - Bold and Black Label
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                              color: AppColors.dark),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Mobile: ",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors
                                                  .textBlack, // Bold and Black label
                                            ),
                                          ),
                                          SizedBox(width: 5.w), // Adjust space
                                          Text(
                                            "${controller.residentMobileno ?? ""}",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      // Address Section - Bold and Black Label
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,
                                              color: AppColors.dark),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Address:  ",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors
                                                  .textBlack, // Bold and Black label
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${controller.residentAddress ?? ""}",
                                              style: GoogleFonts.dmSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.dark,
                                              ),
                                              maxLines:
                                                  3, // Allow 3 lines for address
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      // Stylish status section
                                      Row(
                                        children: [
                                          Icon(Icons.update,
                                              color: AppColors.dark),
                                          SizedBox(width: 10.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 10.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.appThem
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              "Status: In Progress",
                                              style: GoogleFonts.dmSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.appThem,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      // Adding the update date/time section
                                      Row(
                                        children: [
                                          Icon(Icons.access_time,
                                              color: AppColors.dark),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Complaint Date: ",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors
                                                  .textBlack, // Bold and Black label
                                            ),
                                          ),
                                          Text(
                                            "${convertLaravelDateFormatToDayMonthYearDateFormat(snapshot.data![index].updatedAt ?? 'N/A')}",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.dark
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.h),
                                      Divider(
                                        color: AppColors.dark.withOpacity(0.2),
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('No complaints found.'));
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Icon(Icons.error_outline));
                      } else {
                        return Center(child: CircularIndicatorUnderWhiteBox());
                      }
                    },
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

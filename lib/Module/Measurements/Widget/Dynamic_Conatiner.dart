// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

String displayValue(String? value) {
  if (value == null || value.trim().isEmpty || value == "" || value == "null") {
    return 'N/A';
  }
  return value;
}

class DynamicContainer extends StatelessWidget {
  DynamicContainer({
    required this.heading,
    required this.unitType,
    required this.serviceCharges,
    required this.tax,
    required this.appCharges,
    required this.area,
    this.category,
    this.lateCharges,
    this.building,
    this.floor,
    this.apartment,
  });

  String? heading;
  String? unitType;
  String? serviceCharges;
  String? tax;
  String? appCharges;
  String? area;
  String? category;
  String? lateCharges;
  String? building;
  String? floor;
  String? apartment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        15.ph,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 23.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appThem,
                ),
              ),
              16.ph,
              Divider(color: Colors.grey.shade300),
              16.ph,
              buildInfoRow('Unit Type', displayValue(unitType)),
              buildInfoRow('Service Charges', displayValue(serviceCharges)),
              buildInfoRow(
                  'Late Charges', displayValue("${lateCharges ?? ''} %")),
              buildInfoRow('Category', displayValue(category)),
              buildInfoRow('Tax', displayValue("${tax ?? ''} %")),
              buildInfoRow('Area', displayValue(area)),
              buildInfoRow('Building', displayValue(building)),
              buildInfoRow('Floor', displayValue(floor)),
              buildInfoRow('Apartment', displayValue(apartment)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: GoogleFonts.ubuntu(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: GoogleFonts.ubuntu(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

Widget EmergencyCard(AsyncSnapshot<dynamic> snapshot, int index) {
  return Padding(
    padding: EdgeInsets.only(left: 24.w, right: 14.w, top: 10.h),
    child: SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.globalWhite,
        // elevation: 8,
        surfaceTintColor: AppColors.globalWhite,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.globalWhite,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 19.w),
                child: Image.asset(
                  AppImages.panicButton,
                  height: 40,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      9.h.ph,
                      SizedBox(
                        width: 200,
                        child: Text(
                          '${snapshot.data.data[index].problem}',
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 16.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        '${snapshot.data.data[index].description}',
                        overflow: TextOverflow.ellipsis,
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 33.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    11.h.ph,
                    Text(
                      '${convertUtcToDayOfWeekWithOffset(snapshot.data.data[index].createdAt)}',
                      style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.h.ph,
                    Text(
                      '${convertUtcToFormattedTimeAdd5Hours(snapshot.data.data[index].createdAt)}',
                      overflow: TextOverflow.ellipsis,
                      style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 12.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

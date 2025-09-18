// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class MyDropDown extends StatelessWidget {
  MyDropDown({
    required this.upperHeading,
    required this.onTap,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  String? upperHeading;
  void Function()? onTap;
  String? value;
  List<DropdownMenuItem<String>>? items;
  void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpanText(text: upperHeading!),
        8.ph,
        Container(
          width: 328.w,
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Color(0xFFE1E3E6)),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: DropdownButton<String>(
              onTap: onTap,
              underline: Container(),
              isExpanded: true,
              value: value != null &&
                      items != null &&
                      items!.any((item) => item.value == value)
                  ? value
                  : null,
              items: items,
              onChanged: onChanged),
        ),
      ],
    );
  }
}

class SpanText extends StatelessWidget {
  SpanText({required this.text, this.hasValidator = true});
  String? text;

  bool hasValidator = false;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text!,
            style: GoogleFonts.quicksand(
              color: Color(0xFF6A7380),
              fontSize: 14.font,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (hasValidator)
            TextSpan(
              text: '*',
              style: GoogleFonts.quicksand(
                color: AppColors.appThem,
                fontSize: 14.font,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

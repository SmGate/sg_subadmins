// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.controller,
      required this.hintText,
      this.hasValidator = true,
      this.hintStyle, // ✅ Add optional hint style
      this.textInputType});

  TextEditingController? controller;
  String? hintText;
  bool hasValidator;
  TextStyle? hintStyle; // ✅ Optional parameter

  TextInputType? textInputType = TextInputType.number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.quicksand(
        fontSize: 12.sp,
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      validator: hasValidator ? emptyStringValidator : null,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.ubuntu(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          fontSize: 10.sp,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
        ),
        fillColor: Colors.white10,
        filled: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 25.h, left: 12.w),
        hintText: hintText,
        hintStyle: hintStyle ??
            GoogleFonts.quicksand(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
      ),
    );
  }
}

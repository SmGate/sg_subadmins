// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class DetailShownDialogBox extends StatelessWidget {
  final String? heading;
  final String? text;
  final String? icon;
  bool isPng = false;
  Color color;

  DetailShownDialogBox(
      {required this.heading,
      required this.text,
      required this.icon,
      this.isPng = false,
      this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isPng
                  ? Image.asset(
                      icon ?? "",
                      height: 20,
                      color: color,
                    )
                  : SvgPicture.asset(
                      icon!,
                      height: 20,
                      color: color,
                    ),
              10.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading!,
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 15.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    6.ph,
                    Text(
                      text ?? "",
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.normal),
                    ),
                    10.ph,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

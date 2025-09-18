// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class MenuItems extends StatelessWidget {
  String image;
  String title;
  bool isIcon;
  Function ontap;

  MenuItems({
    super.key,
    required this.image,
    required this.title,
    required this.ontap,
    this.isIcon = false,
  });

  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  @override
  Widget build(BuildContext context) {
    double width = isTablet(context) ? 200 : 150;
    double height = isTablet(context) ? 100 : 80;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCard(
          width: width,
          height: height,
          boxShadow: BoxShadow(),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ontap();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  image,
                ),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.boldHeading,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

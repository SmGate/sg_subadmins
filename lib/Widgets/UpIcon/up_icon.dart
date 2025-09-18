import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UpIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 29.4.w,
      height: 16.8.h,
      child: SvgPicture.asset('assets/up.svg'),
    );
  }
}

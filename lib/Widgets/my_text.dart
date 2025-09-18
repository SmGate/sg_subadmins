// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';

class MyText extends GetView {
  final String? name;
  Color? color;

  MyText({required this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(name!,
          style: GoogleFonts.ubuntu(
              fontStyle: FontStyle.normal,
              // color: secondaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.font,
              color: color ?? Colors.black)),
    );
  }
}

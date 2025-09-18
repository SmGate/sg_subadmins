import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../../Widgets/my_elipse.dart';

class DialogBoxElipseHeading extends StatelessWidget {
  final String? text;

  const DialogBoxElipseHeading({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyElipse(),
        11.w.pw,
        Text(
          text ?? "",
          style: reusableTextStyle(
            textStyle: GoogleFonts.dmSans(),
            fontSize: 14.0,
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

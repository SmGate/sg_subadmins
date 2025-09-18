// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/helpers/date_helpers.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/my_dialog_box.dart';

class EventnNoticeBoardViewCard extends StatelessWidget {
  EventnNoticeBoardViewCard(
      {this.eventCardDesginImg,
      this.showeventCardDesginImg = true,
      required this.title,
      required this.description,
      this.showButtons = true,
      this.onPressedofAddImage,
      this.onPressedofViewImage,
      required this.DeleteDialogPress,
      required this.updateOnPressed,
      required this.startdate,
      required this.enddate,
      this.startTIme,
      this.endTime,
      this.gradientColors = const [],
      this.iconColor,
      this.startDatecolor,
      this.image,
      this.endDatecolor,
      this.isShowEvent = false});
  String? eventCardDesginImg;

  String? title;
  String? description;
  bool showButtons;
  bool showeventCardDesginImg;
  List<Color> gradientColors;

  void Function()? onPressedofAddImage;
  void Function()? onPressedofViewImage;
  void Function()? DeleteDialogPress;
  void Function()? updateOnPressed;
  String? startdate;
  String? enddate;
  String? image;
  String? startTIme;
  String? endTime;
  Color? iconColor;
  Color? startDatecolor;
  Color? endDatecolor;
  bool isShowEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // width: 327.w,
      margin: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 14.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: Color.fromRGBO(187, 187, 187, 0.3),
          width: 0.3.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(50, 50, 71, 0.08),

            blurRadius: 32,
            offset: Offset(0, 24), // changes position of shadow
          ),
        ],
        color: HexColor('#FFFFFF'),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Text(
                        title ?? "NA",
                        maxLines: 2,
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 16.0,
                            color: AppColors.boldHeading,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //DESCRIPTION
                    SizedBox(
                      width: 230,
                      child: Text(
                        description ?? "NA",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 12.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                isShowEvent
                    ? Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: "${Api.imageBaseUrl}${image}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColors.appThem,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showButtons) ...[
                  MyButton(
                      width: 80.w,
                      textColor: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(10),
                      height: 22.h,
                      name: 'AddImage',
                      color: HexColor('#E8E8E8'),
                      elevation: 0,
                      onPressed: onPressedofAddImage),
                  8.pw,
                ],
                if (showButtons) ...[
                  MyButton(
                    elevation: 0,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w400,
                    width: 85.w,
                    height: 22.h,
                    fontSize: ScreenUtil().setSp(10),
                    name: 'View Image',
                    color: primaryColor,
                    onPressed: onPressedofViewImage,
                  ),
                  42.pw,
                ],
                Spacer(),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.appThem),
                  child: IconButton(
                    icon: Image.asset(
                      AppImages.delete,
                      height: 13.h,
                      width: 12.w,
                      color: AppColors.globalWhite,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              image: Image.asset(AppImages.delete,
                                  color: AppColors.globalWhite,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06),
                              negativeBtnPressed: () {
                                Get.back();
                              },
                              title: "Are you sure !",
                              content: "Do you want to delete this?",
                              positiveBtnText: "Delete",
                              negativeBtnText: "Cancel",
                              positiveBtnPressed: DeleteDialogPress,
                            );
                          });
                    },
                  ),
                ),
                6.pw,
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.appThem),
                  child: IconButton(
                    icon: Image.asset(AppImages.update,
                        color: AppColors.globalWhite,
                        height: 13.h,
                        width: 12.w),
                    onPressed: updateOnPressed,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: AppColors.appThem),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: ScreenUtil().setWidth(20),
                          color: iconColor ?? HexColor('#FFFFFF'),
                        ),
                        14.pw,
                        Text(startdate ?? "NA",
                            style: GoogleFonts.ubuntu(
                              color: startDatecolor ?? HexColor('#FFFFFF'),
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0015,
                              fontSize: ScreenUtil().setSp(14),
                            )),
                        27.pw,
                        Text(enddate ?? "NA",
                            style: GoogleFonts.ubuntu(
                              color: endDatecolor ?? HexColor('#FFFFFF'),
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0015,
                              fontSize: ScreenUtil().setSp(14),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: ScreenUtil().setWidth(20),
                          color: iconColor ?? HexColor('#FFFFFF'),
                        ),
                        14.pw,
                        Text(formatTime(startTIme ?? "NA"),
                            style: GoogleFonts.ubuntu(
                              color: startDatecolor ?? HexColor('#FFFFFF'),
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0015,
                              fontSize: ScreenUtil().setSp(14),
                            )),
                        27.pw,
                        Text(formatTime(endTime ?? ""),
                            style: GoogleFonts.ubuntu(
                              color: endDatecolor ?? HexColor('#FFFFFF'),
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0015,
                              fontSize: ScreenUtil().setSp(14),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

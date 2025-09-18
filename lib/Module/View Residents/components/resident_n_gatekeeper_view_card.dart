// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';
import '../../../Widgets/my_dialog_box.dart';

class ResidentsNGateKeeperViewCard extends StatelessWidget {
  ResidentsNGateKeeperViewCard(
      {required this.image,
      required this.name,
      required this.mobileno,
      this.DeleteDialogPress,
      this.updateOnPressed,
      this.isGateKeeper = false,
      this.showButton = true,
      this.isShowNexButton = false,
      this.gateNo});
  String? image;
  String? gateNo;
  String? name;
  String? mobileno;
  bool showButton;
  bool isGateKeeper;

  bool isShowNexButton;

  void Function()? DeleteDialogPress;
  void Function()? updateOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
      width: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.400000095367432.r),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(image ?? ""), fit: BoxFit.cover),
                    )),
                imageUrl: image.toString(),
                placeholder: (context, url) => Column(
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.appThem,
                    ),
                  ],
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              10.pw,
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(
                        name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 18.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    5.ph,
                    Row(
                      children: [
                        Text(
                          "Mobile No : ",
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          mobileno ?? "",
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    5.ph,
                    isGateKeeper
                        ? Row(
                            children: [
                              Text(
                                "Gate No : ",
                                style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 14.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                gateNo ?? "",
                                style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 14.0,
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          )
                        : SizedBox(),
                    showButton
                        ? SizedBox(
                            height: 10,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
              ),
            ]),
            if (showButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.appThem),
                    child: IconButton(
                      icon: SvgPicture.asset(AppImages.deleteNoticeBoard,
                          color: AppColors.globalWhite,
                          width: MediaQuery.of(context).size.width),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                image: SvgPicture.asset(
                                    AppImages.dialogueDeleteIcon,
                                    width: MediaQuery.of(context).size.width *
                                        0.06),
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
                      icon: SvgPicture.asset(AppImages.editIcon,
                          color: AppColors.globalWhite,
                          width: MediaQuery.of(context).size.width),
                      onPressed: updateOnPressed,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

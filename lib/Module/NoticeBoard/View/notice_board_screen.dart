// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Module/NoticeBoard/Controller/notice_board_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../../utils/Constants/constants.dart';
import '../../View Residents/components/Detail_shown_dialog_box.dart';
import '../../Events/component/event_n_noticeboard_view_card.dart';

class NoticeBoardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBoardController>(
      init: NoticeBoardController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
              floatingActionButton: Container(
                decoration: BoxDecoration(
                    gradient: AppGradients.floatingbuttonGradient,
                    shape: BoxShape.circle),
                child: IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.065,
                    icon: Icon(
                      Icons.add,
                      size: 45,
                      color: AppColors.globalWhite,
                    ),
                    onPressed: () {
                      Get.offNamed(addnoticeboardscreen,
                          arguments: controller.user);
                    }),
              ),
              backgroundColor: AppColors.background,
              body: Column(
                children: [
                  MyBackButton(
                    text: 'NoticeBoard',
                    onTap: () {
                      Get.offNamed(homescreen, arguments: controller.user);
                    },
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: controller.data,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null &&
                                snapshot.data!.length != 0) {
                              return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor:
                                                    AppColors.globalWhite,
                                                surfaceTintColor:
                                                    AppColors.globalWhite,
                                                insetAnimationCurve:
                                                    Curves.bounceIn,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: SizedBox(
                                                  // height: ScreenUtil()
                                                  //     .setHeight(350),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(12),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .noticetitle,
                                                              style:
                                                                  reusableTextStyle(
                                                                textStyle:
                                                                    GoogleFonts
                                                                        .dmSans(),
                                                                fontSize: 20.0,
                                                                color: AppColors
                                                                    .boldHeading,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            10.ph,
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .noticedetail,
                                                              style:
                                                                  reusableTextStyle(
                                                                textStyle:
                                                                    GoogleFonts
                                                                        .dmSans(),
                                                                fontSize: 16.0,
                                                                color: AppColors
                                                                    .boldHeading,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        20.ph,
                                                        // DetailShownDialogBox(
                                                        //     icon:
                                                        //         AppImages.date2,
                                                        //     heading:
                                                        //         'Start Dtae',
                                                        //     isPng: true,
                                                        //     text: snapshot
                                                        //         .data![index]
                                                        //         .startdate),
                                                        // DetailShownDialogBox(
                                                        //     icon:
                                                        //         AppImages.date2,
                                                        //     heading: 'End Date',
                                                        //     isPng: true,
                                                        //     text: snapshot
                                                        //         .data![index]
                                                        //         .enddate
                                                        //         .toString()),
                                                        DetailShownDialogBox(
                                                            icon: AppImages
                                                                .timeIcon,
                                                            heading:
                                                                'Notice Time',
                                                            text: Hour12formatTime(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .starttime
                                                                    .toString())),
                                                        // DetailShownDialogBox(
                                                        //     icon: AppImages
                                                        //         .timeIcon,
                                                        //     heading: 'End Time',
                                                        //     text: Hour12formatTime(
                                                        //         snapshot
                                                        //             .data![
                                                        //                 index]
                                                        //             .endtime
                                                        //             .toString())),
                                                        MyButton(
                                                          width:
                                                              double.infinity,
                                                          name: "Okay",
                                                          gradient: AppGradients
                                                              .buttonGradient,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: EventnNoticeBoardViewCard(
                                        title: snapshot.data![index].noticetitle
                                            .toString(),
                                        description: snapshot
                                            .data![index].noticedetail
                                            .toString(),
                                        showButtons: false,
                                        eventCardDesginImg:
                                            AppImages.eventCardLeft,
                                        showeventCardDesginImg: true,
                                        DeleteDialogPress: () {
                                          controller.currentNoticeBoardId =
                                              snapshot.data![index].id;

                                          controller.deleteNoticeBoardApi(
                                              controller.currentNoticeBoardId,
                                              controller.userdata.bearerToken!);
                                        },
                                        updateOnPressed: () {
                                          Get.offNamed(updatenoticeboardscreen,
                                              arguments: [
                                                snapshot.data![index],
                                                controller.user
                                              ]);
                                        },
                                        startdate: snapshot
                                            .data![index].startdate
                                            .toString(),
                                        enddate: snapshot.data![index].enddate
                                            .toString(),
                                        gradientColors: [
                                          HexColor("#F2F2F2"),
                                          HexColor("#F2F2F2")
                                        ],
                                        startTIme: snapshot
                                            .data![index].starttime
                                            .toString(),
                                        iconColor: AppColors.globalWhite,
                                        startDatecolor: AppColors.globalWhite,
                                        endDatecolor: AppColors.globalWhite,
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data!.length);
                            } else {
                              return Center(
                                  child: Text(
                                'No Notices',
                                style: GoogleFonts.ubuntu(
                                    color: HexColor('#404345'),
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.0015,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ));
                            }
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(
                                child: CircularIndicatorUnderWhiteBox());
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

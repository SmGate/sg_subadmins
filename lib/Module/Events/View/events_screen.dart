// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Module/Events/Controller/event_screen_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';
import '../../View Residents/components/Detail_shown_dialog_box.dart';
import '../component/event_n_noticeboard_view_card.dart';

class EventsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventScreenController>(
        init: EventScreenController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);

              return true;
            },
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.background,
                  floatingActionButton: Container(
                    decoration: BoxDecoration(
                        gradient: AppGradients.floatingbuttonGradient,
                        shape: BoxShape.circle),
                    child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.add,
                          weight: 30,
                          color: AppColors.globalWhite,
                        ),
                        onPressed: () {
                          Get.offNamed(addeventsscreen,
                              arguments: controller.user);
                        }),
                  ),
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Events',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                        widget: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                              surfaceTintColor: AppColors.globalWhite,
                              color: AppColors.globalWhite,
                              icon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 150),
                                child: Icon(
                                  Icons.filter_list,
                                  color: AppColors.appThem,
                                ),
                              ),
                              initialValue: controller.eventVal,
                              onOpened: () {},
                              onSelected: (val) {
                                controller.eventVal = val.toString();

                                controller.setEventVal(controller.eventVal);
                                controller.data = controller.searchEventsApi(
                                    userid: controller.userdata.userid!,
                                    token: controller.userdata.bearerToken!,
                                    query: controller.eventVal);
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      value: 'Default', child: Text('Default')),
                                  PopupMenuItem(
                                      value: 'Oldest', child: Text('Oldest')),
                                  PopupMenuItem(
                                    value: 'Newest',
                                    child: Text('Newest'),
                                  ),
                                ];
                              }),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                            future: controller.data,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data.data.length != 0) {
                                  return controller.isSearch
                                      ? CircularIndicatorUnderWhiteBox()
                                      : ListView.builder(
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            AppColors
                                                                .globalWhite,
                                                        surfaceTintColor:
                                                            AppColors
                                                                .globalWhite,
                                                        insetAnimationCurve:
                                                            Curves.bounceIn,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                        child: SizedBox(
                                                          // height: ScreenUtil()
                                                          //     .setHeight(350),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      snapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .title,
                                                                      style: reusableTextStyle(
                                                                          textStyle: GoogleFonts
                                                                              .dmSans(),
                                                                          fontSize:
                                                                              18.0,
                                                                          color: AppColors
                                                                              .textBlack,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    10.ph,
                                                                    Text(
                                                                      snapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .description,
                                                                      style: reusableTextStyle(
                                                                          textStyle: GoogleFonts
                                                                              .dmSans(),
                                                                          fontSize:
                                                                              14.0,
                                                                          color: AppColors
                                                                              .textBlack,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                ),
                                                                20.ph,
                                                                DetailShownDialogBox(
                                                                    icon: AppImages
                                                                        .date2,
                                                                    isPng: true,
                                                                    color: AppColors
                                                                        .textBlack,
                                                                    heading:
                                                                        'Start Date',
                                                                    text: snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .startdate),
                                                                DetailShownDialogBox(
                                                                    icon: AppImages
                                                                        .date2,
                                                                    isPng: true,
                                                                    heading:
                                                                        'End Date',
                                                                    text: snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .enddate
                                                                        .toString()),
                                                                if (snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .active ==
                                                                    1) ...[
                                                                  DetailShownDialogBox(
                                                                      icon: AppImages
                                                                          .calender,
                                                                      heading:
                                                                          'Event Status',
                                                                      text: 'Event Active'
                                                                          .toString()),
                                                                ] else ...[
                                                                  DetailShownDialogBox(
                                                                      icon: AppImages
                                                                          .calender,
                                                                      heading:
                                                                          'Event Status',
                                                                      text: 'Event InActive'
                                                                          .toString()),
                                                                ],
                                                                MyButton(
                                                                  width: double
                                                                      .infinity,
                                                                  name: "Okay",
                                                                  gradient:
                                                                      AppGradients
                                                                          .buttonGradient,
                                                                  onPressed:
                                                                      () {
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
                                                eventCardDesginImg:
                                                    AppImages.eventCardLeft,
                                                title: snapshot
                                                    .data.data[index].title
                                                    .toString(),
                                                showButtons: false,
                                                description: snapshot.data
                                                    .data[index].description,
                                                onPressedofAddImage: () {
                                                  controller.selectImages();
                                                },
                                                onPressedofViewImage: () {},
                                                gradientColors: [
                                                  HexColor('#FF9900'),
                                                  HexColor('#FB7712'),
                                                ],
                                                DeleteDialogPress: () {
                                                  controller.deleteEventApi(
                                                      snapshot
                                                          .data.data[index].id,
                                                      controller.userdata
                                                          .bearerToken!);
                                                },
                                                updateOnPressed: () {
                                                  print(snapshot
                                                      .data.data[index]);

                                                  Get.offAndToNamed(updateevent,
                                                      arguments: [
                                                        controller.user,
                                                        snapshot
                                                            .data.data[index]
                                                      ]);
                                                },
                                                startdate: snapshot
                                                    .data.data[index].startdate
                                                    .toString(),
                                                enddate: snapshot
                                                    .data.data[index].enddate
                                                    .toString(),
                                                startTIme: snapshot
                                                    .data.data[index].startTime
                                                    .toString(),
                                                endTime: snapshot
                                                    .data.data[index].endTime
                                                    .toString(),
                                                image: snapshot.data.data[index]
                                                    .images[0].image
                                                    .toString(),
                                                isShowEvent: true,
                                              ),
                                            );
                                          },
                                          itemCount: snapshot.data.data.length);
                                } else {
                                  return EmptyList(name: 'No Events');
                                }
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return CircularIndicatorUnderWhiteBox();
                              }
                            }),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}

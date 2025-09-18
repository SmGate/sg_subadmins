// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/Module/GateKepeer/Controller/gate_keeper_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

import '../../View Residents/components/Detail_shown_dialog_box.dart';
import '../../View Residents/components/resident_n_gatekeeper_view_card.dart';

class GateKeeperScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GateKeeperController>(
      init: GateKeeperController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);

          return true;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                MyBackButton(
                  text: "Gatekeepers",
                  onTap: () {
                    Get.offNamed(homescreen, arguments: controller.user);
                  },
                ),
                Expanded(
                  child: FutureBuilder(
                      future: controller.viewGatekeepersApi(
                          controller.user.userid ?? 0,
                          controller.userdata.bearerToken!),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null &&
                              snapshot.data!.length != 0) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
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
                                                                    .data![
                                                                        index]
                                                                    .firstName +
                                                                " " +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .lastName,
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
                                                                .mobileno,
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
                                                      DetailShownDialogBox(
                                                        icon: AppImages.person,
                                                        isPng: true,
                                                        heading: 'Name',
                                                        text: snapshot
                                                                .data![index]
                                                                .firstName +
                                                            " " +
                                                            snapshot
                                                                .data![index]
                                                                .lastName,
                                                      ),
                                                      DetailShownDialogBox(
                                                          icon:
                                                              AppImages.contact,
                                                          isPng: true,
                                                          heading: 'Mobile No',
                                                          text: snapshot
                                                              .data![index]
                                                              .mobileno
                                                              .toString()),
                                                      DetailShownDialogBox(
                                                          icon:
                                                              AppImages.address,
                                                          isPng: true,
                                                          heading: 'Address',
                                                          text: snapshot
                                                              .data![index]
                                                              .address),
                                                      DetailShownDialogBox(
                                                          icon:
                                                              AppImages.gateNo,
                                                          isPng: true,
                                                          heading: 'Gate No',
                                                          text: snapshot
                                                              .data![index]
                                                              .gateno),
                                                      DetailShownDialogBox(
                                                          icon: AppImages.cnic,
                                                          isPng: true,
                                                          heading: 'CNIC',
                                                          text: snapshot
                                                              .data![index]
                                                              .cnic),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      MyButton(
                                                        width: double.infinity,
                                                        name: "Okay",
                                                        gradient: AppGradients
                                                            .buttonGradient,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: ResidentsNGateKeeperViewCard(
                                      image: Api.imageBaseUrl +
                                          snapshot.data![index].image
                                              .toString(),
                                      name: snapshot.data![index].firstName
                                              .toString() +
                                          " " +
                                          snapshot.data![index].lastName
                                              .toString(),
                                      mobileno: snapshot.data![index].mobileno
                                          .toString(),
                                      updateOnPressed: () {
                                        Get.offAndToNamed(
                                            updategatekeeperscreen,
                                            arguments: [
                                              snapshot.data![index],
                                              controller.user
                                            ]);
                                      },
                                      DeleteDialogPress: () {
                                        controller.deleteGateKeeperApi(
                                            snapshot.data![index].gatekeeperid,
                                            controller.userdata.bearerToken!,
                                            context);
                                      },
                                      gateNo: snapshot.data![index].gateno
                                          .toString(),
                                      isGateKeeper: true,
                                    ));
                              },
                              itemCount: snapshot.data!.length,
                            );
                          } else {
                            return EmptyList(
                              name: 'No GateKeepers',
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return CircularIndicatorUnderWhiteBox();
                        }
                      }),
                ),
              ],
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                  gradient: AppGradients.floatingbuttonGradient,
                  shape: BoxShape.circle),
              child: IconButton(
                  // padding: EdgeInsets.only(top: 85.w),
                  iconSize: 40.w,
                  icon: Icon(
                    Icons.add,
                    weight: 30,
                    color: AppColors.globalWhite,
                  ),
                  onPressed: () {
                    Get.offNamed(addgatekeeperscreen,
                        arguments: controller.user);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

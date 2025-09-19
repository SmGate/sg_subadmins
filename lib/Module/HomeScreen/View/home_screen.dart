// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:societyadminapp/Module/HomeScreen/View/menu_section.dart';
import 'package:societyadminapp/Module/Login/Controller/login_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class HomeScreen extends GetView {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool isTablet(BuildContext context) {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            resizeToAvoidBottomInset: true,
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                        child: SizedBox(
                          child: Text(
                            controller.user.societyorbuildingname ?? "",
                            style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 18.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: isTablet(context) ? 60 : 20,
                          right: isTablet(context) ? 60 : 20),
                      child: Stack(
                        children: [
                          CustomCard(
                            color: AppColors.appThem,
                            onTap: () {},
                            boxShadow: BoxShadow(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.globalWhite)),
                                        child: Center(
                                            child: Image.asset(
                                          AppImages.user,
                                        )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          controller.user.firstName! +
                                              " " +
                                              controller.user.lastName!,
                                          style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 18.0,
                                            color: AppColors.globalWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          controller.user.mobileno!,
                                          style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 12.0,
                                            color: AppColors.globalWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.count == 0
                                      ? IconButton(
                                          icon: SvgPicture.asset(
                                            AppImages.notification,
                                            color: AppColors.globalWhite,
                                            height: 25,
                                          ),
                                          onPressed: () {
                                            controller.count = 0;
                                            controller.update();
                                            Get.offNamed(
                                                reportnotificationsscreen,
                                                arguments: controller.user);
                                          })
                                      : badges.Badge(
                                          position:
                                              badges.BadgePosition.bottomEnd(
                                                  end: 4, bottom: 22),
                                          badgeContent: Text(
                                            controller.count >= 100
                                                ? controller
                                                    .countGreaterThanHundred
                                                : controller.count.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          child: IconButton(
                                              icon: SvgPicture.asset(
                                                AppImages.notification,
                                                color: AppColors.globalWhite,
                                                height: 25,
                                              ),
                                              onPressed: () {
                                                controller.count = 0;
                                                controller.update();
                                                Get.offNamed(
                                                    reportnotificationsscreen,
                                                    arguments: controller.user);
                                              }),
                                        ),
                                  IconButton(
                                    onPressed: () {
                                      showMenu(
                                        surfaceTintColor: AppColors.globalWhite,
                                        color: AppColors.globalWhite,
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            100,
                                            100,
                                            0,
                                            0), // Adjust the position as needed
                                        items: [
                                          if (controller.user
                                                  .permissions?['chat_mod'] ==
                                              true) ...[
                                            PopupMenuItem(
                                              onTap: () {
                                                Get.offNamed(showAllResident,
                                                    arguments: controller.user);
                                              },
                                              child: Text('Chat Moderator'),
                                              value: 'chat_moderator',
                                            ),
                                          ],
                                          if (controller.user.permissions?[
                                                  'blocked_user'] ==
                                              true) ...[
                                            PopupMenuItem(
                                              onTap: () {
                                                Get.offNamed(blockedUser,
                                                    arguments: controller.user);
                                              },
                                              child: Text('Blocked User'),
                                              value: 'blocked_user',
                                            ),
                                          ],
                                          if (controller.user.permissions?[
                                                  'laguage_pass'] ==
                                              true) ...[
                                            PopupMenuItem(
                                              onTap: () {
                                                Get.offNamed(getAllLuggagePass,
                                                    arguments: controller.user);
                                              },
                                              child: Text('Luggage Pass'),
                                              value: 'luggage_pass',
                                            ),
                                          ],
                                          if (controller
                                                  .user.permissions?['rules'] ==
                                              true) ...[
                                            PopupMenuItem(
                                              onTap: () {
                                                Get.offNamed(societyRule,
                                                    arguments: controller.user);
                                              },
                                              child: Text('Rules'),
                                              value: 'rules',
                                            ),
                                          ],
                                          PopupMenuItem(
                                            onTap: () {
                                              Get.offNamed(rentSettlement,
                                                  arguments: controller.user);
                                            },
                                            child: Text('Rent Settlement'),
                                            value: 'rules',
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              Get.dialog(
                                                AlertDialog(
                                                  title: const Text(
                                                      "Delete Account"),
                                                  content: const Text(
                                                      "Are you sure you want to delete your account?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back(); // Close dialog
                                                      },
                                                      child: Text(
                                                        "No",
                                                        style:
                                                            reusableTextStyle(
                                                                color: AppColors
                                                                    .appThem),
                                                      ),
                                                    ),
                                                    Obx(() => ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .appThem,
                                                          ),
                                                          onPressed: () {
                                                            LoginController()
                                                                .deleteAccount(
                                                              userId: controller
                                                                  .user.userid
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: LoginController()
                                                                  .deletingAccount
                                                                  .value
                                                              ? SizedBox(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              : const Text(
                                                                  "Yes",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .globalWhite),
                                                                ),
                                                        )),
                                                  ],
                                                ),
                                                barrierDismissible: false,
                                              );
                                            },
                                            child: Text('Delete Account'),
                                            value: 'delete',
                                          ),
                                        ],
                                      ).then((value) {
                                        // Handle the selected item
                                        if (value != null) {
                                          print('Selected: $value');
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.settings,
                                      color: AppColors.globalWhite,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: SvgPicture.asset(
                                AppImages.eventCardLeft,
                                color: AppColors.globalWhite,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: MenuSection(controller: controller),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

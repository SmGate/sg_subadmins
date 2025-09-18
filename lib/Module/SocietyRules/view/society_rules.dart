// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/SocietyRules/controller/society_rule_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class AllSocietyRules extends StatelessWidget {
  const AllSocietyRules({super.key});

  @override
  Widget build(BuildContext context) {
    var societyRulesController = Get.find<SocietyRuleController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: societyRulesController.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: "Rules",
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: societyRulesController.user);
                },
              ),
              Expanded(
                child: FutureBuilder(
                    future: societyRulesController.getAllRules(
                        societyId: societyRulesController.userdata.societyid
                            .toString()),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            societyRulesController
                                    .societyRulesModel.data?.length !=
                                0) {
                          return ListView.builder(
                              itemCount: societyRulesController
                                  .societyRulesModel.data?.length,
                              itemBuilder: (contex, index) {
                                var data = societyRulesController
                                    .societyRulesModel.data?[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: index == 0 ? 20 : 20,
                                      left: 20,
                                      right: 20),
                                  child: CustomCard(
                                      boxShadow: BoxShadow(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 20,
                                            right: 20),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImages.rules,
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data?.title ?? "",
                                                  style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 16.0,
                                                    color: AppColors.textBlack,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    data?.description ?? "",
                                                    style: reusableTextStyle(
                                                      textStyle:
                                                          GoogleFonts.dmSans(),
                                                      fontSize: 16.0,
                                                      color: AppColors.dark,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              });
                        } else {
                          return EmptyList(
                            name: 'No Rules Added Yet',
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
                  Get.offNamed(addSocietyRule,
                      arguments: societyRulesController.user);
                }),
          ),
        ),
      ),
    );
  }
}

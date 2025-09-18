// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/luggage_pass/controller/luggage_pass_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class GetAllLuggagePassScreen extends StatelessWidget {
  const GetAllLuggagePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var luggagePassController = Get.put(LuggagePassController());

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: luggagePassController.userdata);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Back Button with Title
              MyBackButton(
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: luggagePassController.userdata);
                },
                text: "Luggage Pass",
              ),

              Flexible(
                child: FutureBuilder(
                  future: luggagePassController.getAllLuggagePassEntry(
                    societyId:
                        luggagePassController.userdata.societyid.toString(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularIndicatorUnderWhiteBox());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: luggagePassController
                            .getAllLuggagePassModel.data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: index == 0 ? 20 : 10,
                                bottom: 10),
                            child: CustomCard(
                              onTap: () {
                                luggagePassController.getAllLuggagePassModel
                                                .data?[index].status ==
                                            "Approved" ||
                                        luggagePassController
                                                .getAllLuggagePassModel
                                                .data?[index]
                                                .status ==
                                            "Passed"
                                    ? null
                                    : _showApprovalDialog(
                                        context: context,
                                        onpressed: () {
                                          luggagePassController
                                              .updateLuggagePassStatus(
                                                  passId: luggagePassController
                                                      .getAllLuggagePassModel
                                                      .data?[index]
                                                      .id
                                                      .toString());
                                        },
                                        loading: luggagePassController
                                            .isLoading.value);
                              },
                              width: double.infinity,
                              boxShadow: BoxShadow(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Type",
                                              style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 14.0,
                                                color: AppColors.textBlack,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              luggagePassController
                                                      .getAllLuggagePassModel
                                                      .data?[index]
                                                      .type ??
                                                  "",
                                              style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 14.0,
                                                color: luggagePassController
                                                            .getAllLuggagePassModel
                                                            .data?[index]
                                                            .type ==
                                                        "Incoming"
                                                    ? AppColors.green
                                                    : AppColors.colorRed,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: luggagePassController
                                                          .getAllLuggagePassModel
                                                          .data?[index]
                                                          .status ==
                                                      "Pending"
                                                  ? Colors.red
                                                  : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              luggagePassController
                                                      .getAllLuggagePassModel
                                                      .data?[index]
                                                      .status ??
                                                  "",
                                              style: reusableTextStyle(
                                                textStyle: GoogleFonts.dmSans(),
                                                fontSize: 12.0,
                                                color: AppColors.globalWhite,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      luggagePassController
                                              .getAllLuggagePassModel
                                              .data?[index]
                                              .description ??
                                          "",
                                      style: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 16.0,
                                        color: AppColors.dark,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return Center(child: Text("No Data"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showApprovalDialog({
    BuildContext? context,
    Function? onpressed,
    bool? loading = false,
  }) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to approve this pass?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onpressed!();

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: loading!
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.globalWhite,
                      ))
                  : Text('Approve'),
            ),
          ],
        );
      },
    );
  }
}

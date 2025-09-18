// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/View%20Residents/components/Detail_shown_dialog_box.dart';
import 'package:societyadminapp/Module/Visitors%20Logs/controller/visitors_logs_controller.dart';
import 'package:societyadminapp/Module/Visitors%20Logs/model/visitors_logs_model.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/Widgets/loading.dart';

import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../Widgets/my_button.dart';
import '../../../utils/Constants/app_images.dart';
import '../../../utils/helpers/date_helpers.dart';
import '../../../utils/style/text_style.dart';

class VisitorsLogsScreen extends StatefulWidget {
  const VisitorsLogsScreen({super.key});

  @override
  State<VisitorsLogsScreen> createState() => _VisitorsLogsScreenState();
}

class _VisitorsLogsScreenState extends State<VisitorsLogsScreen> {
  @override
  Widget build(BuildContext context) {
    var visitorsLogsController = Get.find<VisitorsLogsController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: visitorsLogsController.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: "Visitors Logs",
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: visitorsLogsController.user);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 20, left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: MyTextFormField(
                    padding: EdgeInsets.all(0),
                    hintText: "Search Name",
                    labelText: "Search Name",
                    onChanged: (v) {
                      setState(() {
                        visitorsLogsController.searchValue.value = v;
                      });
                    },
                  ),
                ),
              ),
              Obx(() {
                if (visitorsLogsController.isLoading.value &&
                    (visitorsLogsController.visitorsList == null ||
                        visitorsLogsController.visitorsList!.isEmpty)) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: CircularIndicatorUnderWhiteBox(),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    controller: visitorsLogsController.scrollController,
                    itemCount:
                        (visitorsLogsController.visitorsList?.length ?? 0) +
                            (visitorsLogsController.hasMoreData ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >=
                          (visitorsLogsController.visitorsList?.length ?? 0)) {
                        if (visitorsLogsController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColors.appThem),
                          );
                        } else {
                          return Center(child: Text(""));
                        }
                      }

                      // Display item
                      var visitor = visitorsLogsController.visitorsList?[index];

                      String name = visitor?.name ?? "";

                      if (name
                          .toLowerCase()
                          .contains(visitorsLogsController.searchValue.value)) {
                        return VisitorsCard(
                            visitor: visitor,
                            index: index,
                            visitorsLogsController: visitorsLogsController);
                      } else if (visitorsLogsController.searchValue.value ==
                          "") {
                        return VisitorsCard(
                            visitor: visitor,
                            index: index,
                            visitorsLogsController: visitorsLogsController);
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class VisitorsCard extends StatelessWidget {
  VisitorsCard(
      {super.key,
      required this.visitor,
      required this.visitorsLogsController,
      required this.index});

  final Datum? visitor;
  final VisitorsLogsController visitorsLogsController;
  int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return CustomCard(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: AppColors.globalWhite,
              surfaceTintColor: AppColors.globalWhite,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          child: Text(
                            visitor?.name ?? "",
                            style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 18.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DetailShownDialogBox(
                          icon: AppImages.contact,
                          heading: 'Mobile No',
                          isPng: true,
                          text: visitor?.mobileno ?? "",
                        ),
                        DetailShownDialogBox(
                          heading: "CNIC",
                          text: visitor?.cnic ?? "",
                          icon: AppImages.cnic,
                          isPng: true,
                        ),
                        DetailShownDialogBox(
                          heading: "Visitor TYPE",
                          text: visitor?.visitortype ?? "",
                          icon: AppImages.visitorDetails,
                          isPng: true,
                        ),
                        DetailShownDialogBox(
                          heading: "Vehicle No",
                          text: visitor?.vechileno ?? "NA",
                          icon: AppImages.vahicleNo,
                          isPng: true,
                        ),
                        DetailShownDialogBox(
                          heading: "Arrival Date",
                          text: DateHelpers().formatDate(
                              visitor?.arrivaldate?.toString() ?? "NA"),
                          icon: AppImages.date2,
                          isPng: true,
                        ),
                        DetailShownDialogBox(
                          heading: "Check In Time",
                          text: visitor?.checkintime ?? "NA",
                          icon: AppImages.timeIcon,
                          isPng: false,
                        ),
                        DetailShownDialogBox(
                          heading: "Check Out Time",
                          text: visitor?.checkouttime ?? "NA",
                          icon: AppImages.timeIcon,
                          isPng: false,
                        ),
                        SizedBox(height: 20),
                        MyButton(
                          name: "Okay",
                          gradient: AppGradients.buttonGradient,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      boxShadow: BoxShadow(),
      margin: EdgeInsets.only(
        top: index == 0 ? 20 : 20,
        left: 20,
        right: 20,
        bottom: index == (visitorsLogsController.visitorsList?.length ?? 0) - 1
            ? 20
            : 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(AppImages.user, height: 50),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    textAlign: TextAlign.start,
                    visitor?.name ?? "",
                    style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Visitor Type"),
                        Text("Vehicle No"),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visitor?.visitortype ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          visitor?.vechileno ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

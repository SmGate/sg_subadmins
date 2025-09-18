// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/AddNoticeBoard/Controller/add_notice_board_controller.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_textform_field.dart';

class AddNoticeBoardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<AddNoticeBoardScreenController>(
            init: AddNoticeBoardScreenController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(noticeboardscreen, arguments: controller.user);

                  return true;
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        MyBackButton(
                          text: 'Add Notice',
                          onTap: () {
                            Get.offNamed(noticeboardscreen,
                                arguments: controller.user);
                          },
                        ),
                        20.ph,
                        Image.asset(
                          AppImages.updateEnevts,
                          height: 200,
                        ),
                        20.ph,
                        MyTextFormField(
                          fillColor: Colors.white,
                          controller: controller.noticetitleController,
                          validator: emptyStringValidator,
                          hintText: 'NOTICE TITLE',
                          labelText: 'NOTICE TITLE',
                        ),
                        MyTextFormField(
                          maxLines: 5,
                          // contentPadding: EdgeInsets.symmetric(
                          //     vertical: 30, horizontal: 20),
                          fillColor: Colors.white,
                          controller: controller.noticedescriptionController,
                          validator: emptyStringValidator,
                          hintText: 'ENTER DESCRIPTION',
                          labelText: 'ENTER DESCRIPTION',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.NoticeStartDate(context);
                          },
                          fillColor: Colors.white,
                          controller: controller.startnoticedateController,
                          validator: emptyStringValidator,
                          hintText: 'Choose START Date',
                          labelText: 'Choose START Date',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.NoticeEndDate(context);
                          },
                          fillColor: Colors.white,
                          controller: controller.endnoticedateController,
                          validator: emptyStringValidator,
                          hintText: 'Choose END Date',
                          labelText: 'Choose END Date',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.NoticeStartTime(context);
                          },
                          fillColor: Colors.white,
                          controller: controller.startnoticetimeController,
                          validator: emptyStringValidator,
                          hintText: 'Choose START TIME',
                          labelText: 'Choose START TIME',
                        ),
                        MyTextFormField(
                          onTap: () {
                            controller.NoticeEndTime(context);
                          },
                          fillColor: Colors.white,
                          controller: controller.endnoticetimeController,
                          validator: emptyStringValidator,
                          hintText: 'Choose END TIME',
                          labelText: 'Choose END TIME',
                        ),
                        10.h.ph,
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 40),
                          title: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text('Hide DateTime',
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    letterSpacing: 0.05)),
                          ),
                          trailing: Checkbox(
                            value: controller.checkBoxValue,
                            onChanged: (newValue) {
                              controller.setCheckBox(newValue);
                            },
                          ),
                        ),
                        65.ph,
                        MyButton(
                          gradient: AppGradients.buttonGradient,
                          loading: controller.isLoading,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.isLoading == false) {
                                controller.addNoticeBoardApi(
                                    dateTimeVisibility:
                                        controller.dateTimeVisibility,
                                    noticetitle:
                                        controller.noticetitleController.text,
                                    noticedes: controller
                                        .noticedescriptionController.text,
                                    startdate: controller
                                        .startnoticedateController.text,
                                    enddate:
                                        controller.endnoticedateController.text,
                                    starttime: controller
                                        .startnoticetimeController.text,
                                    endtime:
                                        controller.endnoticetimeController.text,
                                    bearerToken:
                                        controller.userdata!.bearerToken!,
                                    subadminid: controller.userdata!.userid!);
                              }
                            } else {
                              return null;
                            }
                          },
                          textColor: Colors.white,
                          color: primaryColor,
                          name: 'Save',
                          maxLines: 1,
                        ),
                        18.2.ph,
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

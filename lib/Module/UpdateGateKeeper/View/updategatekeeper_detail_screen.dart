// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/Module/UpdateGateKeeper/Controller/reset_password_controller.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_text.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../utils/CustomImagePicker/custom_image_picker.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_password_textform_field.dart';
import '../../../Widgets/my_textform_field.dart';
import '../Controller/update_gate_keeper_controller.dart';

class UpdateGateKepeerScreen extends GetView {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateGateKeeperController>(
        init: UpdateGateKeeperController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offAndToNamed(gatekeeperscreen, arguments: controller.user);

              return true;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MyBackButton(
                          text: 'Update Gatekeeper',
                          onTap: () {
                            Get.offAndToNamed(gatekeeperscreen,
                                arguments: controller.user);
                          },
                        ),
                        21.35.ph,
                        CustomImagePicker(
                            backgroundImage: controller.imageFile == null
                                ? NetworkImage(Api.imageBaseUrl +
                                        controller.gatekeeper.image.toString())
                                    as ImageProvider
                                : FileImage(
                                    File(controller.imageFile!.path),
                                  ),
                            camOnPressed: () {
                              controller.getFromCamera(ImageSource.camera);
                            },
                            galOnPressed: () {
                              controller.getFromGallery(ImageSource.gallery);
                            }),
                        20.ph,
                        MyTextFormField(
                          controller: controller.fnameController,
                          validator: emptyStringValidator,
                          hintText: 'First Name',
                          labelText: 'Enter First Name',
                        ),
                        MyTextFormField(
                          controller: controller.lnameController,
                          validator: emptyStringValidator,
                          hintText: 'Last Name',
                          labelText: 'Enter Last Name',
                        ),
                        MyTextFormField(
                          textInputType: TextInputType.number,
                          controller: controller.mobilenoController,
                          validator: emptyStringValidator,
                          hintText: 'Mobile nO',
                          labelText: 'Enter Mobile No',
                        ),
                        MyTextFormField(
                          controller: controller.addressController,
                          validator: emptyStringValidator,
                          hintText: 'Address ',
                          labelText: 'Enter Address',
                        ),
                        MyTextFormField(
                          textInputType: TextInputType.number,
                          controller: controller.gatenoController,
                          validator: emptyStringValidator,
                          hintText: 'Gate No ',
                          labelText: 'Enter Gate No',
                        ),
                        30.ph,
                        MyButton(
                          loading: controller.isLoading,
                          gradient: AppGradients.buttonGradient,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.isLoading == false) {
                                controller.updateGatekeeperApi(
                                    gatekeeperid: controller.gatekeeper.id!,
                                    gatekeeperfirstname:
                                        controller.fnameController.text,
                                    gatekeeperlastname:
                                        controller.lnameController.text,
                                    gatekeepergateno:
                                        controller.gatenoController.text,
                                    gatekeepermobileno:
                                        controller.mobilenoController.text,
                                    gatekeeperaddress:
                                        controller.addressController.text,
                                    image: controller.imageFile,
                                    bearerToken: controller.user.bearerToken!);
                              }
                            }
                          },
                          name: 'Update',
                          width: 180.25872802734375.w,
                          height: 43.h,
                        ),
                        20.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 14.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                      title: 'Reset Password',
                                      content:
                                          GetBuilder<ResetPasswordController>(
                                              init: ResetPasswordController(),
                                              builder:
                                                  (resetPasswordController) {
                                                return Form(
                                                  key: resetPasswordController
                                                      .formKey,
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        AppImages.resetPassward,
                                                        width: 200.w,
                                                      ),
                                                      20.ph,
                                                      MyPasswordTextFormField(
                                                          validator:
                                                              emptyStringValidator,
                                                          labelText: 'Password',
                                                          hintText: 'Password',
                                                          togglePasswordView:
                                                              resetPasswordController
                                                                  .togglePasswordView,
                                                          controller:
                                                              resetPasswordController
                                                                  .passwordController,
                                                          obscureText:
                                                              resetPasswordController
                                                                  .isHidden),
                                                      20.ph,
                                                      MyButton(
                                                        gradient: AppGradients
                                                            .buttonGradient,
                                                        loading:
                                                            resetPasswordController
                                                                .isLoading,
                                                        name: 'Reset Password',
                                                        onPressed: () {
                                                          if (resetPasswordController
                                                              .formKey
                                                              .currentState!
                                                              .validate()) {
                                                            if (!resetPasswordController
                                                                .isLoading) {
                                                              resetPasswordController.resetPasswordApi(
                                                                  gateKeeperId:
                                                                      controller
                                                                          .gatekeeper
                                                                          .id!,
                                                                  bearerToken:
                                                                      controller
                                                                          .user
                                                                          .bearerToken!,
                                                                  password:
                                                                      resetPasswordController
                                                                          .passwordController
                                                                          .text);
                                                            }
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }));
                                },
                                child: MyText(
                                  name: 'Reset',
                                  color: AppColors.appThem,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

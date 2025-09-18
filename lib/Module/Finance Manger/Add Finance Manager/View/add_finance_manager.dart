// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../../utils/Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../utils/CustomImagePicker/custom_image_picker.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Widgets/my_password_textform_field.dart';
import '../../../../Widgets/my_textform_field.dart';
import '../Controller/add_finance_manager_controller.dart';

class AddFinanceManager extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFinanceManagerController>(
        init: AddFinanceManagerController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offNamed(viewFinanceManager,
                  arguments: controller.user);
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
                            text: 'Add Finance Manager',
                            onTap: () {
                              Get.offNamed(viewFinanceManager,
                                  arguments: controller.user);
                            },
                          ),
                          25.35.ph,
                          CustomImagePicker(
                            backgroundImage: controller.imageFile == null
                                ? AssetImage(AppImages.user) as ImageProvider
                                : FileImage(
                                    File(controller.imageFile!.path),
                                  ),
                            camOnPressed: () {
                              controller.getFromCamera(ImageSource.camera);
                            },
                            galOnPressed: () {
                              controller.getFromGallery(ImageSource.gallery);
                            },
                          ),
                          31.96.ph,
                          MyTextFormField(
                            controller: controller.firstNameController,
                            validator: emptyStringValidator,
                            hintText: 'First Name',
                            labelText: 'Enter First Name',
                          ),
                          MyTextFormField(
                            controller: controller.lastNameController,
                            validator: emptyStringValidator,
                            hintText: 'Last Name',
                            labelText: 'Enter Last Name',
                          ),
                          MyTextFormField(
                            textInputType: TextInputType.number,
                            controller: controller.cnicController,
                            validator: emptyStringValidator,
                            hintText: 'Cnic',
                            labelText: 'Enter Cnic ',
                            maxLength: 15,
                            onChanged: (value) {
                              String formattedText = formatText(value);

                              controller.cnicController.value =
                                  TextEditingValue(
                                text: formattedText,
                                selection: TextSelection.collapsed(
                                    offset: formattedText.length),
                              );
                            },
                          ),
                          MyTextFormField(
                            controller: controller.addressController,
                            validator: emptyStringValidator,
                            hintText: 'Email',
                            labelText: 'Enter Email ',
                          ),
                          MyTextFormField(
                            textInputType: TextInputType.number,
                            controller: controller.mobileNoController,
                            validator: emptyStringValidator,
                            hintText: 'Mobile No',
                            labelText: 'Enter Mobile No ',
                          ),
                          MyPasswordTextFormField(
                            maxLines: 1,
                            controller: controller.passwordController,
                            obscureText: controller.isHidden,
                            togglePasswordView: controller.togglePasswordView,
                            validator: emptyStringValidator,
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          30.ph,
                          MyButton(
                            gradient: AppGradients.buttonGradient,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                if (!controller.isLoading) {
                                  controller.financeManagerRegisterApi(
                                      firstName:
                                          controller.firstNameController.text,
                                      lastName:
                                          controller.lastNameController.text,
                                      cnic: controller.cnicController.text,
                                      address:
                                          controller.addressController.text,
                                      mobileNo:
                                          controller.mobileNoController.text,
                                      password:
                                          controller.passwordController.text,
                                      societyid: controller.user.societyid!,
                                      subAdminId: controller.user.userid!,
                                      superAdminId:
                                          controller.user.superadminid!,
                                      token: controller.user.bearerToken!,
                                      file: controller.imageFile,
                                      context: context);
                                }
                              }
                            },
                            loading: controller.isLoading,
                            name: 'Save',
                          ),
                          20.ph,
                        ],
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  /////  formate cnic text

  String formatText(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 15) {
      text = text.substring(0, 15);
    }

    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5 || i == 12) {
        formattedText += '-';
      }
      formattedText += text[i];
    }

    return formattedText;
  }
}

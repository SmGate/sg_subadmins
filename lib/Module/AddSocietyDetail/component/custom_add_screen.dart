import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_textform_field.dart';

// ignore: must_be_immutable
class CustomAddScreen extends StatelessWidget {
  CustomAddScreen({
    required this.fKey,
    required this.appBarText,
    required this.backonTap,
    required this.nameController,
    required this.from,
    required this.to,
    required this.fromImg,
    required this.toImg,
    required this.fromController,
    required this.toController,
    required this.buttonLoading,
    required this.buttonOnPressed,
  });
  Key? fKey;
  String appBarText;
  void Function()? backonTap;
  TextEditingController? nameController;
  String from;
  String to;
  String fromImg;
  String toImg;
  TextEditingController? fromController;
  TextEditingController? toController;
  bool buttonLoading = false;
  void Function()? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyBackButton(text: appBarText, onTap: backonTap),
            20.ph,
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  color: AppColors.globalWhite,
                  surfaceTintColor: AppColors.globalWhite,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r)),
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          hintText: 'Name',
                          labelText: 'Name',
                          validator: emptyStringValidator,
                          controller: nameController,
                        ),
                        20.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Color(0xFFF7F8FA),
                              height: 25.h,
                              width: 98.w,
                              child: Center(
                                  child: Text(
                                from,
                                style: TextStyle(color: HexColor('#535353')),
                              )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              color: Color(0xFFF7F8FA),
                              height: 25.h,
                              width: 98.w,
                              child: Center(
                                  child: Text(
                                to,
                                style: TextStyle(color: HexColor('#535353')),
                              )),
                            )
                          ],
                        ),
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 75.w,
                              height: 75.h,
                              color: AppColors.greyTransparent.withOpacity(0.1),
                              child: Center(
                                child: TextFormField(
                                  validator: emptyStringValidator,
                                  controller: fromController,
                                  keyboardType: TextInputType.number,
                                  enabled: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.greyTransparent,
                                      contentPadding:
                                          EdgeInsets.only(left: 16.w),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(), //<-- SEE HERE
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            72.pw,
                            Container(
                              width: 75.w,
                              height: 75.h,
                              color: AppColors.greyTransparent.withOpacity(0.1),
                              // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/textfieldimg.png'))),

                              child: Center(
                                child: TextFormField(
                                  validator: emptyStringValidator,
                                  controller: toController,
                                  keyboardType: TextInputType.number,
                                  enabled: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.greyTransparent,
                                      contentPadding:
                                          EdgeInsets.only(left: 16.w),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(), //<-- SEE HERE
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                        40.ph,
                        Center(
                          child: MyButton(
                            gradient: AppGradients.buttonGradient,
                            loading: buttonLoading,
                            height: 37.h,
                            width: 222.w,
                            border: 5,
                            onPressed: buttonOnPressed,
                            name: 'Save',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

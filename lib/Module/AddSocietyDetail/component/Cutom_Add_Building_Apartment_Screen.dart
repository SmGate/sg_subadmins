import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_text.dart';

// ignore: must_be_immutable
class AddBuildingApartmentCustom extends StatelessWidget {
  AddBuildingApartmentCustom({
    required this.fKey,
    required this.backonTap,
    required this.fromController,
    required this.toController,
    required this.buttonLoading,
    required this.buttonOnPressed,
  });
  Key? fKey;
  void Function()? backonTap;
  TextEditingController? fromController;
  TextEditingController? toController;
  bool buttonLoading = false;
  void Function()? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Form(
          key: fKey,
          child: ListView(
            children: <Widget>[
              MyBackButton(
                onTap: backonTap,
                text: 'Add Apartments',
              ),
              20.ph,
              SizedBox(
                child: Card(
                  color: AppColors.globalWhite,
                  surfaceTintColor: AppColors.globalWhite,
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: [
                        20.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(name: 'From'),
                                10.ph,
                                SizedBox(
                                  width: 70.w,
                                  child: TextFormField(
                                    validator: emptyStringValidator,
                                    controller: fromController,
                                    keyboardType: TextInputType.number,
                                    enabled: true,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.greyTransparent,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide:
                                              BorderSide(), //<-- SEE HERE
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(name: 'To '),
                                10.ph,
                                SizedBox(
                                  width: 70.w,
                                  child: TextFormField(
                                    validator: emptyStringValidator,
                                    controller: toController,
                                    keyboardType: TextInputType.number,
                                    enabled: true,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.greyTransparent,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide:
                                              BorderSide(), //<-- SEE HERE
                                        ),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        40.ph,
                        MyButton(
                          gradient: AppGradients.buttonGradient,
                          loading: buttonLoading,
                          onPressed: buttonOnPressed,
                          name: 'Save',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';
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
    this.buttonOnPressed,
    this.floorCategory,
    this.onSubmit,
  });
  Key? fKey;
  void Function()? backonTap;
  TextEditingController? fromController;
  TextEditingController? toController;
  bool buttonLoading = false;
  void Function()? buttonOnPressed;
  final String? floorCategory;
  final void Function(
      {String? name,
      required String from,
      required String to,
      required int typeId,
      required String type})? onSubmit;

  // Local reactive state to toggle custom entry
  final RxBool isCustomUnit = false.obs;
  final TextEditingController _customUnitController = TextEditingController();

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
                text: SessionController().selectedFloorType == 'Corporate'
                    ? 'Add Offices'
                    : SessionController().selectedFloorType == 'Commercial'
                        ? 'Add Shops'
                        : 'Add Apartments',
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
                        // From-To inputs (hidden when custom selected)
                        Obx(() => Visibility(
                              visible: !isCustomUnit.value,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          name: SessionController()
                                                      .selectedFloorType ==
                                                  'Corporate'
                                              ? 'From (Office #)'
                                              : SessionController()
                                                          .selectedFloorType ==
                                                      'Commercial'
                                                  ? 'From (Shop #)'
                                                  : 'From'),
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
                                              fillColor:
                                                  AppColors.greyTransparent,
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(),
                                              ),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          name: SessionController()
                                                      .selectedFloorType ==
                                                  'Corporate'
                                              ? 'To (Office #)'
                                              : SessionController()
                                                          .selectedFloorType ==
                                                      'Commercial'
                                                  ? 'To (Shop #)'
                                                  : 'To '),
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
                                              fillColor:
                                                  AppColors.greyTransparent,
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(),
                                              ),
                                              border: InputBorder.none),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),

                        // Checkbox to toggle custom entry
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: Obx(() => Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.appThem,
                                    value: isCustomUnit.value,
                                    onChanged: (v) {
                                      isCustomUnit.value = v ?? false;
                                    },
                                  ),
                                  Text(
                                    SessionController().selectedFloorType ==
                                            'Corporate'
                                        ? 'Add Custom Office'
                                        : SessionController()
                                                    .selectedFloorType ==
                                                'Commercial'
                                            ? 'Add Custom Shop'
                                            : 'Add Custom Apartment',
                                  ),
                                ],
                              )),
                        ),

                        // Custom single text field (visible when custom selected)
                        Obx(() => Visibility(
                              visible: isCustomUnit.value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    8.ph,
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        validator: emptyStringValidator,
                                        controller: _customUnitController,
                                        keyboardType: TextInputType.text,
                                        enabled: true,
                                        decoration: InputDecoration(
                                          hintText: SessionController()
                                                      .selectedFloorType ==
                                                  'Corporate'
                                              ? 'Enter Office Name/No'
                                              : SessionController()
                                                          .selectedFloorType ==
                                                      'Commercial'
                                                  ? 'Enter Shop Name/No'
                                                  : 'Enter Apartment Name/No',
                                          filled: true,
                                          fillColor: AppColors.greyTransparent,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: BorderSide(),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        40.ph,
                        MyButton(
                          gradient: AppGradients.buttonGradient,
                          loading: buttonLoading,
                          onPressed: () {
                            final String type =
                                SessionController().selectedFloorType;
                            final int typeId = type == 'Corporate'
                                ? 2
                                : type == 'Commercial'
                                    ? 3
                                    : 1;

                            if (isCustomUnit.value) {
                              final String name =
                                  _customUnitController.text.trim();
                              if (name.isEmpty) {
                                Get.snackbar(
                                    'Validation', 'Please enter a name');
                                return;
                              }
                              if (onSubmit != null) {
                                onSubmit!(
                                    name: name,
                                    from: '',
                                    to: '',
                                    typeId: typeId,
                                    type: type);
                                return;
                              }
                            } else {
                              final String from =
                                  fromController?.text.trim() ?? '';
                              final String to = toController?.text.trim() ?? '';
                              if (from.isEmpty || to.isEmpty) {
                                Get.snackbar(
                                    'Validation', 'Please fill From and To');
                                return;
                              }
                              if (onSubmit != null) {
                                onSubmit!(
                                    name: null,
                                    from: from,
                                    to: to,
                                    typeId: typeId,
                                    type: type);
                                return;
                              }
                            }

                            // Fallback to old handler if provided
                            if (buttonOnPressed != null) buttonOnPressed!();
                          },
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

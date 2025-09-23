// // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// removed: google_fonts, shimmer (unused after dropdown removal)
import 'package:societyadminapp/Module/Measurements/Widget/Custom_TextField.dart';
import 'package:societyadminapp/Module/ShortTermRental/model/get_society_buildings_model.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Widgets/my_button.dart';
import '../../../Widgets/my_text.dart';

class AddBuildingFloorCustom extends StatelessWidget {
  AddBuildingFloorCustom({
    required this.fKey,
    required this.backonTap,
    required this.fromController,
    required this.toController,
    required this.buttonLoading,
    required this.buttonOnPressed,
    required this.floorTypes,
    required this.selectedFloorType,
    required this.onFloorTypeChanged,
    required this.buildings,
    required this.selectedBuildingId,
    required this.onBuildingChanged,
    required this.customFloorsController,
    required this.loadingBuildings,
  });

  Key? fKey;
  void Function()? backonTap;
  TextEditingController? fromController;
  TextEditingController? toController;
  RxBool buttonLoading = false.obs;
  void Function()? buttonOnPressed;

  final List<String> floorTypes;
  final RxString selectedFloorType;
  final void Function(String?) onFloorTypeChanged;

  // Building selection removed - using previously selected building id from session
  final List<SocietyBuilding> buildings;
  final RxInt selectedBuildingId;
  final void Function(int?) onBuildingChanged;

  final TextEditingController customFloorsController;
  final RxBool loadingBuildings;

  final isCustomFloor = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Form(
          key: fKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyBackButton(
                  onTap: backonTap,
                  text: 'Add Floors',
                ),
                20.ph,
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    child: Card(
                      color: AppColors.globalWhite,
                      surfaceTintColor: AppColors.globalWhite,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.ph,

                            // Building dropdown removed: using stored selected building id

                            /// Floor Type Dropdown
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Obx(
                                  () => DropdownButtonFormField<String>(
                                    value: selectedFloorType.value.isNotEmpty
                                        ? selectedFloorType.value
                                        : null,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 14),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    hint: Text(
                                      'Floor Type',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    onChanged: onFloorTypeChanged,
                                    items: floorTypes.map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                            /// From - To Fields
                            Obx(() => Visibility(
                                  visible: !isCustomFloor.value,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(name: 'From'),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            width: 70.w,
                                            child: TextFormField(
                                              validator: emptyStringValidator,
                                              controller: fromController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:
                                                    AppColors.greyTransparent,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: BorderSide(
                                                      color: AppColors.appThem),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(name: 'To'),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            width: 70.w,
                                            child: TextFormField(
                                              validator: emptyStringValidator,
                                              controller: toController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:
                                                    AppColors.greyTransparent,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: BorderSide(),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),

                            /// Checkbox
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Obx(() => Row(
                                    children: [
                                      Checkbox(
                                        activeColor: AppColors.appThem,
                                        value: isCustomFloor.value,
                                        onChanged: (value) {
                                          isCustomFloor.value = value!;
                                        },
                                      ),
                                      Text(
                                        'Add Custom Floor',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  )),
                            ),

                            /// Custom Floor Field
                            Obx(() => Visibility(
                                  visible: isCustomFloor.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        16.ph,
                                        CustomTextField(
                                          controller: customFloorsController,
                                          hintText: 'Enter Custom Floor',
                                          textInputType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),

                            40.ph,
                            Center(
                              child: Obx(() => MyButton(
                                    gradient: AppGradients.buttonGradient,
                                    loading: buttonLoading.value,
                                    onPressed: buttonOnPressed,
                                    name: 'Save',
                                  )),
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
        ),
      ),
    );
  }
}

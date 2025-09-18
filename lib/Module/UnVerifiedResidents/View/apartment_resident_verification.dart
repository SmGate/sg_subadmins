// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/Measurements/Widget/Custom_TextField.dart';
import 'package:societyadminapp/Module/parking%20managment/model/get_area_slots_model.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_drop_down.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_button.dart';
import '../Controller/apartment_resident_verification_controller.dart';
import '../Model/Resident Model/ApartmentResidentModel.dart';

class ApartmentResidentVerification extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<ApartmentResidentVerificationController>(
          init: ApartmentResidentVerificationController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async {
                Get.offNamed(unverifiedresident,
                    arguments: controller.userdata);
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyBackButton(
                      text: 'Apartment Verification',
                      onTap: () {
                        Get.offNamed(unverifiedresident,
                            arguments: controller.userdata);
                      },
                    ),
                    20.ph,

                    /// Resident Info Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      Api.imageBaseUrl +
                                          controller.resident.image.toString(),
                                      width: 70.w,
                                      height: 70.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  16.pw,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.resident.firstname} ${controller.resident.lastname}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        6.ph,
                                        Text(
                                            "Mobile: ${controller.resident.mobileno}"),
                                        Text(
                                            "Resident Type: ${controller.resident.residenttype}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            32.ph,

                            /// Dropdown Fields
                            _buildDropdownSection(
                              title: "Select Building*",
                              child: DropdownSearch<Building>(
                                  validator: (value) =>
                                      value == null ? 'Required' : null,
                                  asyncItems: (filter) =>
                                      controller.viewAllBuildingApi(
                                        bearerToken:
                                            controller.userdata.bearerToken!,
                                        subAdminId: controller.userdata.userid,
                                      ),
                                  onChanged: controller.SelectedBuilding,
                                  selectedItem: controller.building,
                                  itemAsString: (item) =>
                                      item.societybuildingname ?? '',
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        hintText: 'Search',
                                        hintStyle:
                                            TextStyle(color: AppColors.appThem),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    loadingBuilder: (context, searchEntry) =>
                                        Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ),
                                    ),
                                  )),
                            ),

                            _buildDropdownSection(
                              title: "Select Floor*",
                              child: DropdownSearch<Floor>(
                                  validator: (value) =>
                                      value == null ? 'Required' : null,
                                  asyncItems: (filter) =>
                                      controller.viewAllFloorApi(
                                        bearerToken:
                                            controller.userdata.bearerToken!,
                                        buildingid: controller.building?.id,
                                      ),
                                  onChanged: controller.SelectedFloor,
                                  selectedItem: controller.floor,
                                  itemAsString: (item) => item.name ?? '',
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        hintText: 'Search',
                                        hintStyle:
                                            TextStyle(color: AppColors.appThem),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    loadingBuilder: (context, searchEntry) =>
                                        Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ),
                                    ),
                                  )),
                            ),

                            _buildDropdownSection(
                              title: "Select Apartment*",
                              child: DropdownSearch<Apartment>(
                                  validator: (value) =>
                                      value == null ? 'Required' : null,
                                  asyncItems: (filter) =>
                                      controller.viewAllApartmentApi(
                                        bearerToken:
                                            controller.userdata.bearerToken!,
                                        floorid: controller.floor?.id,
                                      ),
                                  onChanged: (apartment) {
                                    controller.SelectedApartment(apartment);
                                    controller
                                            .houseaddressdetailController.text =
                                        "${controller.resident.society?.first.name ?? ''} ${controller.building?.societybuildingname ?? ''} ${controller.floor?.name ?? ''} ${apartment?.name ?? ''}";
                                  },
                                  selectedItem: controller.apartment,
                                  itemAsString: (item) => item.name ?? '',
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        hintText: 'Search',
                                        hintStyle:
                                            TextStyle(color: AppColors.appThem),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.appThem,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    loadingBuilder: (context, searchEntry) =>
                                        Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ),
                                    ),
                                  )),
                            ),

                            // _buildDropdownSection(
                            //   title: "Select Area Type*",
                            //   child: DropdownSearch<Measurement>(
                            //     validator: (value) =>
                            //         value == null ? 'Required' : null,
                            //     asyncItems: (filter) =>
                            //         controller.housesApartmentsModelApi(
                            //       subadminid: controller.userdata.userid!,
                            //       token: controller.userdata.bearerToken!,
                            //       type: 'apartment',
                            //     ),
                            //     onChanged: controller.SelectedHousesApartments,
                            //     selectedItem: controller.measurementModel,
                            //     itemAsString: (item) =>
                            //         "${item.area ?? ''} ${item.unit ?? ''}",
                            //   ),
                            // ),

                            (controller.measurementModel != null)
                                ? Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Apartment Details',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        12.ph,
                                        ..._buildNonEmptyRows(controller),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Text(
                                      'No apartment details available.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),

                            10.ph,
                            SpanText(text: 'Rent Start Date'),
                            8.ph,
                            InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  controller.rentStartDate.value = picked;
                                  controller.isRentStartDateValid.value =
                                      true; // reset error
                                }
                              },
                              child: Obx(() => Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h, horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller
                                                .isRentStartDateValid.value
                                            ? AppColors.appThem
                                            : Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.transparent,
                                    ),
                                    child: Text(
                                      controller.rentStartDate.value == null
                                          ? 'Select Date'
                                          : controller.formatDate(
                                              controller.rentStartDate.value!),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            ),

                            10.ph,
                            SpanText(text: 'Apartment Rent'),
                            8.ph,
                            CustomTextField(
                              controller: controller.apartmentRentController,
                              hasValidator: true,
                              hintText: "Apartment Rent",
                              textInputType: TextInputType.number,
                            ),

                            10.ph,
                            SpanText(text: 'Service Charges'),
                            8.ph,
                            CustomTextField(
                              controller: controller.serviceChargesController,
                              hintText: "Service charges",
                              hasValidator: true,
                              textInputType: TextInputType.number,
                            ),

                            10.ph,
                            SpanText(text: 'Water Charges'),
                            8.ph,
                            CustomTextField(
                              controller: controller.waterChargesController,
                              hintText: "Water charges",
                              textInputType: TextInputType.number,
                              hasValidator: true,
                            ),

                            10.ph,
                            SpanText(
                              text: 'Security Amount',
                              hasValidator: false,
                            ),
                            8.ph,
                            CustomTextField(
                              controller: controller.securityAMountController,
                              hintText: "Security Amount",
                              textInputType: TextInputType.number,
                              hasValidator: false,
                            ),

                            10.ph,
                            SpanText(
                              text: 'Rent Increment Date',
                              hasValidator: false,
                            ),
                            8.ph,
                            InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  controller.incrementDate.value = picked;
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 14.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.appThem),
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.transparent,
                                ),
                                child: Obx(() => Text(
                                      controller.incrementDate.value == null
                                          ? 'Select Date'
                                          : controller.formatDate(
                                              controller.incrementDate.value!),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                            ),

                            10.ph,
                            SpanText(
                              text: 'Increament Percentage %',
                              hasValidator: false,
                            ),
                            8.ph,
                            CustomTextField(
                              controller:
                                  controller.increamentPercentController,
                              hintText: "Increament Percentage",
                              hasValidator: false,
                              textInputType: TextInputType.number,
                            ),

                            10.ph,
                            SpanText(
                              text: 'Vehicle No',
                              hasValidator: false,
                            ),
                            8.ph,
                            CustomTextField(
                              controller: controller.vehiclenoController,
                              hintText: "Vehicle No",
                              hasValidator: false,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Owner Details',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomTextField(
                                  controller: controller.ownerNameController,
                                  hintText: "Owner Name",
                                  hasValidator: true,
                                ),
                                20.ph,
                                CustomTextField(
                                  textInputType: TextInputType.number,
                                  controller: controller.ownerPhoneCOntroller,
                                  hintText: "Owner Phone",
                                  hasValidator: true,
                                ),
                              ],
                            ),

                            20.ph,
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                      value: controller
                                          .showIncrementContainer.value,
                                      onChanged: (val) {
                                        controller.showIncrementContainer
                                            .value = val ?? false;
                                      },
                                    )),
                                Text(
                                  "Parking",
                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                ),
                              ],
                            ),

                            Obx(() {
                              if (!controller.showIncrementContainer.value)
                                return SizedBox.shrink();
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.w),
                                margin: EdgeInsets.only(top: 12.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Select Parking Area'),
                                          8.ph,
                                          DropdownSearch<String>(
                                            validator: (value) => value == null
                                                ? 'Required'
                                                : null,
                                            asyncItems: (String filter) async {
                                              final res = await controller
                                                  .getParkingSlots(
                                                societyId: controller
                                                    .userdata.societyid
                                                    .toString(),
                                              );
                                              return res.data?.areas ?? [];
                                            },
                                            onChanged: (String? area) async {
                                              controller.selectedParkingArea
                                                  .value = area!;
                                              await controller.getParkingSlots(
                                                societyId: controller
                                                    .userdata.societyid
                                                    .toString(),
                                                area: area,
                                              );
                                            },
                                            selectedItem: controller
                                                .selectedParkingArea.value,
                                            itemAsString: (String p) => p,
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 12),
                                                hintText: 'Search',
                                                hintStyle: TextStyle(
                                                    color: AppColors.appThem),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.appThem),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.appThem,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 12),
                                                  hintText: 'Search',
                                                  hintStyle: TextStyle(
                                                      color: AppColors.appThem),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.appThem),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.appThem,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              loadingBuilder:
                                                  (context, searchEntry) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.appThem,
                                                ),
                                              ),
                                            ),
                                          ),
                                          20.ph,
                                          Text('Select Parking Slot'),
                                          8.ph,
                                          DropdownSearch<Slot>(
                                            validator: (value) => value == null
                                                ? 'Required'
                                                : null,
                                            asyncItems: (String filter) async {
                                              final res = await controller
                                                  .getParkingSlots(
                                                societyId: controller
                                                    .userdata.societyid
                                                    .toString(),
                                                area: controller
                                                    .selectedParkingArea.value,
                                              );

                                              final allSlots =
                                                  res.data?.slots ?? [];
                                              final availableSlots = allSlots
                                                  .where((slot) =>
                                                      slot.status
                                                          ?.toLowerCase() ==
                                                      'available')
                                                  .toList();

                                              return availableSlots;
                                            },
                                            onChanged: (Slot? slot) {
                                              controller.selectedParkingSlot
                                                  .value = slot!;
                                            },
                                            selectedItem: controller
                                                .selectedParkingSlot.value,
                                            itemAsString: (Slot slot) =>
                                                slot.slotNumber ?? 'Unknown',
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 12),
                                                hintText: 'Search',
                                                hintStyle: TextStyle(
                                                    color: AppColors.appThem),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.appThem),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.appThem,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 12),
                                                  hintText: 'Search',
                                                  hintStyle: TextStyle(
                                                      color: AppColors.appThem),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.appThem),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.appThem,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              loadingBuilder:
                                                  (context, searchEntry) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color:
                                                            AppColors.appThem),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.ph,
                                    SpanText(text: 'Parking Rate'),
                                    8.ph,
                                    CustomTextField(
                                      controller:
                                          controller.parkingRateController,
                                      hintText: "Parking Rate",
                                      hasValidator: controller
                                                  .showIncrementContainer
                                                  .value ==
                                              true
                                          ? true
                                          : false,
                                      textInputType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              );
                            }),

                            32.ph,

                            /// Verify Button
                            Center(
                              child: MyButton(
                                gradient: AppGradients.buttonGradient,
                                loading: controller.loading,
                                onPressed: () {
                                  bool isFormValid = controller
                                      .formKey.currentState!
                                      .validate();

                                  // Check rent start date selection
                                  controller.isRentStartDateValid.value =
                                      controller.rentStartDate.value != null;
                                  if (isFormValid &&
                                      controller.isRentStartDateValid.value) {
                                    if (!controller.loading) {
                                      controller.verifyApartmentResidentApi(
                                          residentid: controller.resident.residentid ??
                                              0,
                                          status: 1,
                                          buildingid:
                                              controller.building?.id ?? 0,
                                          societybuildingfloorid:
                                              controller.floor?.id ?? 0,
                                          societybuildingapartmentid:
                                              controller.apartment?.id ?? 0,
                                          measurementid:
                                              controller.measurementModel?.id ??
                                                  0,
                                          vechileno: controller
                                              .vehiclenoController.text,
                                          houseaddress: controller
                                              .houseaddressdetailController
                                              .text,
                                          monthly_rent: double.tryParse(controller
                                              .apartmentRentController.text),
                                          service_charge: double.tryParse(
                                              controller.serviceChargesController.text),
                                          water_charge: double.tryParse(controller.waterChargesController.text),
                                          rent_start_date: controller.formatDate(controller.rentStartDate.value!),
                                          increment_date: controller.formatDate(controller.incrementDate.value!),
                                          increment_percentage: double.tryParse(controller.increamentPercentController.text),
                                          security_amount: double.tryParse(controller.securityAMountController.text),
                                          parking: controller.showIncrementContainer.value,
                                          parking_rate: double.tryParse(controller.parkingRateController.text),
                                          parking_slot: controller.selectedParkingSlot.value?.id ?? 0,
                                          token: controller.userdata.bearerToken ?? "",
                                          ownerName: controller.ownerNameController.text,
                                          ownerPhone: controller.ownerPhoneCOntroller.text);
                                    }
                                  }
                                },
                                name: 'Verify',
                                width: double.infinity,
                                height: 52.h,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    40.ph,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildNonEmptyRows(
      ApartmentResidentVerificationController controller) {
    final m = controller.measurementModel!;
    final rows = <Widget>[];

    void addRow(String title, String? value) {
      if (value != null && value.trim().isNotEmpty) {
        rows.add(_buildMeasurementRow(title, value));
      }
    }

    addRow('Area', "${m.area ?? ''} ${m.unit ?? ''}".trim());
    addRow('Category', m.category);
    addRow('Type', m.type);
    addRow('Apartment Type', m.appartmentType);

    addRow('Late Charges', m.chargesafterduedate);
    addRow('Tax', m.tax);
    addRow('Bedrooms', m.bedrooms?.toString());

    return rows;
  }

  Widget _buildDropdownSection({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          8.ph,
          child,
        ],
      ),
    );
  }

  Widget _buildMeasurementRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

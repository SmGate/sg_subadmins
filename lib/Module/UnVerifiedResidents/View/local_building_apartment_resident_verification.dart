// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_button.dart';
import '../Controller/local_building_apartment_resident_verification_controller.dart';
import '../Model/Resident Model/LocalBuildingApartmentResidentModel.dart';
import '../Widget/custom_text.dart';
import '../Widget/first_custom_container.dart';

class LocalBuildingApartmentResidentVerification extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LocalBuildingApartmentResidentVerificationController>(
            init: LocalBuildingApartmentResidentVerificationController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(unverifiedresident,
                      arguments: controller.userdata);
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyBackButton(
                        text: 'Apartment Verification',
                        onTap: () {
                          Get.offNamed(unverifiedresident,
                              arguments: controller.userdata);
                        },
                      ),
                      16.ph,
                      //VERIFICATION DETAIL FIRST CARD
                      FirstCustomContainer(
                          ImageBaseUrl: Api.imageBaseUrl +
                              controller.resident.image.toString(),
                          Name: controller.resident.firstname.toString() +
                              " " +
                              controller.resident.lastname.toString(),
                          MobileNo: controller.resident.mobileno.toString(),
                          Cnic: controller.resident.cnic.toString(),
                          VehicleNo: controller.resident.vechileno.toString(),
                          ResidentalType:
                              controller.resident.residenttype.toString(),
                          Status: controller.resident.status.toString()),

                      20.ph,
                      Padding(
                        padding: EdgeInsets.only(left: 22.w, right: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomUnverifiedText(text: "Select Building*"),
                            8.ph,
                            DropdownSearch<Localbuilding>(
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              asyncItems: (String filter) async {
                                print(filter);
                                return controller.viewAllBuildingApi(
                                  bearerToken: controller.userdata.bearerToken!,
                                  type: 'building',
                                );
                              },
                              onChanged: (Localbuilding? data) {
                                controller.SelectedBuilding(data);
                              },
                              selectedItem: controller.localbuilding,
                              itemAsString: (Localbuilding p) {
                                return p.name.toString();
                              },
                            ),
                            16.ph,
                            CustomUnverifiedText(
                              text: "Select Floor*",
                            ),
                            8.ph,
                            DropdownSearch<Localbuildingfloor>(
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              asyncItems: (String filter) async {
                                print(filter);
                                return controller.viewAllFloorApi(
                                    bearerToken:
                                        controller.userdata.bearerToken!,
                                    buildingid: controller.localbuilding?.id);
                              },
                              onChanged: (Localbuildingfloor? data) {
                                controller.SelectedFloor(data);
                              },
                              selectedItem: controller.floor,
                              itemAsString: (Localbuildingfloor p) {
                                return p.name.toString();
                              },
                            ),
                            16.ph,
                            CustomUnverifiedText(text: "Select Apartment"),
                            8.ph,
                            DropdownSearch<Localbuildingapartment>(
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              asyncItems: (String filter) async {
                                print(filter);
                                return controller.viewAllApartmentApi(
                                    bearerToken:
                                        controller.userdata.bearerToken!,
                                    floorid: controller.floor?.id);
                              },
                              onChanged: (Localbuildingapartment? apartment) {
                                controller.SelectedApartment(apartment);
                                controller.houseaddressdetailController.text =
                                    "${controller.localbuilding!.name.toString()}${','} ${controller.floor!.name.toString()}${','}${apartment!.name.toString()}";
                              },
                              selectedItem: controller.apartment,
                              itemAsString: (Localbuildingapartment p) {
                                return p.name.toString();
                              },
                            ),
                            16.ph,
                            CustomUnverifiedText(
                              text: "Select Area Type*",
                            ),
                            8.ph,
                            DropdownSearch<Measurement>(
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              asyncItems: (String filter) async {
                                print(filter);
                                return controller.housesApartmentsModelApi(
                                    subadminid: controller.userdata.userid!,
                                    token: controller.userdata.bearerToken!,
                                    type: 'apartment');
                              },
                              onChanged: (Measurement? data) {
                                controller.SelectedHousesApartments(data);
                              },
                              selectedItem: controller.measurementModel,
                              itemAsString: (Measurement p) {
                                return p.area.toString() +
                                    ' ' +
                                    p.unit.toString();
                              },
                            ),
                            20.ph,
                            Text(
                              controller.houseaddressdetailController.text,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: AppColors.appThem,
                                fontSize: 14.font,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            20.ph,
                            Center(
                              child: MyButton(
                                gradient: AppGradients.buttonGradient,
                                onPressed: () {
                                  if (!controller.loading) {
                                    controller.verifyApartmentResidentApi(
                                        residentid:
                                            controller.resident.residentid,
                                        status: 1,
                                        token: controller.userdata.bearerToken!,
                                        measurementid:
                                            controller.measurementModel!.id,
                                        localbuildingid:
                                            controller.localbuilding!.id!,
                                        localbuildingfloorid:
                                            controller.floor!.id!,
                                        localbuildingapartmentid:
                                            controller.apartment!.id!,
                                        vechileno:
                                            controller.vehiclenoController.text,
                                        houseaddress: controller
                                            .houseaddressdetailController.text);
                                  }
                                },
                                name: 'Verify',
                                loading: controller.loading,
                                width: 328.w,
                                height: 52.h,
                                fontSize: 20.font,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            20.ph,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

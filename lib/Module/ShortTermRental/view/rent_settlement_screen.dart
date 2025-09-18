// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/Module/ShortTermRental/controller/short_term_rental_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class RentSettleMentScreen extends StatefulWidget {
  const RentSettleMentScreen({super.key});

  @override
  State<RentSettleMentScreen> createState() => _RentSettleMentScreenState();
}

class _RentSettleMentScreenState extends State<RentSettleMentScreen> {
  var shortTermRentalController = Get.find<ShortTermRentalController>();
  DateTime? checkInDate;
  DateTime? checkOutDate;

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickDate({required bool isCheckIn}) async {
    DateTime initialDate = isCheckIn
        ? DateTime.now()
        : (checkInDate?.add(Duration(days: 1)) ??
            DateTime.now().add(Duration(days: 1)));
    DateTime firstDate = isCheckIn
        ? DateTime.now()
        : (checkInDate?.add(Duration(days: 1)) ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          if (checkOutDate != null && checkOutDate!.isBefore(checkInDate!)) {
            checkOutDate = null; // Reset checkout if it’s now invalid
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // You can prompt for Camera or Gallery
    );
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offNamed(allShortTermRental,
              arguments: shortTermRentalController.userdata);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Form(
              key: shortTermRentalController.formKey,
              child: Column(
                children: [
                  MyBackButton(
                    text: 'Rent Settlement',
                    onTap: () {
                      Get.offNamed(allShortTermRental,
                          arguments: shortTermRentalController.userdata);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Building Dropdown
                        // ==========================
                        // Building Dropdown
                        // ==========================
                        buildTextLabel('Select Building'),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          if (shortTermRentalController
                              .loadingBuildings.value) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: AppColors.appThem,
                            ));
                          }
                          return DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: AppColors.appThem),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    color: AppColors.appThem, width: 2),
                              ),
                            ),
                            value: shortTermRentalController
                                        .selectedBuildingId.value ==
                                    0
                                ? null
                                : shortTermRentalController
                                    .selectedBuildingId.value,
                            hint: Text(
                              'Select Building',
                              style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            items: shortTermRentalController.societyBuildings
                                .map((building) {
                              return DropdownMenuItem<int>(
                                value: building.id,
                                child: Text(
                                  building.societybuildingname ?? 'No Name',
                                  style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              shortTermRentalController
                                  .selectedBuildingId.value = value!;
                              shortTermRentalController.selectedFloorId.value =
                                  0; // Reset floor
                              shortTermRentalController.selectedApartmentId
                                  .value = 0; // Reset apartment
                              shortTermRentalController.fetchFloors(value);
                            },
                          );
                        }),

                        SizedBox(height: 20),

                        // ==========================
                        // Floor Dropdown
                        // ==========================
                        Obx(() {
                          if (shortTermRentalController
                                      .selectedBuildingId.value !=
                                  0 &&
                              shortTermRentalController
                                  .buildingFloors.isEmpty &&
                              !shortTermRentalController.loadingFloors.value) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                  'No floors available for this building.',
                                  style: TextStyle(color: Colors.red)),
                            );
                          }

                          return Visibility(
                            visible: shortTermRentalController
                                        .selectedBuildingId.value !=
                                    0 &&
                                shortTermRentalController
                                    .buildingFloors.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextLabel('Select Floor'),
                                SizedBox(
                                  height: 10,
                                ),
                                shortTermRentalController.loadingFloors.value
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ))
                                    : DropdownButtonFormField<int>(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                                color: AppColors.appThem),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                                color: AppColors.appThem,
                                                width: 2),
                                          ),
                                        ),
                                        value: shortTermRentalController
                                                    .selectedFloorId.value ==
                                                0
                                            ? null
                                            : shortTermRentalController
                                                .selectedFloorId.value,
                                        hint: Text(
                                          'Select Floor',
                                          style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        items: shortTermRentalController
                                            .buildingFloors
                                            .map((floor) {
                                          return DropdownMenuItem<int>(
                                            value: floor.id,
                                            child: Text(
                                              floor.name ?? 'No Name',
                                              style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          shortTermRentalController
                                              .selectedFloorId.value = value!;
                                          shortTermRentalController
                                              .selectedApartmentId
                                              .value = 0; // Reset apartment
                                          shortTermRentalController
                                              .fetchApartments(value);
                                        },
                                      ),
                              ],
                            ),
                          );
                        }),

                        SizedBox(height: 20),

                        // ==========================
                        // Apartment Dropdown
                        // ==========================
                        Obx(() {
                          if (shortTermRentalController
                                      .selectedFloorId.value !=
                                  0 &&
                              shortTermRentalController
                                  .buildingApartments.isEmpty &&
                              !shortTermRentalController
                                  .loadingApartments.value) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                  'No apartments available for this floor.',
                                  style: TextStyle(color: Colors.red)),
                            );
                          }

                          return Visibility(
                            visible: shortTermRentalController
                                        .selectedFloorId.value !=
                                    0 &&
                                shortTermRentalController
                                    .buildingApartments.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextLabel('Select Apartment'),
                                SizedBox(
                                  height: 10,
                                ),
                                shortTermRentalController
                                        .loadingApartments.value
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.appThem,
                                      ))
                                    : DropdownButtonFormField<int>(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                                color: AppColors.appThem),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                                color: AppColors.appThem,
                                                width: 2),
                                          ),
                                        ),
                                        value: shortTermRentalController
                                                    .selectedApartmentId
                                                    .value ==
                                                0
                                            ? null
                                            : shortTermRentalController
                                                .selectedApartmentId.value,
                                        hint: Text(
                                          'Select Apartment',
                                          style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        items: shortTermRentalController
                                            .buildingApartments
                                            .map((apartment) {
                                          return DropdownMenuItem<int>(
                                            value: apartment.id,
                                            child: Text(
                                              apartment.name ?? 'No Name',
                                              style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          shortTermRentalController
                                              .selectedApartmentId
                                              .value = value!;
                                        },
                                      ),
                              ],
                            ),
                          );
                        }),

                        SizedBox(height: 20),
                        buildTextLabel('Montlhy Rent'),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                          validator: emptyStringValidator,
                          textInputType: TextInputType.number,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 0, right: 0),
                          controller:
                              shortTermRentalController.monthlyRentController,
                          labelText: 'Montlhy Rent',
                          hintText: 'Montlhy Rent',
                        ),

                        SizedBox(height: 20),
                        buildTextLabel('Annual Increament %'),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                          validator: emptyStringValidator,
                          textInputType: TextInputType.number,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 0, right: 0),
                          controller: shortTermRentalController
                              .annualIncreamentController,
                          labelText: 'Annual Increament',
                          hintText: 'Annual Increament',
                        ),
                        SizedBox(height: 20),
                        buildTextLabel('Check-in Date'),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => pickDate(isCheckIn: true),
                          child:
                              buildDateBox(checkInDate, 'Select Check-in Date'),
                        ),
                        SizedBox(height: 10),

                        SizedBox(height: 20),

                        Center(
                          child: Obx(() => MyButton(
                                loading: shortTermRentalController
                                    .addRentSettleMentLoading.value,
                                name: "Save",
                                gradient: AppGradients.buttonGradient,
                                border: 6,
                                width: double.infinity,
                                onPressed: () {
                                  if (shortTermRentalController
                                          .selectedBuildingId.value ==
                                      0) {
                                    Get.snackbar(
                                        'Error', 'Please select a building.');
                                    return;
                                  }

                                  if (shortTermRentalController
                                          .selectedFloorId.value ==
                                      0) {
                                    Get.snackbar(
                                        'Error', 'Please select a floor.');
                                    return;
                                  }

                                  if (shortTermRentalController
                                          .selectedApartmentId.value ==
                                      0) {
                                    Get.snackbar(
                                        'Error', 'Please select an apartment.');
                                    return;
                                  }

                                  if (checkInDate == null) {
                                    Get.snackbar('Error',
                                        'Please select a check-in date.');
                                    return;
                                  }

                                  if (shortTermRentalController
                                      .formKey.currentState!
                                      .validate()) {
                                    shortTermRentalController.rentSettleMent(
                                      apartmentId: shortTermRentalController
                                          .selectedApartmentId.value
                                          .toString(),
                                      residentId: shortTermRentalController
                                          .userdata.userid
                                          .toString(),
                                      startDate: "${checkInDate!.toLocal()}"
                                          .split(' ')[0],
                                      monthlyRent: shortTermRentalController
                                          .monthlyRentController.text,
                                      anualIncrement: shortTermRentalController
                                          .annualIncreamentController.text,
                                    );
                                  }
                                  ;
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  Widget buildDateBox(DateTime? date, String placeholder) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appThem),
        borderRadius: BorderRadius.circular(6),
        color: HexColor('#EEEEEE'),
      ),
      child: Text(
        date != null ? "${date.toLocal()}".split(' ')[0] : placeholder,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: HexColor("#555555"),
        ),
      ),
    );
  }
}

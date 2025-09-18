// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Module/domestic_help/model/get_all_domestic_helper_model.dart';
import 'package:societyadminapp/Module/domestic_help/view/helper_profile.dart';
import 'package:societyadminapp/Module/domestic_help/view/update_domestic_helper.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/My_Floating_Button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class AllWorkers extends StatefulWidget {
  AllWorkers({super.key});

  @override
  State<AllWorkers> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkers> {
  String? selectedOccupation;

  @override
  Widget build(BuildContext context) {
    final domesticHelpController = Get.put(DomesticHelpCOntroller());
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: MyFloatingButton(
        onPressed: () {
          Get.offAndToNamed(domesticHelp,
              arguments: domesticHelpController.userdata);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<GetAllDomesticHelperModel?>(
              future: domesticHelpController.getAllDomesticHelper(
                  societyId: domesticHelpController.userdata.societyid,
                  occupation: selectedOccupation),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appThem,
                    ),
                  );
                }

                if (snapshot.hasError || snapshot.data?.data?.workers == null) {
                  return Center(
                    child: Text(
                      "Error: ${domesticHelpController.getAllDomesticHelperError}",
                    ),
                  );
                }

                final allHelpers = snapshot.data?.data?.workers ?? [];
                final occupations = snapshot.data?.data?.occupations ?? [];

                final helpers =
                    (selectedOccupation == null || selectedOccupation == '')
                        ? allHelpers
                        : allHelpers
                            .where((w) =>
                                w.occupation?.toLowerCase() ==
                                selectedOccupation!.toLowerCase())
                            .toList();

                return Column(
                  children: [
                    // Occupation Dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            hint: const Text("Select Service Type"),
                            value: selectedOccupation == ''
                                ? ''
                                : selectedOccupation,
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                selectedOccupation =
                                    value == 'All' ? '' : value;
                              });
                            },
                            items: [
                              const DropdownMenuItem<String>(
                                value: '',
                                child: Text('All'),
                              ),
                              ...occupations.map(
                                (occupation) => DropdownMenuItem<String>(
                                  value: occupation,
                                  child: Text(occupation),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Filtered List
                    Expanded(
                        child: helpers.isEmpty
                            ? const Center(
                                child: Text("No domestic helpers found."),
                              )
                            : ListView.builder(
                                itemCount: helpers.length,
                                itemBuilder: (context, index) {
                                  final helper = helpers[index];
                                  return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(HelperProfile(
                                            workerId: helper.id.toString(),
                                          ));
                                        },
                                        child: Card(
                                          surfaceTintColor:
                                              AppColors.globalWhite,
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          color: AppColors.globalWhite,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 32,
                                                      backgroundColor:
                                                          AppColors.appThem,
                                                      child: Image.asset(
                                                          AppImages.user,
                                                          height: 50),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            helper.name ??
                                                                'N/A',
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                helper.occupation ??
                                                                    'Unknown',
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                helper.available ==
                                                                        1
                                                                    ? 'Available'
                                                                    : 'UnAvailable',
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: helper
                                                                              .available ==
                                                                          1
                                                                      ? AppColors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              RatingBarIndicator(
                                                                rating: double.tryParse(
                                                                        helper.ratingsAvgRating ??
                                                                            '0') ??
                                                                    0.0,
                                                                itemBuilder: (context,
                                                                        index) =>
                                                                    Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber),
                                                                itemCount: 5,
                                                                itemSize: 18.0,
                                                                unratedColor:
                                                                    Colors.grey[
                                                                        300],
                                                                direction: Axis
                                                                    .horizontal,
                                                              ),
                                                              const SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                (double.tryParse(helper.ratingsAvgRating ??
                                                                            '0') ??
                                                                        0.0)
                                                                    .toStringAsFixed(
                                                                        1),
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                infoRow(Icons.location_on,
                                                    helper.address ?? 'N/A'),
                                                infoRow(Icons.work_outline,
                                                    'Jobs Finished: ${helper.bookings?.length ?? 0}'),
                                                infoRow(Icons.monetization_on,
                                                    'Visit Fee: Rs. ${helper.visitingFee ?? 0}'),
                                                infoRow(Icons.cake,
                                                    'Age: ${helper.age ?? '--'}'),
                                                infoRow(Icons.phone,
                                                    helper.phone ?? 'N/A'),
                                                infoRow(Icons.badge,
                                                    'CNIC: ${helper.cnic ?? 'N/A'}'),
                                                const SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.to(
                                                            UpdateDomeasticHelpScreen(
                                                          name:
                                                              helper.name ?? "",
                                                          phone: helper.phone ??
                                                              "",
                                                          cnic:
                                                              helper.cnic ?? "",
                                                          age: helper.age
                                                              .toString(),
                                                          address:
                                                              helper.address ??
                                                                  "",
                                                          visitingFee: helper
                                                              .visitingFee
                                                              .toString(),
                                                          workerId:
                                                              helper.id ?? 0,
                                                        ));
                                                      },
                                                      icon: Icon(Icons
                                                          .edit), // Most intuitive for "Update"
                                                      tooltip: 'Update',
                                                      color: AppColors.appThem,
                                                      iconSize: 30,
                                                    ),
                                                    IconButton(
                                                        iconSize: 30,
                                                        onPressed: () {
                                                          domesticHelpController
                                                                  .deleteDomesticHelperLoading
                                                                  .value =
                                                              false; // reset before showing dialog

                                                          Get.dialog(
                                                            Obx(() {
                                                              return AlertDialog(
                                                                surfaceTintColor:
                                                                    AppColors
                                                                        .globalWhite,
                                                                title: Text(
                                                                  'Confirm Deletion',
                                                                  style: GoogleFonts.dmSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                content: const Text(
                                                                    'Are you sure you want to delete this helper?'),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    child: Text(
                                                                        'Cancel',
                                                                        style: GoogleFonts.dmSans(
                                                                            color:
                                                                                AppColors.colorRed)),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .colorRed,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                    ),
                                                                    onPressed: domesticHelpController
                                                                            .deleteDomesticHelperLoading
                                                                            .value
                                                                        ? null
                                                                        : () {
                                                                            domesticHelpController.deleteDomesticHelper(
                                                                                workerId: helper.id.toString(),
                                                                                context: context);

                                                                            if (!domesticHelpController.deleteDomesticHelperLoading.value) {
                                                                              Get.back(); // Close the dialog only after loading becomes false
                                                                            }
                                                                          },
                                                                    child: domesticHelpController
                                                                            .deleteDomesticHelperLoading
                                                                            .value
                                                                        ? SizedBox(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                20,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              strokeWidth: 2,
                                                                              color: AppColors.globalWhite,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            'Delete',
                                                                            style:
                                                                                GoogleFonts.dmSans(color: Colors.white)),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                            barrierDismissible:
                                                                false,
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: AppColors
                                                              .colorRed,
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

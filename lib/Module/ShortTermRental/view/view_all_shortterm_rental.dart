// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/ShortTermRental/controller/short_term_rental_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/My_Floating_Button.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class AllShortTermRentalScreen extends StatefulWidget {
  const AllShortTermRentalScreen({super.key});

  @override
  State<AllShortTermRentalScreen> createState() =>
      _AllShortTermRentalScreenState();
}

class _AllShortTermRentalScreenState extends State<AllShortTermRentalScreen> {
  var shortTermRentalController = Get.find<ShortTermRentalController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen,
              arguments: shortTermRentalController.userdata);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          floatingActionButton: MyFloatingButton(onPressed: () {
            Get.offAndToNamed(
              shortTermRental,
              arguments: shortTermRentalController.user,
            );
          }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyBackButton(
                text: 'Short Term Rental',
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: shortTermRentalController.userdata);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: shortTermRentalController.viewAllShortTermRentals(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularIndicatorUnderWhiteBox());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      var rentalList = shortTermRentalController
                          .allShortTermRentalModel.data;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: rentalList.length,
                        itemBuilder: (context, index) {
                          var rental = rentalList[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 6,
                              shadowColor: Colors.grey.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                          backgroundColor: AppColors.appThem
                                              .withOpacity(0.1),
                                          child: Icon(Icons.home,
                                              color: AppColors.appThem),
                                        ),
                                        title: Text(
                                          rental.appartment?.floor?.building
                                                  ?.societyBuildingName ??
                                              "",
                                          style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Divider(color: Colors.grey.shade300),
                                      const SizedBox(height: 12),
                                      buildDetailRow(
                                          icon: Icons.person,
                                          label: 'Guest Name',
                                          value: rental.guestName),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.phone,
                                          label: 'Phone',
                                          value: rental.guestPhone),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.person,
                                          label: 'Floor',
                                          value:
                                              rental.appartment?.floor?.name ??
                                                  ""),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.person,
                                          label: 'Apartment',
                                          value: rental.appartment?.name ?? ""),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.calendar_today,
                                          label: 'Check-in',
                                          value: rental.checkInDate),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.calendar_today_outlined,
                                          label: 'Check-out',
                                          value: rental.checkOutDate),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.directions_car,
                                          label: 'Vehicle No',
                                          value: rental.vehicleNumber),
                                      const SizedBox(height: 10),
                                      buildDetailRow(
                                          icon: Icons.attach_money,
                                          label: 'Total Price',
                                          value: '${rental.totalPrice} PKR'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No Data Found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(
      {required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.appThem.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.appThem, size: 20),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

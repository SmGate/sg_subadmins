import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Module/domestic_help/model/domestic_helper_profile.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class HelperProfile extends StatelessWidget {
  final String workerId;
  const HelperProfile({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DomesticHelpCOntroller());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            MyBackButton(
              onTap: () {
                Get.offNamed(allDomesticHelp, arguments: controller.userdata);
              },
              text: "Helpers Profile",
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: controller.getDomesticHelperProfile(workerId: workerId),
                builder: (context, snapshot) {
                  if (controller.viewDomesticHelperProfileLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appThem,
                      ),
                    );
                  }

                  if (controller.viewDomesticHelperProfileError.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.viewDomesticHelperProfileError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final data = controller.viewDomesticHelperProfileModel.data;
                  if (data == null) {
                    return const Center(child: Text("No data found"));
                  }

                  final avgRating = (data.ratings?.isNotEmpty ?? false)
                      ? (data.ratings!
                              .map((e) => e.rating ?? 0)
                              .reduce((a, b) => a + b) /
                          data.ratings!.length)
                      : 0.0;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 6,
                      color: AppColors.globalWhite,
                      surfaceTintColor: AppColors.globalWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.appThem,
                                  child:
                                      Image.asset(AppImages.user, height: 50),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name ?? 'N/A',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.occupation ?? 'Unknown Occupation',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.available == 1
                                            ? 'Active'
                                            : 'Inactive',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: data.available == 1
                                              ? AppColors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Info Rows
                            _infoRow(Icons.phone, data.phone ?? 'N/A'),
                            _infoRow(
                                Icons.badge, 'CNIC: ${data.cnic ?? 'N/A'}'),
                            _infoRow(Icons.location_on, data.address ?? 'N/A'),
                            _infoRow(Icons.cake, 'Age: ${data.age ?? '--'}'),
                            _infoRow(Icons.monetization_on,
                                'Visit Fee: Rs. ${data.visitingFee ?? 0}'),
                            _infoRow(Icons.work_outline,
                                'Jobs Finished: ${data.bookings?.length ?? 0}'),

                            const Divider(height: 30),

                            // Ratings
                            Text("Ratings",
                                style: GoogleFonts.dmSans(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: avgRating,
                                  itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber),
                                  itemCount: 5,
                                  itemSize: 24.0,
                                  unratedColor: Colors.grey[300],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  avgRating.toStringAsFixed(1),
                                  style: GoogleFonts.dmSans(
                                      color: Colors.grey[700]),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            if (data.ratings != null &&
                                data.ratings!.isNotEmpty)
                              ...data.ratings!.map((r) => _ratingTile(r)),

                            const Divider(height: 30),

                            // Bookings
                            Text("Bookings",
                                style: GoogleFonts.dmSans(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            if (data.bookings != null &&
                                data.bookings!.isNotEmpty)
                              Container(
                                height:
                                    250, // Set the height to allow scrolling
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: data.bookings!.length,
                                  itemBuilder: (context, index) {
                                    final booking = data.bookings![index];
                                    return _bookingTile(booking);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingTile(Rating rating) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rating.resident != null)
            Text(
              rating.resident?.username?.toString() ?? 'Anonymous',
              style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 4),
          RatingBarIndicator(
            rating: (rating.rating ?? 0).toDouble(),
            itemBuilder: (context, index) =>
                const Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            unratedColor: Colors.grey[300],
          ),
          const SizedBox(height: 6),
          Text(
            rating.review ?? 'No review',
            style: GoogleFonts.dmSans(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _bookingTile(Booking booking) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Job Date: ${_formatDate(booking.jobDate)}"),
          const SizedBox(height: 4),
          Text("Time: ${booking.jobTime ?? 'N/A'}"),
          const SizedBox(height: 4),
          Text("Status: ${booking.status ?? 'N/A'}"),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }
}

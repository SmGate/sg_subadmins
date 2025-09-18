import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Module/domestic_help/model/all_bookings_model.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  @override
  Widget build(BuildContext context) {
    final domesticHelpController = Get.put(DomesticHelpCOntroller());

    return Column(
      children: [
        // FutureBuilder for displaying bookings data
        Expanded(
          child: FutureBuilder<AllBookingsModel?>(
            future: domesticHelpController.getAllBookings(
              societyId: domesticHelpController.userdata.societyid,
            ),
            builder: (context, snapshot) {
              // Loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appThem,
                  ),
                );
              }

              // Error state
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Text(
                    "Error: ${domesticHelpController.getAllBookingsError}",
                  ),
                );
              }

              // No bookings found
              if (snapshot.data?.data?.isEmpty ?? true) {
                return const Center(
                  child: Text("No bookings found."),
                );
              }

              // Success state: displaying the bookings
              final bookings = snapshot.data?.data ?? [];

              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        showBookingDetailsDialog(booking);
                      },
                      child: Card(
                        surfaceTintColor: AppColors.globalWhite,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: AppColors.globalWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Booking info
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: AppColors.appThem,
                                    child: Image.asset(AppImages.user),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          booking.worker?.name ?? 'N/A',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Job Date: ${formatDate(booking.jobDate)}",
                                          style: GoogleFonts.dmSans(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "Status:",
                                              style: GoogleFonts.dmSans(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: booking.status ==
                                                          "completed"
                                                      ? Colors.green
                                                      : booking.status ==
                                                              "pending"
                                                          ? Colors.orange
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  "${booking.status ?? 'N/A'}",
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
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
                              // Booking details
                              infoRow(Icons.location_on,
                                  booking.resident?.houseaddress ?? 'N/A'),
                              infoRow(
                                  Icons.phone, booking.resident?.city ?? 'N/A'),
                              infoRow(Icons.calendar_today,
                                  'Job Date: ${formatDate(booking.jobDate)}'),

                              SizedBox(
                                height: 4,
                              ),
                              _buildRating(booking.rating),

                              // Click to show all details in dialog
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  showBookingDetailsDialog(booking);
                                },
                                child: Text(
                                  "Show all details",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: AppColors.appThem,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper function to display booking details in a dialog
  void showBookingDetailsDialog(Datum booking) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: AppColors.globalWhite,
          backgroundColor: AppColors.globalWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Worker Info Section
                  _buildSectionTitle("Worker Info"),
                  SizedBox(
                    height: 20,
                  ),
                  _buildInfoRow(
                    "Name",
                    booking.worker?.name ?? 'N/A',
                  ),
                  _buildInfoRow(
                      "Occupation", booking.worker?.occupation ?? 'N/A'),
                  _buildInfoRow("Job Date", formatDate(booking.jobDate)),
                  _buildInfoRow("Job Time", booking.jobTime ?? 'N/A'),
                  _buildInfoRow("Status", booking.status ?? 'N/A'),
                  const SizedBox(height: 16),

                  // Resident Info Section
                  _buildSectionTitle("Resident Info"),
                  _buildInfoRow(
                    "Name",
                    booking.resident?.username ?? 'N/A',
                  ),
                  _buildInfoRow(
                      "Address", booking.resident?.houseaddress ?? 'N/A'),
                  GestureDetector(
                    onTap: () async {
                      Uri? uri = Uri.parse("tel://${booking.worker?.phone}");

                      try {
                        await launchUrl(uri);
                        uri = null;
                      } catch (e) {}
                    },
                    child: Row(
                      children: [
                        Text(
                          "Phone",
                          style: reusableTextStyle(
                            fontSize: 14,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(Icons.phone, color: AppColors.appThem),
                        const SizedBox(width: 8),
                        Text(
                          booking.worker?.phone ?? 'NA',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.appThem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating Info Section
                  _buildSectionTitle("Rating Info"),
                  _buildRating(booking.rating),
                  const SizedBox(height: 16),

                  // Remarks Section
                  _buildSectionTitle("Other Details"),
                  _buildInfoRow("Remarks", booking.remarks ?? 'N/A'),
                  _buildInfoRow("Created At", formatDate(booking.createdAt)),
                  _buildInfoRow("Updated At", formatDate(booking.updatedAt)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: reusableTextStyle(
            fontSize: 16,
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600));
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: reusableTextStyle(
                fontSize: 14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(Rating? rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBarIndicator(
          rating: double.tryParse(rating?.rating?.toString() ?? '0') ?? 0.0,
          itemBuilder: (context, index) =>
              Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 24.0,
          unratedColor: Colors.grey[300],
          direction: Axis.horizontal,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 250,
          child: Text(
            "Review: ${rating?.review ?? 'No review'}",
            style: GoogleFonts.dmSans(fontSize: 16, color: Colors.grey[700]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Helper function to format date in YYYY-MM-DD format
  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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

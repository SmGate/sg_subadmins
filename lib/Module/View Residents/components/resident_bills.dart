import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/View%20Residents/Controller/residents_records_controller.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_bills_model.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class BillTab extends StatefulWidget {
  final String residentId;

  BillTab({
    Key? key,
    required this.residentId,
  }) : super(key: key);

  @override
  _BillTabState createState() => _BillTabState();
}

class _BillTabState extends State<BillTab> {
  final residentDetailsController = Get.put(ResidentRecordController());
  TextEditingController textController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    startDate = DateTime(now.year, now.month, 1);
    endDate = DateTime(now.year, now.month, now.day);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime initialDate = DateTime.now();
    final DateTime firstDate =
        isStartDate ? DateTime(2020) : startDate ?? DateTime(2020);
    final DateTime lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;

          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Date Range',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.appThem,
                            AppColors.appThem.withOpacity(0.7)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appThem.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            startDate != null
                                ? "${startDate!.toLocal()}".split(' ')[0]
                                : "Start Date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0), // spacing between the date fields
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.appThem,
                            AppColors.appThem.withOpacity(0.7)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appThem.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            endDate != null
                                ? "${endDate!.toLocal()}".split(' ')[0]
                                : "End Date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            controller: textController,
            cursorColor: AppColors.appThem,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintText: "Enter Search Text",
              hintStyle: GoogleFonts.dmSans(
                  fontSize: 14.0, color: AppColors.boldHeading),
              labelText: "Enter Search Text",
              labelStyle:
                  GoogleFonts.dmSans(fontSize: 14.0, color: AppColors.appThem),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: AppColors.appThem, width: 1.5),
              ),
            ),
            onChanged: (value) {
              residentDetailsController.billsSearchValue.value = value;
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<ResidentBillsModel>(
              future: residentDetailsController.getAllBills(
                residetId: widget.residentId,
                startDate: startDate?.toIso8601String() ?? "",
                endDate: endDate?.toIso8601String() ?? "",
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appThem,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data?.data == null) {
                    return Center(
                      child: Text('No Bills found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = snapshot.data?.data?[index];

                        if (data == null) {
                          return SizedBox(); // Handle null data
                        }

                        String title = data.description ?? "";

                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 20 : 10),
                          child: Obx(() {
                            if (residentDetailsController
                                    .billsSearchValue.value ==
                                "") {
                              return complaintCard(data);
                            } else if (title.toLowerCase().contains(
                                residentDetailsController.billsSearchValue.value
                                    .toLowerCase())) {
                              return complaintCard(data);
                            } else {
                              return Container(); // No match found
                            }
                          }),
                        );
                      },
                    );
                  }
                } else {
                  return Center(child: Text('Unexpected state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Complaint card widget
  Card complaintCard(Datum data) {
    Color getStatusColor(String? status) {
      switch (status?.toLowerCase()) {
        case 'unpaid':
          return Colors.red; // Color for pending
        case 'partially paid':
          return Colors.blue; // Color for in-progress
        case 'paid':
          return Colors.green; // Color for completed
        default:
          return Colors.grey; // Default color
      }
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.globalWhite,
      surfaceTintColor: AppColors.globalWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: AppColors.appThem,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.receipt_long, color: Colors.white),
                )),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column for labels
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill #",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Bill Type",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Description",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data.status == "unpaid" ||
                                      data.status == "partially paid"
                                  ? "Payable Amount"
                                  : "Total Paid Amount",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.billNumber ?? "NA",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data.specificType ?? "NA",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data.description ?? "No Description",
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data.status == "unpaid" ||
                                      data.status == "partiallypaid"
                                  ? data.payableamount.toString()
                                  : data.totalpaidamount.toString(),
                              style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0), // Adjust padding
                      decoration: BoxDecoration(
                        color: getStatusColor(data.status),
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                      child: Text(
                        data.status ?? "NA",
                        style: GoogleFonts.dmSans(
                          fontSize: 14.0,
                          color: Colors.white, // White text color
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

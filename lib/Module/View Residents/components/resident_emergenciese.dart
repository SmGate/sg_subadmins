import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/View%20Residents/Controller/residents_records_controller.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_emergency_model.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class EmergencyTab extends StatefulWidget {
  final String residentId;

  EmergencyTab({
    Key? key,
    required this.residentId,
  }) : super(key: key);

  @override
  _EmergencyTabState createState() => _EmergencyTabState();
}

class _EmergencyTabState extends State<EmergencyTab> {
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
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0), // spacing between the date fields
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
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
                              color: Colors.white),
                        ),
                      ],
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
              hintText: "Search by problem description...",
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
              residentDetailsController.emergencieseSearchValue.value = value;
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<ResidentEmergencyModel>(
              future: residentDetailsController.getAllEmergency(
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
                      child: Text('No emergencies found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = snapshot.data?.data?[index];

                        if (data == null) {
                          return SizedBox(); // Handle null data
                        }

                        String title = data.problem ?? "";

                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 20 : 10),
                          child: Obx(() {
                            if (residentDetailsController
                                    .emergencieseSearchValue.value ==
                                "") {
                              return emergencyCard(data);
                            } else if (title.toLowerCase().contains(
                                residentDetailsController
                                    .emergencieseSearchValue.value
                                    .toLowerCase())) {
                              return emergencyCard(data);
                            } else {
                              return Container(); 
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

  // Emergency card widget
  Card emergencyCard(Datum data) {
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
            Image.asset(
              AppImages.panicButton,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.problem ?? "No Title",
                    style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.description ?? "No Description",
                    style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w400,
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

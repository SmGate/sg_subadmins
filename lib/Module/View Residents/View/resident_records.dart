// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/View%20Residents/components/resident_bills.dart';
import 'package:societyadminapp/Module/View%20Residents/components/resident_complaint.dart';
import 'package:societyadminapp/Module/View%20Residents/components/resident_emergenciese.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class ResidentRecordsScreen extends StatefulWidget {
  final String residentId;

  ResidentRecordsScreen({required this.residentId});

  @override
  _ResidentRecordsScreenState createState() => _ResidentRecordsScreenState();
}

class _ResidentRecordsScreenState extends State<ResidentRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Resident Records"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBar(
                indicatorColor: AppColors.appThem,
                labelStyle: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 13.0,
                  color: AppColors.boldHeading,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: "Complaints"),
                  Tab(text: "Emergencies"),
                  Tab(text: "Bills"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ComplaintTab(
              residentId: widget.residentId,
            ),
            EmergencyTab(
              residentId: widget.residentId,
            ),
            BillTab(
              residentId: widget.residentId,
            )
          ],
        ),
      ),
    );
  }
}

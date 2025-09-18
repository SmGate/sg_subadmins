// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Module/domestic_help/view/all_bookings.dart';
import 'package:societyadminapp/Module/domestic_help/view/all_workers.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class AllDomesticHelper extends StatefulWidget {
  const AllDomesticHelper({super.key});

  @override
  State<AllDomesticHelper> createState() => _AllDomesticHelperState();
}

class _AllDomesticHelperState extends State<AllDomesticHelper>
    with SingleTickerProviderStateMixin {
  final domesticHelpController = Get.put(DomesticHelpCOntroller());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(allDomesticHelp,
            arguments: domesticHelpController.userdata);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              // MyBackButton at the top
              MyBackButton(
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: domesticHelpController.userdata);
                },
                text: "Domestic Help",
              ),

              // TabBar below the MyBackButton
              TabBar(
                indicatorColor: AppColors.appThem,
                labelStyle: reusableTextStyle(
                    color: AppColors.appThem,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Service Requests'),
                  Tab(text: 'Service Providers'),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              // TabBarView for displaying Workers and Booking tabs
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Workers Tab

                    AllBookings(),
                    AllWorkers(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

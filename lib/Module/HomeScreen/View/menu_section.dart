import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:societyadminapp/Module/HomeScreen/components/menu_items.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Services/Shared%20Preferences/MySharedPreferences.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:badges/badges.dart' as badges;

class MenuSection extends StatelessWidget {
  final HomeScreenController controller;

  const MenuSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final permissions = controller.user.permissions;

    // List of all menu items with associated permissions
    final List<Map<String, dynamic>> allItems = [

      {
        'permission': (controller.user.isMainAdmin ?? 0) == 1,
        'widget': MenuItems(
          image: AppImages.person,
          title: "Managers",
          ontap: () => Get.offNamed(subadminList, arguments: controller.user),
        ),
      },
      {
        'permission': true,
        'widget': MenuItems(
          image: AppImages.resident,
          title: "Residents",
          ontap: () => Get.offNamed(viewuser, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['gate_keeper'],
        'widget': MenuItems(
          image: AppImages.gateKeeper,
          title: "Gate\nKeeper",
          ontap: () =>
              Get.offNamed(gatekeeperscreen, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['events'],
        'widget': MenuItems(
            image: AppImages.societyEvents,
            title: "Society\nEvents",
            ontap: () =>
                Get.offNamed(eventsscreen, arguments: controller.user)),
      },
      {
        'permission': permissions?['notice_board'],
        'widget': MenuItems(
          image: AppImages.noticeBoard,
          title: "Notice\nBoard",
          ontap: () =>
              Get.offNamed(noticeboardscreen, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['complaint'],
        'badgeCount': controller.inProgressReportCount,
        'widget': MenuItems(
          image: AppImages.report,
          title: "Complaints",
          ontap: () {
            controller.inProgressReportCount = 0;
            controller.update();
            Get.offNamed(viewreportscreen, arguments: controller.user);
          },
        ),
      },
      {
        'permission': true, // based on structureType, no badge
        'widget': MenuItems(
          image: AppImages.societyDetails,
          title: controller.user.structureType == 6
              ? "Buildings\nDetails"
              : "Society\nDetails",
          ontap: () {
            switch (controller.user.structureType) {
              case 1:
                Get.offNamed(streetorbuildingscreen,
                    arguments: controller.user);
                break;
              case 2:
                Get.offNamed(blockorsocietybuilding,
                    arguments: controller.user);
                break;
              case 3:
                Get.offNamed(phaseorsocietybuilding,
                    arguments: controller.user);
                break;
              case 4:
                Get.offNamed(localbuildingscreen, arguments: controller.user);
                break;
              case 5:
                Get.offNamed(structureType5HouseOrBuildingMiddlewareScreen,
                    arguments: controller.user);
                break;

              case 6:
                Get.offNamed(societybuildingscreen, arguments: controller.user);
                break;
            }
          },
        ),
      },
      {
        'permission': true,
        'badgeCount': controller.unVerifiedUserCount,
        'widget': MenuItems(
          image: AppImages.residentVerification,
          title: "Resident\nVerification",
          ontap: () {
            controller.unVerifiedUserCount = 0;
            controller.update();
            Get.offNamed(unverifiedresident, arguments: controller.user);
          },
        ),
      },
      {
        'permission': true,
        'widget': MenuItems(
          image: AppImages.measurement,
          title: "Measure\nMent",
          ontap: () =>
              Get.offNamed(measurementview, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['emergency'],
        'badgeCount': controller.emergencyCount,
        'widget': MenuItems(
          image: AppImages.panicButton,
          title: "Residential\nEmergency",
          ontap: () {
            controller.emergencyCount = 0;
            controller.update();
            Get.offNamed(residentialEmergencyScreen,
                arguments: controller.user);
          },
        ),
      },
      {
        'permission': permissions?['finance_manager'],
        'widget': MenuItems(
          image: AppImages.financeManager,
          title: "Finance\nManager",
          ontap: () =>
              Get.offNamed(viewFinanceManager, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['visitors'],
        'widget': MenuItems(
          image: AppImages.visitorsLogs,
          title: "Visitors\nLogs",
          ontap: () => Get.offNamed(visitorsLogs, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['e_voting'],
        'widget': MenuItems(
          image: AppImages.vote,
          title: "E-Voting",
          ontap: () => Get.offNamed(voting, arguments: controller.user),
        ),
      },
      {
        'permission': permissions?['parking'],
        'widget': MenuItems(
          image: AppImages.parkinng,
          title: "Parking\nManagement",
          ontap: () =>
              Get.offNamed(assignedParking, arguments: controller.user),
        ),
      },
      
      {
        'permission': permissions?['domestic_help'],
        'widget': MenuItems(
          image: AppImages.maids,
          title: "Domestic\nHelp",
          ontap: () =>
              Get.offNamed(allDomesticHelp, arguments: controller.user),
        ),
      },
      {
        'permission': true,
        'widget': MenuItems(
          image: AppImages.shortTermRental,
          title: "Short Term\nRental",
          ontap: () =>
              Get.offNamed(allShortTermRental, arguments: controller.user),
        ),
      },
      {
        'permission': true,
        'widget': MenuItems(
          image: AppImages.supportTicket,
          title: "Support\nTicket",
          ontap: () => Get.offNamed(supportTicket, arguments: controller.user),
        ),
      },
      {
        'permission': true,
        'widget': MenuItems(
          image: AppImages.logout,
          title: "Logout",
          ontap: () {
            MySharedPreferences.deleteUserData();
            Get.offAllNamed(login);
          },
        ),
      },
      {
        'permission': true,
        'widget': SizedBox(
          width: 150,
        )
      },
    ];

    // Filter allowed items
    final allowedItems =
        allItems.where((item) => item['permission'] == true).map((item) {
      if (item['badgeCount'] != null && item['badgeCount'] > 0) {
        return badges.Badge(
          position: badges.BadgePosition.bottomEnd(end: 4, bottom: 60),
          badgeContent: Text(
            item['badgeCount'] >= 100
                ? controller.countGreaterThanHundred
                : item['badgeCount'].toString(),
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          child: item['widget'],
        );
      } else {
        return item['widget'];
      }
    }).toList();

    // Break into rows of 2
    List<Widget> rows = [];
    for (int i = 0; i < allowedItems.length; i += 2) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              allowedItems[i],
              if (i + 1 < allowedItems.length)
                allowedItems[i + 1]
              else
                const SizedBox(width: 100),
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

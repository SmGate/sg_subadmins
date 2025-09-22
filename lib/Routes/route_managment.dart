import 'package:get/get.dart';
import 'package:societyadminapp/Module/AddNoticeBoard/View/add_notice_board_screen.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Blocks/View/add_blocks.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Houses/View/add_houses.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Streets/View/add_streets.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Blocks/View/blocks.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Streets/View/streets.dart';
import 'package:societyadminapp/Module/AdminProfile/View/admin_profile_screen.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/views/all_resident.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/views/blocked_user.dart';
import 'package:societyadminapp/Module/Events/View/events_screen.dart';
import 'package:societyadminapp/Module/Events/View/view_event_images_screen.dart';
import 'package:societyadminapp/Module/GateKepeer/View/gate_keeper_screen.dart';
import 'package:societyadminapp/Module/Login/View/login.dart';
import 'package:societyadminapp/Module/Measurements/View/add_measurements.dart';
import 'package:societyadminapp/Module/Measurements/View/edit_measurment.dart';
import 'package:societyadminapp/Module/Measurements/View/measurements_view.dart';
import 'package:societyadminapp/Module/NoticeBoard/View/notice_board_screen.dart';
import 'package:societyadminapp/Module/Report%20Notifications/View/report_notifications_screen.dart';
import 'package:societyadminapp/Module/ShortTermRental/view/rent_settlement_screen.dart';
import 'package:societyadminapp/Module/ShortTermRental/view/short_term_rental.dart';
import 'package:societyadminapp/Module/ShortTermRental/view/view_all_shortterm_rental.dart';
import 'package:societyadminapp/Module/Society%20Apartment%20Bills/View/generate_society_apartment_bills.dart';
import 'package:societyadminapp/Module/SocietyRules/view/add_society_rules.dart';
import 'package:societyadminapp/Module/SocietyRules/view/society_rules.dart';
import 'package:societyadminapp/Module/Splash/View/no_internet_screen.dart';
import 'package:societyadminapp/Module/Splash/View/splash_screen.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/View/apartment_resident_verification.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/View/unverified_residents.dart';
import 'package:societyadminapp/Module/UpdateNoticeBoard/View/update_notice_screen.dart';
import 'package:societyadminapp/Module/View%20Residents/View/view_residents.dart';
import 'package:societyadminapp/Module/ViewReports/View/reported_residents_screen.dart';
import 'package:societyadminapp/Module/ViewReports/View/residents_report_list_screen.dart';
import 'package:societyadminapp/Module/Visitors%20Logs/views/visitors_logs_screen.dart';
import 'package:societyadminapp/Module/domestic_help/view/all_domestic_helper.dart';
import 'package:societyadminapp/Module/domestic_help/view/domestic_help_screen.dart';
import 'package:societyadminapp/Module/luggage_pass/view/get_all_luggage_passess.dart';
import 'package:societyadminapp/Module/parking%20managment/view/assigned_parking.dart';
import 'package:societyadminapp/Module/parking%20managment/view/add-assign_parking.dart';
import 'package:societyadminapp/Module/support_ticket/view/all_supports_tickets.dart';
import 'package:societyadminapp/Module/Subadmin/View/subadmin_list_screen.dart';
import 'package:societyadminapp/Module/Subadmin/View/add_subadmin_screen.dart';
import 'package:societyadminapp/Module/Subadmin/View/update_subadmin_building_screen.dart';
import 'package:societyadminapp/Module/Subadmin/View/update_subadmin_screen.dart';
import 'package:societyadminapp/Module/visitors_details/view/visitore_details_screen.dart';
import 'package:societyadminapp/Module/voting/view/generate_poll.dart';
import 'package:societyadminapp/Module/voting/view/voting_screen.dart';
import 'package:societyadminapp/Routes/screen_binding.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import '../Module/Add Event/View/add_event.dart';
import '../Module/Add Event/View/update_event.dart';
import '../Module/AddGateKepeer/View/add_gatekepeer.dart';
import '../Module/AddLocalBuildingDetail/AddLocalBuildingApartments/View/add_local_building_apartment_screen.dart';
import '../Module/AddLocalBuildingDetail/AddLocalBuildingFloors/View/add_local_building_floors_screen.dart';
import '../Module/AddLocalBuildingDetail/LocalBuilding/View/local_building_screen.dart';
import '../Module/AddLocalBuildingDetail/LocalBuildingApartments/View/local_building_apartment_screen.dart';
import '../Module/AddLocalBuildingDetail/LocalBuildingFloors/View/local_building_floors_screen.dart';
import '../Module/AddSocietyDetail/Add Phases/View/add_phases.dart';
import '../Module/AddSocietyDetail/AddBlockOrPhaseBuilding/View/add_block_building_screen.dart';
import '../Module/AddSocietyDetail/AddBlockOrPhaseBuildingApartment/View/add_block_or_phase_building_floors_screen.dart';
import '../Module/AddSocietyDetail/AddBlockOrPhaseBuildingFloor/View/add_block_or_phase_building_floors_screen.dart';
import '../Module/AddSocietyDetail/AddSocietyBuildingApartment/View/add_society_building_apartment.dart';
import '../Module/AddSocietyDetail/AddSocietyBuildingFloors/View/add_society_building_floor_screen.dart';
import '../Module/AddSocietyDetail/AddSocietyBuildings/View/add_society__buildings_screen.dart';
import '../Module/AddSocietyDetail/BlockBuildingOrStreet/View/block_building_or_street_screen.dart';
import '../Module/AddSocietyDetail/BlockOrPhaseBuilding/View/block_building_screen.dart';
import '../Module/AddSocietyDetail/BlockOrPhaseBuildingApartment/View/block_or_phase_building_apartment_screen.dart';
import '../Module/AddSocietyDetail/BlockOrPhaseBuildingFloor/View/block_or_phase_building_floor_screen.dart';
import '../Module/AddSocietyDetail/BlockOrSocietyBuilding/View/block_or_society_building_screen.dart';
import '../Module/AddSocietyDetail/BlocksOrBuildings/View/blocks_or_buildings_screen.dart';
import '../Module/AddSocietyDetail/Houses/View/houses.dart';
import '../Module/AddSocietyDetail/PhaseBuildingOrBlock/View/phase_building_or_block_screen.dart';
import '../Module/AddSocietyDetail/PhaseOrSocietyBuilding/View/phase_or_society_building_screen.dart';
import '../Module/AddSocietyDetail/Phases/View/phases.dart';
import '../Module/AddSocietyDetail/SocietyBuildingApartment/View/society_building_apartment_screen.dart';
import '../Module/AddSocietyDetail/SocietyBuildingFloor/View/society_building_floor_screen.dart';
import '../Module/AddSocietyDetail/SocietyBuildings/View/society_building_screen.dart';
import '../Module/AddSocietyDetail/StreetOrBuilding/View/street_or_building_screen.dart';
import '../Module/AddSocietyDetail/StructureType5HouseOrBuildingMiddleWare/View/structure_type5_house_or_building_screen.dart';
import '../Module/Finance Manger/Add Finance Manager/View/add_finance_manager.dart';
import '../Module/Finance Manger/Update Finance Manager Details/View/update_finance_manager_details.dart';
import '../Module/Finance Manger/View Finance Manager/View/view_finance_manager.dart';
import '../Module/HomeScreen/View/home_screen.dart';
import '../Module/House Bills/View/generate_house_bill.dart';
import '../Module/House Bills/View/generated_house_bill.dart';
import '../Module/Residental Emergency/View/residential_emergency_screen.dart';
import '../Module/Society Apartment Bills/View/generated_society_apartment_bills.dart';
import '../Module/UnVerifiedResidents/View/house_resident_verification.dart';
import '../Module/UnVerifiedResidents/View/local_building_apartment_resident_verification.dart';
import '../Module/UpdateGateKeeper/View/updategatekeeper_detail_screen.dart';

class RouteManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashscreen,
          page: () => SplashScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: login,
          page: () => Login(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: homescreen,
          page: () => HomeScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: viewuser,
          page: () => ViewResidents(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      // GetPage(
      //     name: updateresidentdetails,
      //     page: () => UpdateResidentDetails(),
      //     binding: ScreenBindings(),
      //     ),
      // GetPage(
      //     name: chatscreen,
      //     page: () => ChatScreen(),
      //     binding: ScreenBindings(),
      //     ),
      GetPage(
          name: gatekeeperscreen,
          page: () => GateKeeperScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addgatekeeperscreen,
          page: () => AddGateKeeper(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: updategatekeeperscreen,
          page: () => UpdateGateKepeerScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: eventsscreen,
          page: () => EventsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addeventsscreen,
          page: () => AddEventsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: updateevent,
          page: () => UpdateEvent(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: adminprofilescreen,
          page: () => AdminProfileScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: reportnotificationsscreen,
          page: () => ReportNotificationsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: viewreportscreen,
          page: () => ReportedResidentListScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: userreportslistscreen,
          page: () => UserReportsListScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: noticeboardscreen,
          page: () => NoticeBoardScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addnoticeboardscreen,
          page: () => AddNoticeBoardScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: updatenoticeboardscreen,
          page: () => UpdateNoticeBoardScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: vieweventimages,
          page: () => ViewEventImages(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addphases,
          page: () => AddPhases(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: phasess,
          page: () => Phases(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: blocks,
          page: () => Blocks(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addblocks,
          page: () => AddBlocks(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: streets,
          page: () => Street(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addstreets,
          page: () => AddStreets(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addhouses,
          page: () => AddHouses(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: houses,
          page: () => Houses(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: unverifiedresident,
          page: () => UnVerifiedResident(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addmeasurements,
          page: () => AddMeasurements(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: measurementview,
          page: () => MeasurementView(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: houseresidentverification,
          page: () => HouseResidentVerification(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: generatehousebills,
          page: () => GenerateHouseBill(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: generatedhousebills,
          page: () => GeneratedHouseBill(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: blockorbuilding,
          page: () => BlockOrBuilding(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: societybuildingscreen,
          page: () => SocietyBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addsocietybuildingscreen,
          page: () => AddSocietyBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: societybuildingfloorsscreen,
          page: () => SocietyBuildingFloorsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addsocietybuildingfloors,
          page: () => AddSocietyBuildingFloors(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: societybuildingapartmentscreen,
          page: () => SocietyBuildingApartmentScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addsocietybuildingapartmentsscreen,
          page: () => AddSocietyBuildingApartmentsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: streetorbuildingscreen,
          page: () => StreetOrBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: blockorsocietybuilding,
          page: () => BlockOrSocietyBuilding(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: phaseorsocietybuilding,
          page: () => PhaseOrSocietyBuilding(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: blockbuildingorstreet,
          page: () => BlockBuildingOrStreet(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: blockbuilding,
          page: () => BlockBuilding(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addblockbuildingscreen,
          page: () => AddBlockBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: phasebuildingorblock,
          page: () => PhaseBuildingOrBlock(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: blockorphasebuildingfloorsscreen,
          page: () => BlockOrPhaseBuildingFloorsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addblockorphasebuildingfloors,
          page: () => AddBlockOrPhaseBuildingFloors(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: blockOrphasebuildingapartmentsscreen,
          page: () => BlockOrPhaseBuildingApartmentsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addblockorphasebuildingapartmentsscreen,
          page: () => AddBlockOrPhaseBuildingApartmentsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: localbuildingscreen,
          page: () => LocalBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: localbuildingfloorsscreen,
          page: () => LocalBuildingFloorsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addlocalbuildingfloors,
          page: () => AddLocalBuildingFloors(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: localbuildingapartmentscreen,
          page: () => LocalBuildingApartmentScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addlocalbuildingapartmentsscreen,
          page: () => AddLocalBuildingApartmentsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: structureType5HouseOrBuildingMiddlewareScreen,
          page: () => StructureType5HouseOrBuildingMiddlewareScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: apartmentresidentverification,
          page: () => ApartmentResidentVerification(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: localBuildingApartmentResidentVerification,
          page: () => LocalBuildingApartmentResidentVerification(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: generatesocietyapartmentbills,
          page: () => GenerateSocietyApartmentBills(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: generatedsocietyapartmentbills,
          page: () => GeneratedSocietyApartmentBills(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: residentialEmergencyScreen,
          page: () => ResidentialEmergencyScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: viewFinanceManager,
          page: () => ViewFinanceManager(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addFinanceManager,
          page: () => AddFinanceManager(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: updateFinanceManager,
          page: () => UpdateFinanceManagerDetails(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: visitorDetails,
          page: () => VisitoreDetailsScreen(),
          transition: Transition.noTransition),

      GetPage(
          name: voting,
          page: () => VotingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: createPoll,
          page: () => GeneratePoll(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: societyRule,
          page: () => AllSocietyRules(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addSocietyRule,
          page: () => AddSocietyRules(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addAndAssignparking,
          page: () => AddAndAssignParking(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: assignedParking,
          page: () => AssignedParking(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: visitorsLogs,
          page: () => VisitorsLogsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: showAllResident,
          page: () => AllResidentList(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: noInternetConnection,
          page: () => NoInternetConnectionScreen(),
          transition: Transition.noTransition),

      GetPage(
          name: blockedUser,
          page: () => BlockedUser(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: getAllLuggagePass,
          page: () => GetAllLuggagePassScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: domesticHelp,
          page: () => DomeasticHelpScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: allDomesticHelp,
          page: () => AllDomesticHelper(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: editMeasurment,
          page: () => EditMeasurementScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: shortTermRental,
          page: () => ShortTermRentalScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: allShortTermRental,
          page: () => AllShortTermRentalScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: rentSettlement,
          page: () => RentSettleMentScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: supportTicket,
          page: () => AllSupportsTickets(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: subadminList,
          page: () => const SubadminListScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: addSubadmin,
          page: () => const AddSubadminScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: updateSubadminBuilding,
          page: () => const UpdateSubadminBuildingScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),

      GetPage(
          name: updateSubadmin,
          page: () => const UpdateSubadminScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
    ];
  }
}

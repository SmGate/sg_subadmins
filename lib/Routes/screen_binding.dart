import 'package:get/get.dart';
import 'package:societyadminapp/Module/Add%20Event/Controller/add_event_controller.dart';
import 'package:societyadminapp/Module/Add%20Event/Controller/update_event_controller.dart';
import 'package:societyadminapp/Module/AddLocalBuildingDetail/AddLocalBuildingApartments/Controller/add_local_building_apartment_controller.dart';
import 'package:societyadminapp/Module/AddLocalBuildingDetail/AddLocalBuildingFloors/Controller/add_local_building_floors_controller.dart';
import 'package:societyadminapp/Module/AddLocalBuildingDetail/LocalBuildingApartments/Controller/local_building_apartment_controller.dart';
import 'package:societyadminapp/Module/AddLocalBuildingDetail/LocalBuildingFloors/Controller/local_building_floors_controller.dart';
import 'package:societyadminapp/Module/AddNoticeBoard/Controller/add_notice_board_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Houses/Controller/add_houses_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Phases/Controller/add_phases_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Add%20Streets/Controller/add_streets_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/AddBlockOrPhaseBuildingApartment/Controller/add_block_or_phase_building_floors_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/AddBlockOrPhaseBuildingFloor/Controller/add_block_or_phase_building_floors_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/AddSocietyBuildingApartment/Controller/add_society_building_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/AddSocietyBuildingFloors/Controller/add_society_building_floor_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/AddSocietyBuildings/Controller/add_socuety_buildings_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlockBuildingOrStreet/Controller/block_building_or_street_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlockOrPhaseBuilding/Controller/block_building_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlockOrPhaseBuildingApartment/Controller/block_or_phase_building_apartment_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlockOrPhaseBuildingFloor/Controller/block_or_phase_building_floor_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlockOrSocietyBuilding/Controller/block_or_society_building_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Blocks/Controller/block_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/BlocksOrBuildings/Controller/blocks_or_buildings_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/PhaseBuildingOrBlock/Controller/phase_building_or_block_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/PhaseOrSocietyBuilding/Controller/phase_or_society_building_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Phases/Controller/phases_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/SocietyBuildingFloor/Controller/society_building_floor_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/StreetOrBuilding/Controller/street_or_building_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/Streets/Controller/street_controller.dart';
import 'package:societyadminapp/Module/AddSocietyDetail/StructureType5HouseOrBuildingMiddleWare/Controller/structure_type5_house_or_building_controller.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/controller/blocked_user_controller.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/controller/moderation_controller.dart';
import 'package:societyadminapp/Module/Events/Controller/event_screen_controller.dart';
import 'package:societyadminapp/Module/GateKepeer/Controller/gate_keeper_controller.dart';
import 'package:societyadminapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:societyadminapp/Module/House%20Bills/Controller/generate_house_bill_controller.dart';
import 'package:societyadminapp/Module/House%20Bills/Controller/generated_house_bill_controller.dart';
import 'package:societyadminapp/Module/ImageHeroView/Controller/viewimage_controller.dart';
import 'package:societyadminapp/Module/Login/Controller/login_controller.dart';
import 'package:societyadminapp/Module/Measurements/Controller/measurement_view_controller.dart';
import 'package:societyadminapp/Module/Measurements/Controller/measurements_controller.dart';
import 'package:societyadminapp/Module/NoticeBoard/Controller/notice_board_controller.dart';
import 'package:societyadminapp/Module/Residental%20Emergency/Controller/residential_emergency_controller.dart';
import 'package:societyadminapp/Module/ShortTermRental/controller/short_term_rental_controller.dart';
import 'package:societyadminapp/Module/Society%20Apartment%20Bills/Controller/generate_society_apartment_bills_controller.dart';
import 'package:societyadminapp/Module/Society%20Apartment%20Bills/Controller/generated_society_apartment_bills_controller.dart';
import 'package:societyadminapp/Module/SocietyRules/controller/society_rule_controller.dart';
import 'package:societyadminapp/Module/Splash/View/splash_screen.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Controller/apartment_resident_verification_controller.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Controller/house_resident_verification_controller.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Controller/local_building_apartment_resident_verification_controller.dart';
import 'package:societyadminapp/Module/UnVerifiedResidents/Controller/unverified_resident_controller.dart';
import 'package:societyadminapp/Module/UpdateNoticeBoard/Controller/update_notice_controller.dart';
import 'package:societyadminapp/Module/Visitors%20Logs/controller/visitors_logs_controller.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Module/luggage_pass/controller/luggage_pass_controller.dart';
import 'package:societyadminapp/Module/parking%20managment/controller/parking_management_controller.dart';
import 'package:societyadminapp/Module/visitors_details/controller/visitor_details_controller.dart';
import 'package:societyadminapp/Module/voting/controller/voting_controller.dart';

import '../Module/AddGateKepeer/Controller/add_gate_kepeer_controller.dart';
import '../Module/AddLocalBuildingDetail/LocalBuilding/Controller/local_building_controller.dart';
import '../Module/AddSocietyDetail/Add Blocks/Controller/add_block_controller.dart';
import '../Module/AddSocietyDetail/AddBlockOrPhaseBuilding/Controller/add_block_building_controller.dart';
import '../Module/AddSocietyDetail/Houses/Controller/houses_controller.dart';
import '../Module/AddSocietyDetail/SocietyBuildingApartment/Controller/society_building_apartment_controller.dart';
import '../Module/AddSocietyDetail/SocietyBuildings/Controller/society_building_controller.dart';
import '../Module/AdminProfile/View/admin_profile_screen.dart';
import '../Module/Events/View/view_event_images_screen.dart';
import '../Module/Finance Manger/Add Finance Manager/View/add_finance_manager.dart';
import '../Module/Finance Manger/Update Finance Manager Details/View/update_finance_manager_details.dart';
import '../Module/Finance Manger/View Finance Manager/View/view_finance_manager.dart';
import '../Module/Report Notifications/Controller/notifications_controller.dart';
import '../Module/UpdateGateKeeper/Controller/update_gate_keeper_controller.dart';
import '../Module/View Residents/Controller/view_residents_controller.dart';
import '../Module/ViewReports/Controller/reported_resident_controller.dart';
import '../Module/ViewReports/Controller/resident_reports_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreen());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => ViewResidentController());

    Get.lazyPut(() => GateKeeperController());
    Get.lazyPut(() => AddGateKeeperScreenController());
    Get.lazyPut(() => UpdateGateKeeperController());
    Get.lazyPut(() => EventScreenController());
    Get.lazyPut(() => AddEventScreenController());
    Get.lazyPut(() => UpdateEventScreenController());
    Get.lazyPut(() => AdminProfileScreen());

    Get.lazyPut(() => NotificationsController());
    Get.lazyPut(() => ResidentsListController());
    Get.lazyPut(() => ResidentReportsController());
    Get.lazyPut(() => NoticeBoardController());
    Get.lazyPut(() => AddNoticeBoardScreenController());
    Get.lazyPut(() => ViewEventImages());
    Get.lazyPut(() => UpdateNoticeBoardController());
    Get.lazyPut(() => ViewImageController());
    Get.lazyPut(() => AddPhasesController());
    Get.lazyPut(() => PhasesController());
    Get.lazyPut(() => BlocksController());
    Get.lazyPut(() => AddBlockController());
    Get.lazyPut(() => StreetsController());
    Get.lazyPut(() => AddStreetsController());
    Get.lazyPut(() => AddHousesController());
    Get.lazyPut(() => HouseController());
    Get.lazyPut(() => UnVerifiedResidentController());

    Get.lazyPut(() => BlockOrBuildingController());
    Get.lazyPut(() => SocietyBuildingController());
    Get.lazyPut(() => AddSocietyBuildingController());
    Get.lazyPut(() => SocietyBuildingFloorsController());
    Get.lazyPut(() => AddSocietyBuildingFloorsController());
    Get.lazyPut(() => SocietyBuildingApartmentController());

    Get.lazyPut(() => AddSocietyBuildingApartmentsController());
    Get.lazyPut(() => AddMeasurementController());
    Get.lazyPut(() => MeasurementViewController());
    Get.lazyPut(() => HouseResidentVerificationController());
    Get.lazyPut(() => ApartmentResidentVerificationController());
    Get.lazyPut(() => GenerateHouseBillController());
    Get.lazyPut(() => GeneratedHouseBillController());
    Get.lazyPut(() => StreetOrBuildingController());
    Get.lazyPut(() => BlockOrSocietyBuildingController());

    Get.lazyPut(() => PhaseOrSocietyBuildingController());
    Get.lazyPut(() => BlockBuildingOrStreetController());
    Get.lazyPut(() => BlockBuildingController());

    Get.lazyPut(() => AddBlockBuildingController());
    Get.lazyPut(() => PhaseBuildingOrBlockController());
    Get.lazyPut(() => BlockOrPhaseBuildingFloorsController());
    Get.lazyPut(() => AAddBlockOrPhaseBuildingFloorsController());
    Get.lazyPut(() => BlockOrPhaseBuildingApartmentsController());

    Get.lazyPut(() => AddBlockOrPhaseBuildingApartmentsController());
    Get.lazyPut(() => LocalBuildingController());

    Get.lazyPut(() => LocalBuildingFloorsController());
    Get.lazyPut(() => AddLocalBuildingFloorsController());
    Get.lazyPut(() => LocalBuildingApartmentController());
    Get.lazyPut(() => AddLocalBuildingApartmentsController());

    Get.lazyPut(() => StructureType5HouseOrBuildingMiddlewareController());
    Get.lazyPut(() => LocalBuildingApartmentResidentVerificationController());

    Get.lazyPut(() => GenerateSocietyApartmentBillsController());
    Get.lazyPut(() => GeneratedSocietyApartmentBillsController());
    Get.lazyPut(() => ResidentialEmergencyController());
    Get.lazyPut(() => AddFinanceManager());
    Get.lazyPut(() => ViewFinanceManager());
    Get.lazyPut(() => UpdateFinanceManagerDetails());
    Get.lazyPut(() => VisitoreDetailsScreenController());
    Get.lazyPut(() => BlockedUserController());
    Get.lazyPut(() => VotingController());
    Get.lazyPut(() => SocietyRuleController());
    Get.lazyPut(() => ParkingManagementController());
    Get.lazyPut(() => ModerationController());
    Get.lazyPut(() => VisitorsLogsController());
    Get.lazyPut(() => LuggagePassController());
    Get.lazyPut(() => DomesticHelpCOntroller());
    Get.lazyPut(() => ShortTermRentalController());
  }
}

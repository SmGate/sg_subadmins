class Api {
  ////live
  static const String imageBaseUrl =
      'https://www.mobile-api.smartgate.pk/storage/';
  static const String baseUrl = 'https://www.mobile-api.smartgate.pk/api/';

  ////local

  // static const String imageBaseUrl =
  //     'https://www.stagging.smartgate.pk/storage/';
  // static const String baseUrl = 'https://www.stagging.smartgate.pk/api/';

  ///.   ===========================================
  static const String login = baseUrl + "login";
  static const String fcmTokenRefresh = baseUrl + "fcmtokenrefresh";
  static const String registerResident = baseUrl + "registerresident";
  static const String viewResidents = baseUrl + "viewresidents";
  static const String deleteResident = baseUrl + "deleteresident";
  static const String searchResidents = baseUrl + "searchresident";
  static const String updateResidents = baseUrl + "updateresident";
  static const String registerGatekeeper = baseUrl + "registergatekeeper";
  static const String viewGatekeepers = baseUrl + "viewgatekeepers";
  static const String deleteGatekeeper = baseUrl + "deletegatekeeper";
  static const String updateGatekeeper = baseUrl + "updategatekeeper";
  static const String addEventImages = baseUrl + "event/addeventimages";
  static const String addEvent = baseUrl + "event/addevent";
  static const String updateEvent = baseUrl + "event/updateevent";
  static const String events = baseUrl + "event/events";
  static const String searchEvent = baseUrl + "event/searchevent";
  static const String deleteEvent = baseUrl + "event/deleteevent";
  static const String addNoticeboardDetail = baseUrl + "addnoticeboarddetail";
  static const String viewAllNotices = baseUrl + "viewallnotices";
  static const String deleteNotice = baseUrl + "deletenotice";
  static const String updateNotice = baseUrl + "updatenotice";
  static const String reportedResidents = baseUrl + "reportedresidents";
  static const String reports = baseUrl + "reports";
  static const String getAllReports = baseUrl + "get-all-reports";
  static const String pendingReports = baseUrl + "pendingreports";
  static const String updateReportStatus = baseUrl + "updatereportstatus";
  static const String historyReportedResidents =
      baseUrl + "historyreportedresidents";
  static const String historyReports = baseUrl + "historyreports";
  static const String addPhases = baseUrl + "addphases";
  static const String addFloors = baseUrl + "addfloors";
  static const String phases = baseUrl + "phases";
  static const String floors = baseUrl + "floors";
  static const String blocks = baseUrl + "blocks";
  static const String apartments = baseUrl + "apartments";
  static const String streets = baseUrl + "streets";
  static const String addBlocks = baseUrl + "addblocks";
  static const String addApartments = baseUrl + "addapartments";
  static const String addStreets = baseUrl + "addstreets";
  static const String addProperties = baseUrl + "addproperties";
  static const String properties = baseUrl + "properties";
  static const String viewSociety = baseUrl + "society/viewsociety";
  static const String unVerifiedResident = baseUrl + "unverifiedresident";
  static const String unverifiedResidentCount =
      baseUrl + "unverifiedresidentcount";
  static const String emergencyCount = baseUrl + "emergencycount";
  static const String verifyResident = baseUrl + "verifyresident";
  static const String societyBuildings = baseUrl + "societybuildings";
  static const String getAllAdmins = baseUrl + "viewsubadmin";
  static const String addSocietyBuilding = baseUrl + "addsocietybuilding";
  static const String viewSocietyBuildingFloors =
      baseUrl + "viewsocietybuildingfloors";
  static const String addSocietyBuildingFloors =
      baseUrl + "addsocietybuildingfloors";
  static const String viewSocietyBuildingApartments =
      baseUrl + "viewsocietybuildingapartments";
  static const String addSocietyBuildingApartments =
      baseUrl + "addsocietybuildingapartments";
  static const String addMeasurement = baseUrl + "addmeasurement";
  static const String addFloorsUpdated = baseUrl + "addsocietybuildingfloors";
  static const String updateMeasurment = baseUrl + "updatemeasurement";
  static const String housesApartmentMeasurements =
      baseUrl + "housesapartmentmeasurements";
  static const String viewAllSocieties =
      baseUrl + "society/viewsocietiesforresidents";
  static const String viewAllPhases = baseUrl + "viewphasesforresidents";
  static const String viewAllBlocks = baseUrl + "viewblocksforresidents";
  static const String viewAllStreets = baseUrl + "viewstreetsforresidents";
  static const String viewPropertiesForResidents =
      baseUrl + "viewpropertiesforresidents";
  static const String viewSocietyApi = baseUrl + "society/viewsociety";

  static const String generateHouseBill = baseUrl + "generatehousebill";
  static const String generateSocietyApartmentBill =
      baseUrl + "generatesocietyapartmentbill";
  static const String generatedHouseBill = baseUrl + "generatedhousebill";
  static const String generatedSocietyApartmentBill =
      baseUrl + "generatedsocietyapartmentbill";

  static const String verifyHouseResident = baseUrl + "verifyhouseresident";
  static const String verifyApartmentResident =
      baseUrl + "verifyapartmentresident";
  static const String unverifiedApartmentResident =
      baseUrl + "unverifiedapartmentresident";
  static const String unverifiedHouseResident =
      baseUrl + "unverifiedhouseresident";
  static const String resetPassword = baseUrl + "resetpassword";
  static const String viewLocalBuildingFloors =
      baseUrl + "viewlocalbuildingfloors";
  static const String addLocalBuildingFloors =
      baseUrl + "addlocalbuildingfloors";
  static const String viewLocalBuildingApartments =
      baseUrl + "viewlocalbuildingapartments";
  static const String addLocalBuildingApartments =
      baseUrl + "addlocalbuildingapartments";
  static const String allSocietyBuildings = baseUrl + "allsocietybuildings";
  static const String verifyLocalBuildingApartmentResident =
      baseUrl + "verifylocalbuildingapartmentresident";
  static const String unverifiedLocalBuildingApartmentResident =
      baseUrl + "unverifiedlocalbuildingapartmentresident";

  static const String rejectVerification = baseUrl + "reject-verification";

  static const String viewEmergency = baseUrl + "viewEmergency";
  static const String pendingReportsCount = baseUrl + "pendingreportscount";
  static const String unVerifiedResidentCount =
      baseUrl + "unverifiedresidentcount";
  static const String inProgressReportsCount =
      baseUrl + "inprogressreportscount";
  static const String financeManagerRegister =
      baseUrl + "finance-manager/register";
  static const String financeManagerView = baseUrl + "finance-manager/view/";
  static const String financeManagerDelete =
      baseUrl + "finance-manager/delete/";
  static const String financeManagerUpdate =
      baseUrl + "finance-manager/update/";
  static const String getVisitorDetails = baseUrl + "getVisitors";
  static const String generatePoll = baseUrl + "create-poll";
  static const String getAllPoll = baseUrl + "all-polls";

  static const String getAllSocietyRule = baseUrl + "all-rules";
  static const String addSocietyRule = baseUrl + "create-rule";

  static const String createParking = baseUrl + "parkings/create";
  static const String getParkingSlots = baseUrl + "parking-lots";
  static const String assignParking = baseUrl + "assign-parking";
  static const String getVisitorsLogs = baseUrl + "society-visitors";
  static const String updateParking = baseUrl + "update-parking";
  static const String makeModerator = baseUrl + "make-moderators";
  static const String blockedResidents = baseUrl + "blocked-residents";
  static const String unblockResidents = baseUrl + "unblock-resident";

  static const String residentDetails = baseUrl + "resident-details";

  static const String getAllLuggagePass = baseUrl + "all-laguage-pass";

  static const String approvedLuggagePass = baseUrl + "approve-laguage-pass";
  static const String deleteAccount = baseUrl + "delete-account";
  static const String addShortTermRental = baseUrl + "short-term-booking";
  static const String getSocietyBuildings = baseUrl + "get-society-buildings";

  static const String getBuildingsFloor =
      baseUrl + "get-society-building-floors";

  static const String getAllFoors = baseUrl + "get-floors";

  static const String getBuildingApartments =
      baseUrl + "get-society-building-appartments";
  static const String getAllShortTermRental = baseUrl + "short-term-booking";
  static const String rentSettlement = baseUrl + "add-rent-settlement";

  // ===============  DOMESTIC HELPER
  static const String registerDomesticHelper = baseUrl + "register-worker";
  static const String getAllWorkers = baseUrl + "all-workers";
  static const String updateDomesticHelper = baseUrl + "update-worker";
  static const String deleteDomesticHelper = baseUrl + "delete-worker";
  static const String domesticHelperProfile = baseUrl + "worker-profile";
  static const String allBookings = baseUrl + "all-booking";

  static const String getAllTickets = baseUrl + "get-all-tickets";
  static const String updateTickets = baseUrl + "owner-tickets/update";
}

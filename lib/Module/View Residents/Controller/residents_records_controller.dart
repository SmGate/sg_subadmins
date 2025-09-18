import 'package:get/get.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_bills_model.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_complaint_model.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/resident_emergency_model.dart';
import 'package:societyadminapp/Module/View%20Residents/service/resident_records_service.dart';

class ResidentRecordController extends GetxController {
  RxString errorGettingAllEmergencieseRecord = "".obs;
  RxString errorGettingAllComplaintsRecord = "".obs;
  RxString errorGettingAllBillsRecord = "".obs;

  var allEmergencieseModel = ResidentEmergencyModel();
  var allComplaintModel = ResidentComplaintModel();
  var allBillsModel = ResidentBillsModel();

  RxString complaintSearchValue = "".obs;
  RxString billsSearchValue = "".obs;
  RxString emergencieseSearchValue = "".obs;
  Future<ResidentComplaintModel> getAllComplaint(
      {String? residetId, String? startDate, String? endDate}) async {
    errorGettingAllComplaintsRecord.value = "";

    var res = await ResidentRecordsService.getAllResidenComplaint(
        residetId: residetId, startDate: startDate, endDate: endDate);

    if (res is ResidentComplaintModel) {
      allComplaintModel = res;
      return allComplaintModel;
    } else {
      errorGettingAllComplaintsRecord.value = res.toString();
      Get.snackbar("Error", errorGettingAllComplaintsRecord.value);
    }

    return allComplaintModel;
  }

  Future<ResidentEmergencyModel> getAllEmergency(
      {String? residetId, String? startDate, String? endDate}) async {
    errorGettingAllEmergencieseRecord.value = "";

    var res = await ResidentRecordsService.getAllResidentEmergenciese(
        residetId: residetId, startDate: startDate, endDate: endDate);

    if (res is ResidentEmergencyModel) {
      allEmergencieseModel = res;
      return allEmergencieseModel;
    } else {
      errorGettingAllEmergencieseRecord.value = res.toString();
      Get.snackbar("Error", errorGettingAllEmergencieseRecord.value);
    }

    return allEmergencieseModel;
  }

  Future<ResidentBillsModel> getAllBills(
      {String? residetId, String? startDate, String? endDate}) async {
    errorGettingAllBillsRecord.value = "";

    var res = await ResidentRecordsService.getAllResidentBills(
        residetId: residetId, startDate: startDate, endDate: endDate);

    if (res is ResidentBillsModel) {
      allBillsModel = res;
      return allBillsModel;
    } else {
      errorGettingAllBillsRecord.value = res.toString();
      Get.snackbar("Error", errorGettingAllBillsRecord.value);
    }

    return allBillsModel;
  }
}

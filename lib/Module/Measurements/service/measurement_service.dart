import 'package:http/http.dart' as http;
import 'package:societyadminapp/Module/Measurements/Model/add_measurment_model.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/base_client.dart';

class MeasurementService {
  static Future<dynamic> addMeasurement({
    String? userId,
    String? type,
    String? category,
    String? monthlyRent,
    String? annualIncrement,
    String? societyId,
    String? societyBuildingId,
    String? societyBuildingFloorId,
    String? societyBuildingApartmentId,
    String? apartmentType,
    String? unitType,
    String? charges,
    String? area,
    String? lateCharges,
    String? appCharges,
    String? tax,
  }) async {
    try {
      var url = Api.addMeasurement;

      // Prepare the request body
      Map<String, dynamic> body = {
        "subadminid": userId,
        "type": type,
        "category": category,
        "society_id": societyId,
        "societybuilding_id": societyBuildingId,
        "societybuildingfloor_id": societyBuildingFloorId,
        "societybuildingapartment_id": societyBuildingApartmentId,
        "appartment_type": apartmentType,
        "unit": unitType,
        "charges": charges,
        "area": area,
        "status": 0,
        "latecharges": lateCharges,
        "appcharges": double.tryParse(appCharges ?? ""),
        "tax": tax,
      };

      // Make POST request
      var res = await BaseClientClass.post(url, body);

      if (res is http.Response) {
        return addMeasurementFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

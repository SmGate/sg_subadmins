import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/SocietyBuildingApartment.dart';

class SocietyBuildingApartmentController extends GetxController {
  var data = Get.arguments;
  int? fid;
  int? bid;
  int apiCount = 0;

  late final User user;

  @override
  void onInit() {
    super.onInit();

    user = data[0];
    fid = data[1];
    bid = data[2];
  }

  Future<SocietyBuildingApartment> SocietyBuildingApartmentsApi(
      {required int fid, required String bearerToken}) async {
    print('api count Apartment Screen ${apiCount++}');
    print("${fid.toString()}");
    print(bearerToken);

    final response = await Http.get(
      Uri.parse(Api.viewSocietyBuildingApartments + "/" + fid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $bearerToken"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      return SocietyBuildingApartment.fromJson(data);
    }

    return SocietyBuildingApartment.fromJson(data);
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';

import '../Model/BlockOrPhaseBuildingApartment.dart';

class BlockOrPhaseBuildingApartmentsController extends GetxController {
  var data = Get.arguments;
  int? fid;
  int? bid;
  int? dynamicid;

  late final User user;

  @override
  void onInit() {
    super.onInit();

    user = data[0];
    fid = data[1];
    bid = data[2];
    dynamicid = data[3];
  }

  Future<BlockOrPhaseBuildingApartment> SocietyBuildingApartmentsApi(
      {required int fid, required String bearerToken}) async {
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
      return BlockOrPhaseBuildingApartment.fromJson(data);
    }

    return BlockOrPhaseBuildingApartment.fromJson(data);
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/Events/Model/Event.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Model/User.dart';

class EventScreenController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  var user = Get.arguments;
  bool isSearch = false;
  late Future data;
  late final User userdata;
  String eventVal = 'Default';
  var eventDropDownList = ['Newest', 'Oldest', 'Default'];

  @override
  void onInit() {
    super.onInit();

    userdata = user;
    print(userdata);
    data = viewEventsApi(
        userid: userdata.userid!,
        token: userdata.bearerToken!,
        societyId: userdata.societyid.toString());
  }

  setEventVal(val) {
    eventVal = val;
    update();
  }

  Future<Event> viewEventsApi(
      {required int userid,
      required String token,
      required String societyId}) async {
    print("${userid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(
          Api.events + "/" + userid.toString() + "/" + societyId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Event.fromJson(data);
    }

    return Event.fromJson(data);
  }

  Future<Event> searchEventsApi(
      {required int userid,
      required String token,
      required String query}) async {
    print("${userid.toString()}");
    print(token);
    print(query);

    isSearch = true;
    final response = await Http.get(
      Uri.parse(Api.searchEvent + "/" + userid.toString() + "/" + query),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    print(response.statusCode);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      isSearch = false;
      update();
      return Event.fromJson(data);
    }

    return Event.fromJson(data);
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
// selectedImages!.clear();

    if (selectedImages!.isNotEmpty) {
      print(selectedImages);

      Map<String, String> headers = {
        "Authorization": "Bearer 6|PY7c88dIPMxkyIT34ZzhYFtEhOhY7nVzDGu1xLpF"
      };

      var request =
          Http.MultipartRequest('POST', Uri.parse(Api.addEventImages));
      request.headers.addAll(headers);

      for (int i = 0; i < selectedImages.length; i++) {
        request.files.add(
            await Http.MultipartFile.fromPath('image', selectedImages[i].path));
        request.fields['eventid'] = 5.toString();
      }
      var responsed = await request.send();
      var response = await Http.Response.fromStream(responsed);
      print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        // print(response.body);
        Get.snackbar("Images", 'Images Add Successfully');
      }
    }
    update();
  }

  Future deleteEventApi(int eventid, String token) async {
    print(eventid.toString());
    print(token);

    final response = await Http.get(
      Uri.parse(Api.deleteEvent + "/" + eventid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());
    var mydata = data['data'];

    print('my data.......$mydata');

    if (response.statusCode == 200) {
      this.data = viewEventsApi(
          userid: userdata.userid!,
          token: userdata.bearerToken!,
          societyId: userdata.societyid.toString());
      Get.back();
      update();
    }
    update();
  }
}

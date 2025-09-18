import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import '../../../Model/User.dart';

class AddEventScreenController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  bool isLoading = false;
  File? imageFile;

  @override
  void onInit() {
    super.onInit();
    userdata = this.user;
  }

  final formKey = new GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  int eventActive = 0;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String? startTime;
  String? endTime;
  Future selectStartTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('time.$picked');
    var currentTime =
        '${picked?.hour.toString().padLeft(2, '0')}:${picked?.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    startTime = currentTime.toString().split(' ')[0].trim();
    startTimeController.text =
        formatTimeToAMPM(currentTime.toString().split(' ')[0].trim());

    update();
  }

  Future selectEndTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    endTime = currentTime.toString().split(' ')[0].trim();
    endTimeController.text =
        formatTimeToAMPM(currentTime.toString().split(' ')[0].trim());

    update();
  }

  Future StartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) picked.toString();

    eventStartDateController.text = await picked.toString().split(' ')[0];
    eventEndDateController.text = await picked.toString().split(' ')[0];
    update();
  }

  Future EndDate(context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: new DateTime(2030));
    if (picked != null) picked.toString();

    eventEndDateController.text = picked.toString().split(' ')[0];

    update();
  }

//////

  Future<void> addEvent({
    required File file,
    required int userid,
    required String token,
    required String eventTitle,
    required String eventDescription,
    required String eventStartDate,
    required String eventEndDate,
    required String startTime,
    required String endTime,
  }) async {
    isLoading =
        true; // Assuming you have a variable named isLoading to manage loading state
    update(); // Assuming you have a method named update() to update the UI

    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      var request = Http.MultipartRequest('POST', Uri.parse(Api.addEvent));
      request.headers.addAll(headers);

      request.files.add(await Http.MultipartFile.fromPath('image', file.path));
      request.fields['userid'] = userid.toString();
      request.fields['title'] = eventTitle;
      request.fields['description'] = eventDescription;
      request.fields['startdate'] = eventStartDate;
      request.fields['enddate'] = eventEndDate;
      request.fields['starttime'] = startTime;
      request.fields['endtime'] = endTime;
      request.fields['active'] = "1";

      var responsed = await request.send();
      var response = await Http.Response.fromStream(responsed);

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        eventDescriptionController.clear();
        eventTitleController.clear();
        eventStartDateController.clear();
        eventEndDateController.clear();
        startTimeController.clear();
        endTimeController.clear();

        Get.offNamed(eventsscreen, arguments: user);
        print(data);
        print(response.body);
        myToast(msg: 'Event Added Successfully');
      } else if (response.statusCode == 403) {
        var data = jsonDecode(response.body.toString());
        myToast(msg: 'Error: ${data.toString()}');
      } else {
        myToast(msg: 'Failed to Register');
      }
    } catch (e) {
      print('Error: $e');
      myToast(msg: e);
    } finally {
      isLoading = false;
      update();
    }
  }

  //////
  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      print('file picked: $pickedFile');

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    }
  }

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');
      // img = pickedFile as Image?;

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/Widgets/my_button.dart';

import '../../../../utils/Constants/api_routes.dart';
import '../../../../Model/User.dart';
import '../../../../Routes/set_routes.dart';

class AddFinanceManagerController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  var isHidden = false;
  var isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imageFile;

  var arguments = Get.arguments;
  late final User user;
  @override
  void onInit() {
    super.onInit();
    user = arguments;
  }

  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
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

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  financeManagerRegisterApi(
      {required firstName,
      required lastName,
      required cnic,
      required address,
      required mobileNo,
      required password,
      required int societyid,
      required int subAdminId,
      required int superAdminId,
      required String token,
      required BuildContext context,
      File? file}) async {
    isLoading = true;
    update();
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var request =
        Http.MultipartRequest('POST', Uri.parse(Api.financeManagerRegister));
    request.headers.addAll(headers);
    if (file != null) {
      request.files.add(await Http.MultipartFile.fromPath('image', file.path));
    }
    request.fields['firstname'] = firstName;
    request.fields['lastname'] = lastName;
    request.fields['cnic'] = cnic;
    request.fields['email'] = address;
    request.fields['mobileno'] = mobileNo;
    request.fields['roleid'] = 6.toString();
    request.fields['rolename'] = 'financemanager';
    request.fields['password'] = password;
    request.fields['superadminid'] = superAdminId.toString();
    request.fields['subadminid'] = subAdminId.toString();
    request.fields['societyid'] = societyid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body.toString());
      print(data);
      print(response.body);
      myToast(msg: ' Registration Successfully.');
      Get.offNamed(viewFinanceManager, arguments: user);
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body.toString());
      var errorList = data['errors'] as List;

      for (int i = 0; i < errorList.length; i++) {
        myToast(msg: 'Operation Failed.${errorList[i]}');
        clearText();
      }
    } else if (response.statusCode == 500) {
      isLoading = false;
      update();
      myToast(msg: 'Sever Error');

      clearText();
    } else {
      myToast(msg: 'Something Went Wrong.');

      clearText();
    }
  }

  clearText() {
    firstNameController.clear();
    lastNameController.clear();
    cnicController.clear();
    passwordController.clear();
    imageFile = null;
    mobileNoController.clear();
    addressController.clear();
    update();
  }

  void showDialogBox(BuildContext context, {required title, required data}) {
    Get.defaultDialog(
        title: title,
        titleStyle: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: HexColor('#4D4D4D')),
        content: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              data,
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: HexColor('#DC3545')),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
              onPressed: () {
                Get.back();
              },
              name: 'OK',
              width: 100,
              height: 30,
            ),
          ],
        ));
  }
}

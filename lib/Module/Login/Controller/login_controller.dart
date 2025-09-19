import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:societyadminapp/Module/Login/Model/delete_user_account_model.dart';
import 'package:societyadminapp/Module/Login/service/auth_service.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../../Model/User.dart';
import '../../../utils/Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../Model/SocietyModel.dart';

class LoginController extends GetxController {
  var isHidden = false;
  TextEditingController userCnicController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  bool loading = false;

  Future<void> loginApi(String cnic, String password) async {
    print("Login Api Functions Hit!");
    print("=========");
    print(cnic);
    print(password);
    print("=========");

    loading = true;
    update();

    // Small helper to show errors consistently
    void showError(String title, String message) {
      Get.snackbar(title, message, backgroundColor: AppColors.background);
    }

    try {
      final uri = Uri.parse(Api.login);

      final response = await Http.post(
        uri,
        headers: const <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 25)); // avoid hanging forever

      print("Login Api Hits Successfully !");
      print(response.statusCode);
      print(response.body);

      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (_) {
        // Body wasn’t valid JSON
        showError('Unexpected Response', 'Server returned invalid data.');
        return;
      }

      // Convenience getters with null safety
      final dynamic dataObj = data['data'];
      final String? bearer = data['Bearer'] as String?;
      final String roleName = (dataObj is Map && dataObj['rolename'] is String)
          ? (dataObj['rolename'] as String)
          : '';

      if (response.statusCode == 200 && roleName == 'subadmin') {
        // Extract required fields safely
        final int? societyId =
            (dataObj is Map) ? dataObj['societyid'] as int? : null;
        if (societyId == null || bearer == null) {
          showError('Login Failed',
              'Missing required server data. Please try again.');
          return;
        }

        final SocietyModel? societyModel =
            await viewSocietyApi(societyId, bearer);

        final User user = User(
          structureType: societyModel?.structuretype,
          societyorbuildingname: societyModel?.name,
          userid: (dataObj as Map)['subadminid'],
          firstName: dataObj['firstname'],
          lastName: dataObj['lastname'],
          address: dataObj['address'],
          mobileno: dataObj['mobileno'],
          cnic: dataObj['cnic'],
          roleId: dataObj['roleid'],
          roleName: dataObj['rolename'],
          image: dataObj['image'],
          created_at: dataObj['created_at'],
          updated_at: dataObj['updated_at'],
          fcmtoken: dataObj['fcmtoken'],
          societyid: dataObj['societyid'],
          subadminid: dataObj['subadminid'],
          superadminid: dataObj['superadminid'],
          isMainAdmin: (dataObj['is_main_admin'] is int)
              ? dataObj['is_main_admin'] as int
              : (dataObj['is_main_admin'] is bool)
                  ? ((dataObj['is_main_admin'] as bool) ? 1 : 0)
                  : int.tryParse('${dataObj['is_main_admin']}'),
          bearerToken: bearer,
          permissions: data['permissions'],
        );

        MySharedPreferences.setUserData(user: user);
        SessionController().user = user;

        // FCM token refresh (safe)
        try {
          final token = await FirebaseMessaging.instance.getToken();
          print('Firebase token');
          print('--------');
          print(token);
          if (token != null &&
              user.userid != null &&
              user.bearerToken != null) {
            await fcmtokenrefresh(user.userid!, token, user.bearerToken!);
          }
        } catch (e) {
          // Don’t fail login if FCM update fails
          print('FCM token update failed: $e');
        }

        Get.offAndToNamed(homescreen, arguments: user);
        Get.snackbar(
          "Login Successfully",
          "Welcome 😉 ${user.firstName ?? ''} ${user.lastName ?? ''}",
          backgroundColor: AppColors.background,
        );
        return; // success path ends here
      }

      // 200 but not subadmin
      if (response.statusCode == 200 && roleName != 'subadmin') {
        showError("Login Failed",
            'You are not registered in our system. Contact Admin!');
        return;
      }

      // 401 — Unauthorized
      if (response.statusCode == 401) {
        showError('Unauthorized', 'Invalid CNIC or Password');
        return;
      }

      // 403 — Validation messages
      if (response.statusCode == 403) {
        final errors =
            (data['errors'] is List) ? (data['errors'] as List) : const [];
        if (errors.contains('The cnic field is required.')) {
          showError('Error Message', 'CNIC Required');
          return;
        }
        if (errors.contains('The password field is required.')) {
          showError('Error Message', 'Password Required');
          return;
        }
        // Other 403
        showError(
            'Forbidden', 'You do not have permission to perform this action.');
        return;
      }

      // Any other non-OK status
      showError(
          'Server Error', '(${response.statusCode}) Please try again later.');
    } on SocketException {
      showError('Network Error', 'No Internet connection.');
    } on TimeoutException {
      showError(
          'Network Timeout', 'The request took too long. Please try again.');
    } catch (e) {
      showError('Error', e.toString());
    } finally {
      // GUARANTEE loading stops no matter what
      loading = false;
      update();
    }
  }

  Future fcmtokenrefresh(int id, String fcmtoken, String bearertoken) async {
    print("Fcm token refresh Api   Hits ! ");

    try {
      final response = await Http.post(
        Uri.parse(Api.fcmTokenRefresh),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $bearertoken"
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'fcmtoken': fcmtoken,
        }),
      );
      print("Fcm token refresh Api Hits Successfully !");
      print(response.statusCode);
      print(response.body);
      var data = jsonDecode(response.body);

      print(data);
    } catch (SocketException) {
      Get.snackbar('Error Message', 'No Internet Connection');
    }
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  // viewSocietyApi(int societyid, String token) async {
  //   final response = await Http.get(
  //     Uri.parse(Api.viewSocietyApi + "/" + societyid.toString()),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': "Bearer $token"
  //     },
  //   );
  //   var data = jsonDecode(response.body.toString());
  //   var mydata = data['data'];

  //   if (response.statusCode == 200) {
  //     for (var e in mydata) {
  //       return SocietyModel(
  //           id: e['id'],
  //           name: e['name'],
  //           address: e['address'],
  //           country: e['country'],
  //           state: e['state'],
  //           city: e['city'],
  //           type: e['type'],
  //           area: e['area'],
  //           structuretype: e['structuretype'],
  //           superadminid: e['superadminid']);
  //     }
  //   } else {}
  // }

  Future<SocietyModel?> viewSocietyApi(int societyid, String token) async {
    final response = await Http.get(
      Uri.parse(Api.viewSocietyApi + "/" + societyid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var mydata = data['data'];

      // Check if 'mydata' is a List or a Map
      if (mydata is List) {
        // If mydata is a List, iterate over it
        for (var e in mydata) {
          return SocietyModel(
            id: e['id'],
            name: e['name'],
            address: e['address'],
            country: e['country'],
            state: e['state'],
            city: e['city'],
            type: e['type'],
            area: e['area'],
            structuretype: e['structuretype'],
            superadminid: e['superadminid'],
          );
        }
      } else if (mydata is Map) {
        // If mydata is a Map, return the SocietyModel directly
        return SocietyModel(
          id: mydata['id'],
          name: mydata['name'],
          address: mydata['address'],
          country: mydata['country'],
          state: mydata['state'],
          city: mydata['city'],
          type: mydata['type'],
          area: mydata['area'],
          structuretype: mydata['structuretype'],
          superadminid: mydata['superadminid'],
        );
      }
    } else {
      print(
          'Failed to load society data with status code: ${response.statusCode}');
    }
    return null;
  }

  ///  DELETE ACCOUNT
  RxBool deletingAccount = false.obs;
  RxString errorDeletingAccount = "".obs;
  var deletingAccountModel = DeleteAccountModel();

  void deleteAccount({String? userId}) async {
    deletingAccount.value = true;
    errorDeletingAccount.value = "";

    var res = await AuthService.deleteUserAccount(userId: userId);

    deletingAccount.value = false;
    if (res is DeleteAccountModel) {
      deletingAccountModel = res;
      Get.back();
      Get.snackbar("Message", deletingAccountModel.message ?? "");

      Get.offAllNamed(login);
    } else {
      errorDeletingAccount.value = res.toString();
      deletingAccount.value = false;
      Get.snackbar("Error", errorDeletingAccount.value);
    }
  }
}

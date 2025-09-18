import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Services/Shared%20Preferences/MySharedPreferences.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/Constants/session_controller.dart';
import '../../../../Model/User.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasInternetConnection = true;
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void getUserSharedPreferencesData() async {
    User user = await MySharedPreferences.getUserData();
    SessionController().user = user;
    print(user.bearerToken);
    if (user.bearerToken == "") {
      Timer(Duration(seconds: 3), () => Get.offAndToNamed(login));
    } else {
      Timer(Duration(seconds: 3),
          () => Get.offAndToNamed(homescreen, arguments: user));
    }
  }

  void _checkInternetConnection() async {
    print("is this function call");
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
        Get.offNamed(
          noInternetConnection,
        );
      });
    } else {
      setState(() {
        hasInternetConnection = true;
      });

      getUserSharedPreferencesData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Image.asset(
        AppImages.splash,
        width: double.infinity,
        fit: BoxFit.cover,
      )),
    );
  }
}

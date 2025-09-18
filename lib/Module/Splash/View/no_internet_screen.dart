import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetConnectionScreen> createState() =>
      _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState
    extends State<NoInternetConnectionScreen> {
  late Connectivity _connectivity;
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;

    // Listen for changes in the connectivity status
    _connectivityStream.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        Get.snackbar(
          "Internet Restored",
          "You're back online!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.appThem,
          colorText: Colors.white,
        );

        Future.delayed(Duration(seconds: 2), () {
          Get.offNamed(splashscreen);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100.0,
                color: Colors.grey[400],
              ),
              SizedBox(height: 20),
              Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Please check your internet connection and try again.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              MyButton(
                gradient: AppGradients.buttonGradient,
                name: "Retry",
                onPressed: () {
                  Get.offNamed(splashscreen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

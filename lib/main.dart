import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Routes/route_managment.dart';
import 'Routes/screen_binding.dart';
import 'Routes/set_routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.notification?.title}");
  print("Handling a background message: ${message.notification?.body}");

  // Check for notification type in custom data (if present)
  String notificationType = message.data['type'] ?? 'No type specified';
  print("Notification Type: $notificationType");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Intl date symbols for the default locale
  try {
    Intl.defaultLocale = Intl.defaultLocale ?? 'en_US';
    await initializeDateFormatting(Intl.defaultLocale);
  } catch (_) {}
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCDmrShxv0r-kUBDpA1bC_vjcmRwv_6jGE",
            appId: "1:1085340446333:ios:02b087e2690caaaa180b14",
            messagingSenderId: "1085340446333",
            projectId: "smart-ga"));
  } else {
    await Firebase.initializeApp();
  }

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'high_importance_channel',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Popup Notification',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  );
  print(result);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(375, 812),
        builder: (ctx, child) {
          ScreenUtil.init(ctx);
          return GetMaterialApp(
            initialRoute: splashscreen,
            getPages: RouteManagement.getPages(),
            initialBinding: ScreenBindings(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
          );
        });
  }
}

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../Model/User.dart';
import '../../Routes/set_routes.dart';
import '../Shared Preferences/MySharedPreferences.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initFlutterNotificationPlugin(RemoteMessage message) async {
    var androidInitialization =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializeSetting =
        InitializationSettings(android: androidInitialization);

    await flutterLocalNotificationsPlugin.initialize(initializeSetting,
        onDidReceiveNotificationResponse: (payload) async {
      handleMessages(message);
    });
  }

  fireBaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      initFlutterNotificationPlugin(message);
      showNotificationFlutter(message);
    });
  }

  Future<void> showNotificationFlutter(RemoteMessage message) async {
    print("Notification Type: ${message.data['type']}");

    String channelId = message.data['type'] ?? "default_channel";
    String channelName = channelId;
    String notificationSound =
        (message.data['type'] == 'Emergency') ? 'emergency' : 'notisound';

    print("Notification Sound: $notificationSound");

    // Initialize notification channel only once if it doesn't exist
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      channelId,
      channelName,
      description: "smart-gate-notification",
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound(notificationSound),
      playSound: true,
    );

    // Resolve platform-specific implementation for Android
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // Check if channel exists, if not create it
    await androidImplementation
        ?.createNotificationChannel(androidNotificationChannel);

    // Update notification sound if the channel already exists
    androidNotificationChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: "smart-gate-notification",
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound(notificationSound),
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: androidNotificationChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound(notificationSound),
      playSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> requestNotification() async {
    // 1) Check current status first to avoid nag loops / auto-redirects
    final current = await firebaseMessaging.getNotificationSettings();

    // Treat both authorized and provisional as OK (no redirect)
    if (current.authorizationStatus == AuthorizationStatus.authorized ||
        current.authorizationStatus == AuthorizationStatus.provisional) {
      // permission already fine — do nothing
      return;
    }

    // 2) If not determined, show the *standard* iOS prompt exactly once
    if (current.authorizationStatus == AuthorizationStatus.notDetermined) {
      final res = await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        // Keep these OFF for a normal prompt; provisional == quiet notifications
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false, // <-- important: do NOT ask provisional here
      );

      // If the user allowed (authorized/provisional), we're done.
      if (res.authorizationStatus == AuthorizationStatus.authorized ||
          res.authorizationStatus == AuthorizationStatus.provisional) {
        return;
      }

      // If they denied, offer Settings via an explicit, user-initiated action.
      _promptToOpenSettingsIfDenied();
      return;
    }

    // 3) If explicitly denied, *do not* auto-open Settings. Ask politely.
    if (current.authorizationStatus == AuthorizationStatus.denied) {
      _promptToOpenSettingsIfDenied();
      return;
    }

    // (Optional) iOS App Clip / ephemeral etc. — do nothing special
  }

  // Put this near the top of the class (e.g., under fields)
  static bool _hasPromptedForSettings = false;

  void _promptToOpenSettingsIfDenied() {
    if (_hasPromptedForSettings) return;
    _hasPromptedForSettings = true;

    Get.dialog(
      AlertDialog(
        title: const Text('Enable Notifications'),
        content: const Text(
          'Notifications are currently off. You can enable alerts in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Not now'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              try {
                // iOS 16+: open straight to notification settings if supported
                await AppSettings.openAppSettings(
                    type: AppSettingsType.notification);
              } catch (_) {
                // Fallback: open app settings
                await AppSettings.openAppSettings();
              }
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future<String?> getDeviceToken() async {
    String? deviceToken = await firebaseMessaging.getToken();

    return deviceToken;
  }

  refreshDeviceToken() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      handleMessages(message);
    }

    // when app is running in background then this function is call
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessages(event);
    });
  }

  handleMessages(RemoteMessage message) async {
    print("Notification Type is ${message.data['type']}");
    User user = await MySharedPreferences.getUserData();

    if (message.data['type'] == 'ReportNotification') {
      Get.toNamed(reportnotificationsscreen, arguments: user);
    } else if (message.data['type'] == 'Emergency') {
      Get.toNamed(residentialEmergencyScreen, arguments: user);
    } else if (message.data['type'] == 'Report') {
      Get.toNamed(viewreportscreen, arguments: user);
    } else if (message.data['type'] == 'Verification') {
      Get.toNamed(unverifiedresident, arguments: user);
    } else if (message.data['type'] == 'luggage-pass') {
      Get.toNamed(getAllLuggagePass, arguments: user);
    } else if (message.data['type'] == 'new-Worker-booking') {
      Get.offNamed(allDomesticHelp, arguments: user);
    } else if (message.data['type'] == 'booking-completed') {
      Get.offNamed(allDomesticHelp, arguments: user);
    } else if (message.data['type'] == 'Support Ticket') {
      Get.offNamed(supportTicket, arguments: user);
    }
  }
}

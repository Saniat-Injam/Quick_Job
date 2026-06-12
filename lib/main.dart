import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_job/core/services/notification_servies/firebase_messageing_servies.dart';
import 'package:quick_job/core/services/notification_servies/local_notification.dart';
import 'package:quick_job/firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'app.dart';
import 'core/services/auth_service.dart';
import 'core/utils/logging/loggerformain.dart';

// ----------------------
// LOCAL NOTIFICATION PLUGIN
// ----------------------
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// ----------------------
// BACKGROUND HANDLER
// MUST BE TOP LEVEL
// ----------------------
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("🔵 BACKGROUND MESSAGE: ${message.notification?.title}");

  await showCustomNotification(message);
}

// ----------------------
// SHOW CUSTOM NOTIFICATION (foreground + bg)
// ----------------------
Future<void> showCustomNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    "your_channel_id",
    "Your Channel Name",
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    playSound: true,
    sound: RawResourceAndroidNotificationSound('custom_sound'),
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    message.notification?.title ?? "New Notification",
    message.notification?.body ?? "",
    platformDetails,
  );
}

// ----------------------
// MAIN
// ----------------------

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  // Load environment
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Stripe.publishableKey = publishableKey;
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY'] ?? "";
  log("publish key id : ${dotenv.env['PUBLISHABLE_KEY']}");
  // Stripe.instance.applySettings();

  // Auth
  await AuthService.init();

  // GetStorage
  await GetStorage.init();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize Local Notification Service
  final localNotificationService = LocalNotificationService.instance();

  await localNotificationService.init();

  /// Initialize Firebase Messaging Service
  final firebaseMessagingService = FirebaseMessagingService.instance();
  await firebaseMessagingService.init(
    localNotificationService: localNotificationService,
  );
  //===========================

  // Notification setup
  // await initializeLocalNotifications();

  // Handle background messages
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Lock orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  runApp(MyApp(navigatorKey: navigatorKey));

  // Setup foreground message handling
  setupFCMListeners();
}

// ----------------------
// INIT LOCAL NOTIFICATIONS
// ----------------------
Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInit,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

// ----------------------
// FCM LISTENERS
// ----------------------
void setupFCMListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🟢 FOREGROUND MESSAGE: ${message.notification?.title}");
    showCustomNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("🟡 Notification clicked (App opened)");
  });
}

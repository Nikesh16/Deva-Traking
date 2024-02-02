import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:open_filex/open_filex.dart';

import '../../view_model/utils/colors.dart';

void onDidReceiveNotificationResponse(
  NotificationResponse notificationResponse,
) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
    OpenFilex.open(payload);
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'swadhin_id',
    'swadhin',
    description: 'This is Nepal\'s first freelancing application',
    importance: Importance.high,
    enableLights: true,
    ledColor: AppColor.primary,
    enableVibration: true,
    showBadge: true,
    playSound: true,
  );

//background message handler
  static Future<dynamic> handleBackgroundMessage(RemoteMessage message) async {
    log("on Background ${message.notification?.title}");
    log("on Background Body${message.notification?.body}");
    log("on Background Data${message.data}");
  }

  final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // await getFcmToken();
    // refreshFcmToken();
    initPushNotifications();
    initLocalNotifications();
  }

  Future<void> showNotification(String path) async {
    await _localNotificationPlugin.show(
        0,
        'File Downloaded',
        'Success',
        NotificationDetails(
            android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: 'logo',
        )),
        payload: path);
  }

  //handle Message
  void handleMessage(RemoteMessage? message) {
    log("$message");

//push to new screen
    // Get.toNamed(SplashScreen.id);
  }

  //push notification for ios
  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //handle notification for background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    //handle notification for foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: 'logo',
          )),
          payload: jsonEncode(message.toMap()));
    });
  }

  //init local notificarions.
  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('logo');
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotificationPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _localNotificationPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      if (notificationAppLaunchDetails?.notificationResponse?.payload != null) {
        final message = RemoteMessage.fromMap(jsonDecode(
            notificationAppLaunchDetails!.notificationResponse!.payload!));
        handleMessage(message);
      } else {
        // show tost
        // showBotToast(text: 'Error in navigation', isError: true);
      }
    }

    final platform =
        _localNotificationPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final iosPlatform =
        _localNotificationPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
    await iosPlatform?.getActiveNotifications();
  }
}

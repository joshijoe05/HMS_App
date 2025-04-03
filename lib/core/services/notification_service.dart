import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Future<String> getDeviceToken() async {
  //   String? token = await messaging.getToken();

  // }

  Future<void> subscribeToHostelNoti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hostelId = prefs.getString("hostelId") ?? "";
    if (hostelId.isNotEmpty) {
      await messaging.subscribeToTopic(hostelId);
      print("subscription done");
      String? token = await messaging.getToken();
      print("token : $token");
    }
  }

  Future<void> unSubscribeToHostelNoti() async {
    print("unsubscribing");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hostelId = prefs.getString("hostelId") ?? "";
    if (hostelId.isNotEmpty) {
      await messaging.unsubscribeFromTopic(hostelId);
    }
  }

  void isRefreshToken() {
    messaging.onTokenRefresh.listen((token) {
      debugPrint('TOken Refereshed  :  $token');
    });
  }

  Future<void> requestNotificationPermisions() async {
    if (Platform.isIOS) {
      await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);
    }

    NotificationSettings notificationSettings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('user is already granted permisions');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('user is already granted provisional permisions');
    } else {
      debugPrint('User has denied permission');
    }
  }

  // For IoS
  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification!.android;

      debugPrint("Notification title: ${notification!.title}");
      debugPrint("Notification title: ${notification.body}");
      debugPrint("Data: ${message.data.toString()}");

      // For IoS
      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(android: androidInitSettings, iOS: iosInitSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (payload) {
      handleMesssage(context, message);
    });
  }

  Future<void> handleMesssage(BuildContext context, RemoteMessage message) async {
    debugPrint('In handleMesssage function');
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(), message.notification!.android!.channelId.toString(),
        importance: Importance.max, showBadge: true, playSound: true);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id.toString(), androidNotificationChannel.name.toString(),
        channelDescription: 'Flutter Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        sound: androidNotificationChannel.sound);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0, message.notification!.title.toString(), message.notification!.body.toString(), notificationDetails);
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      Future.delayed(const Duration(milliseconds: 1500));
      handleMesssage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMesssage(context, event);
    });
  }
}

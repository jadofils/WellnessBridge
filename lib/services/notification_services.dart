import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for critical event notifications.',
    importance: Importance.max,
  );

  static Future<void> initialize() async {
    // Request notification permission using Firebase Messaging
    final messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Notification Permission Status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Notifications are authorized');
    } else {
      print('Notifications are not authorized');
    }

    if (kIsWeb) {
      return;
    }

    // For Android/iOS
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          print('Notification tapped with payload: ${response.payload}');
        }
      },
    );

    // Create notification channel for Android
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static Future<bool> checkNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  static Future<void> requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  static void showLocalNotification(RemoteMessage message) async {
    final bool hasPermission = await checkNotificationPermission();

    if (!hasPermission) {
      print('Notification permission not granted');
      await requestNotificationPermission();
      return;
    }

    if (kIsWeb) {
      // For web, we'll just print the notification
      print('Web Notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      return;
    }

    final notification = message.notification;

    if (notification != null) {
      final androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      final platformDetails = NotificationDetails(android: androidDetails);

      await _notificationsPlugin.show(
        message.hashCode,
        notification.title ?? 'No Title',
        notification.body ?? 'No Body',
        platformDetails,
        payload: message.data.toString(),
      );
    }
  }

  static Future<void> cancelNotification(int id) async {
    if (!kIsWeb) {
      await _notificationsPlugin.cancel(id);
    }
  }

  static Future<void> cancelAllNotifications() async {
    if (!kIsWeb) {
      await _notificationsPlugin.cancelAll();
    }
  }

  static Future<void> testNotification() async {
    if (kIsWeb) {
      print('Testing Web Notification:');
      print('Title: Test Notification');
      print('Body: This is a test notification for web platform');
      return;
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'Used for critical event notifications.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      platformDetails,
      payload: 'test_payload',
    );
  }
}

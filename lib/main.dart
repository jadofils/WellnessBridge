import 'package:flutter/material.dart';
import 'package:wellnessbridge/HomePages/login.dart';
import 'package:wellnessbridge/HomePages/signup.dart';
import 'package:wellnessbridge/HomePages/forgot_password_page.dart';
import 'package:wellnessbridge/HomePages/reset_password_page.dart';
import 'package:wellnessbridge/frontend/admin/dashboard/admin_dashboard.dart';
import 'package:wellnessbridge/frontend/parent/dashboard/parent_dashboard.dart';
import 'package:wellnessbridge/frontend/umunyabuzima/dashboard/umunyabuzima_dashboard.dart';
import 'package:wellnessbridge/database/database_helper.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wellnessbridge/services/notification_services.dart';
import 'firebase_options.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.showLocalNotification(message);
}

void main() async {
  // Ensure Flutter binding is initialized before using plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize timezone and local notification setup
  tz.initializeTimeZones();
  await NotificationService.initialize();

  // Initialize Firebase Messaging for mobile platforms only
  if (!kIsWeb) {
    // Background FCM handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request notification permission
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Print device token (for manual test)
    final token = await messaging.getToken();
    print("📲 FCM Token: $token");

    // Foreground FCM listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(" [Foreground] Notification Received:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      NotificationService.showLocalNotification(message);
    });
  }

  // Initialize the database
  await DatabaseHelper().database;
  String dbPath = await DatabaseHelper().getDatabasePath();
  print('Database location: $dbPath');
  print('SQLite Database initialized and tables created/opened successfully!');

  runApp(const WellnessBridgeApp());
}

class WellnessBridgeApp extends StatelessWidget {
  const WellnessBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WellnessBridge',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/wellnessbridge/page/login',
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/wellnessbridge/page/reset-password') ==
            true) {
          final uri = Uri.parse(settings.name!);
          final token = uri.queryParameters['token'];
          final email = uri.queryParameters['email'];

          if (token != null && email != null) {
            return MaterialPageRoute(
              builder: (context) => ResetPasswordPage(),
              settings: RouteSettings(
                arguments: {'token': token, 'email': email},
              ),
            );
          }
        }
        return null;
      },
      routes: {
        // Auth routes
        '/wellnessbridge/page/signup': (context) => SignUpPage(),
        '/wellnessbridge/page/login': (context) => LoginPage(),
        '/wellnessbridge/page/forgot-password':
            (context) => ForgotPasswordPage(),
        '/wellnessbridge/page/reset-password': (context) => ResetPasswordPage(),

        // Dashboard routes
        '/wellnessbridge/admin/dashboard': (context) => AdminDashboard(),
        '/wellnessbridge/parent/dashboard': (context) => ParentDashboard(),
        '/wellnessbridge/umunyabuzima/dashboard':
            (context) => UmunyabuzimaDashboard(),
      },
      onUnknownRoute: (settings) {
        if (settings.name?.startsWith('myapp://') == true) {
          final uri = Uri.parse(settings.name!);
          if (uri.host == 'reset-password') {
            final token = uri.queryParameters['token'];
            final email = uri.queryParameters['email'];
            if (token != null && email != null) {
              return MaterialPageRoute(
                builder: (context) => ResetPasswordPage(),
                settings: RouteSettings(
                  arguments: {'token': token, 'email': email},
                ),
              );
            }
          }
        }
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
      },
    );
  }
}

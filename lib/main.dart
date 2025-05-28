import 'package:flutter/material.dart';
import 'package:wellnessbridge/HomePages/login.dart';
import 'package:wellnessbridge/HomePages/signup.dart';
import 'package:wellnessbridge/HomePages/forgot_password_page.dart';
import 'package:wellnessbridge/HomePages/reset_password_page.dart';
import 'package:wellnessbridge/frontend/admin/dashboard/admin_dashboard.dart';
import 'package:wellnessbridge/frontend/parent/dashboard/parent_dashboard.dart';
import 'package:wellnessbridge/frontend/umunyabuzima/dashboard/umunyabuzima_dashboard.dart';
import 'package:wellnessbridge/database/database_helper.dart'; // Keep commented for now if running on web
import 'package:wellnessbridge/backend_api/auth/login_api.dart';
import 'package:wellnessbridge/theme/theme.dart';

void main() async {
  // Ensure Flutter binding is initialized before using plugins (like sqflite)
  // Ensure Flutter binding is initialized before using plugins (like sqflite)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database: this will create the database file and all tables
  // if they don't already exist, or open the existing database.
  await DatabaseHelper().database;
  // Print the database path
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
      themeMode:
          ThemeMode
              .system, // This will automatically switch between light and dark theme based on system settings
      initialRoute: '/wellnessbridge/page/login',
      onGenerateRoute: (settings) {
        // Handle reset password route with query parameters
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
        // Handle deep links
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

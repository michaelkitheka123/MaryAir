import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'utils/constants.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'models/booking_state.dart';

import 'screens/auth/registration_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/customer/customer_home_screen.dart';
import 'screens/staff/staff_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookingState()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppConstants.loginRoute,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppConstants.registerRoute:
              return MaterialPageRoute(
                builder: (_) => const RegistrationScreen(),
              );

            case AppConstants.loginRoute:
              return MaterialPageRoute(builder: (_) => const LoginScreen());

            case AppConstants.otpVerificationRoute:
              final args = settings.arguments;
              String email = '';
              if (args is String) {
                email = args;
              } else if (args is Map) {
                email = args['email'] ?? '';
              }
              return MaterialPageRoute(
                builder: (_) => OTPVerificationScreen(email: email),
                settings: settings, // Pass settings so widget can access args
              );

            case AppConstants.forgotPasswordRoute:
              return MaterialPageRoute(
                builder: (_) => const ForgotPasswordScreen(),
              );

            case AppConstants.customerHomeRoute:
              return MaterialPageRoute(
                builder: (_) => const CustomerHomeScreen(),
              );

            // All staff roles use the same screen
            case AppConstants.pilotHomeRoute:
            case AppConstants.staffHomeRoute:
            case AppConstants.attendantHomeRoute:
            case AppConstants.adminHomeRoute:
              return MaterialPageRoute(builder: (_) => const StaffHomeScreen());

            default:
              return MaterialPageRoute(
                builder: (_) => const RegistrationScreen(),
              );
          }
        },
      ),
    );
  }
}

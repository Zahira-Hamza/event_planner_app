import 'package:event_planner_app/view/authetication/forget_password_screen.dart';
import 'package:event_planner_app/view/authetication/sign_in_screen.dart';
import 'package:event_planner_app/view/authetication/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this

import 'core/utils/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    return ScreenUtilInit(
      designSize: const Size(393, 841), // Set your design draft size here
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.signInRoute,
          routes: {
            AppRoutes.signInRoute: (context) => const SignInScreen(),
            AppRoutes.signUpRoute: (context) => const SignUpScreen(),
            AppRoutes.forgetPasswordRoute: (context) =>
                const ForgetPasswordScreen(),
          },
        );
      },
    );
  }
}

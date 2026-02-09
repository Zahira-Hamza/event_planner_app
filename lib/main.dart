import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/create_event_screen.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/profile_tab_screen.dart';
import 'package:event_planner_app/view/Home/bottom_nav_bar_wrapper.dart';
import 'package:event_planner_app/view/authetication/forget_password_screen.dart';
import 'package:event_planner_app/view/authetication/sign_in_screen.dart';
import 'package:event_planner_app/view/authetication/sign_up_screen.dart';
import 'package:event_planner_app/view_model/Language_Provider/app_language_provider.dart';
import 'package:event_planner_app/view_model/Theme_Provider/app_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this
import 'package:provider/provider.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  //* caching on the phone not using the network
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
          ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    //* Initialize ScreenUtil *//
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //*localization*//
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          // Use context.locale (from Easy Localization)
          locale: context.locale,
          //* Theming *//
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.getAppTheme,
          //* Routes *//
          initialRoute: AppRoutes.homeRoute,
          routes: {
            AppRoutes.signInRoute: (context) => const SignInScreen(),
            AppRoutes.signUpRoute: (context) => const SignUpScreen(),
            AppRoutes.forgetPasswordRoute: (context) =>
                const ForgetPasswordScreen(),
            AppRoutes.homeRoute: (context) => const BottomNavBarWrapper(),
            AppRoutes.createEventRoute: (context) => const CreateEventScreen(),
            AppRoutes.profileRoute: (context) => const ProfileTabScreen(),
          },
        );
      },
    );
  }
}

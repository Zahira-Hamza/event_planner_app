import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/create_event_screen.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/update_event_screen.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/pick_event_location.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/profile_tab_screen.dart';
import 'package:event_planner_app/view/Home/bottom_nav_bar_wrapper.dart';
import 'package:event_planner_app/view/authetication/forget_password_screen.dart';
import 'package:event_planner_app/view/authetication/sign_in_screen.dart';
import 'package:event_planner_app/view/authetication/sign_up_screen.dart';
import 'package:event_planner_app/view_model/providers/Language_Provider/app_language_provider.dart';
import 'package:event_planner_app/view_model/providers/Theme_Provider/app_theme_provider.dart';
import 'package:event_planner_app/view_model/providers/app_provider.dart';
import 'package:event_planner_app/view_model/providers/event_list_provider.dart';
import 'package:event_planner_app/view_model/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  // Keep the splash visible while we initialise everything
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  // Load persisted theme & language BEFORE providers are created,
  // so the very first frame already has the correct values.
  final themeProvider = AppThemeProvider();
  final languageProvider = AppLanguageProvider();
  await themeProvider.loadSavedTheme();
  await languageProvider.loadSavedLanguage();

  // Remove splash once init is done
  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      // Start with the saved locale so the app opens in the right language
      startLocale: Locale(languageProvider.appLanguage),
      child: MultiProvider(
        providers: [
          // Use the already-initialised instances so they have saved values
          ChangeNotifierProvider<AppThemeProvider>.value(value: themeProvider),
          ChangeNotifierProvider<AppLanguageProvider>.value(
            value: languageProvider,
          ),
          ChangeNotifierProvider(create: (_) => EventListProvider()),
          ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
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
    final themeProvider = Provider.of<AppThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.getAppTheme,
          initialRoute: AppRoutes.signInRoute,
          routes: {
            AppRoutes.signInRoute: (context) => const SignInScreen(),
            AppRoutes.signUpRoute: (context) => const SignUpScreen(),
            AppRoutes.forgetPasswordRoute: (context) =>
                const ForgetPasswordScreen(),
            AppRoutes.homeRoute: (context) => const BottomNavBarWrapper(),
            AppRoutes.createEventRoute: (context) => const CreateEventScreen(),
            AppRoutes.profileRoute: (context) => const ProfileTabScreen(),
            AppRoutes.pickEventLocationRoute: (context) =>
                const PickEventLocation(),
            AppRoutes.updateEventRoute: (context) => const UpdateEventScreen(),
          },
        );
      },
    );
  }
}

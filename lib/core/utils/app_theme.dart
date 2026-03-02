import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.bluePrimaryColor,
    focusColor: AppColors.whitePrimaryColor,
    cardColor: AppColors.whitePrimaryColor,
    disabledColor: Colors.grey,
    highlightColor: AppColors.bluePrimaryColor,
    canvasColor: AppColors.blackPrimaryColor,
    iconTheme: IconThemeData(color: AppColors.whitePrimaryColor),
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20black,
      headlineMedium: AppStyles.medium16blue,
      headlineSmall: AppStyles.medium16white,
      bodyMedium: AppStyles.medium16black,
      labelMedium: AppStyles.medium16gray,
      labelSmall: AppStyles.medium16gray,
      displayMedium: AppStyles.medium16white,
    ),
    scaffoldBackgroundColor: AppColors.whitePrimaryColor,

    ///app bar theme////////////////
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.TransColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(50),
        ),
      ),
    ),

    ///bottom navigation bar theme////////////////
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.whitePrimaryColor,
      unselectedItemColor: AppColors.whitePrimaryColor,
      //using transparent color for background and the elavation are due to the bottomAppBar widget TO USE THE NOTCH property
      backgroundColor: AppColors.TransColor,
      elevation: 0,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12white,
      unselectedLabelStyle: AppStyles.bold12white,
      type: BottomNavigationBarType.fixed,
    ),

    ///floating action button theme////////////////
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: AppColors.bluePrimaryColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(30),
    //     side: BorderSide(color: AppColors.whitePrimaryColor, width: 4),
    //   ),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.blackBgColor,
    focusColor: AppColors.bluePrimaryColor,
    cardColor: AppColors.blackBgColor,
    disabledColor: Colors.white,
    highlightColor: AppColors.whitePrimaryColor,
    canvasColor: AppColors.whitePrimaryColor,
    iconTheme: IconThemeData(color: AppColors.blackBgColor),

    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20white,
      headlineMedium: AppStyles.medium16white,
      headlineSmall: AppStyles.medium16white,
      bodyMedium: AppStyles.medium16white,
      labelSmall: AppStyles.medium16white,
      labelMedium: AppStyles.medium16blue,
      displayMedium: AppStyles.medium16black,
    ),
    scaffoldBackgroundColor: AppColors.blackBgColor,

    ///app bar theme////////////////
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(50),
        ),
      ),
    ),

    ///bottom navigation bar theme////////////////
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackBgColor,
      selectedItemColor: AppColors.whitePrimaryColor,
      unselectedItemColor: AppColors.whitePrimaryColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12white,
      unselectedLabelStyle: AppStyles.bold12white,
      type: BottomNavigationBarType.fixed,
    ),

    ///floating action button theme////////////////
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.blackBgColor,
    ),
  );
}

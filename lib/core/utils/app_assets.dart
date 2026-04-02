import 'package:flutter/material.dart';

class AppAssets {
  static const String onboarding_logo = "assets/images/onboarding_logo.png";
  static const String auth_logo = "assets/images/auth_logo.png";

  // Light theme event images
  static const String bookClub_image = "assets/images/bookClup_event_image.png";
  static const String birthday_image = "assets/images/birthday_image.png";
  static const String eating_image = "assets/images/eating_image.png";
  static const String exhibition_image = "assets/images/exhibition_image.png";
  static const String gaming_image = "assets/images/gaming_image.png";
  static const String workShop_image = "assets/images/workShop_image.png";
  static const String holiday_image = "assets/images/holiday_image.png";
  static const String love_image = "assets/images/love_image.png";
  static const String meeting_image = "assets/images/meeting_image.png";
  static const String sport_image = "assets/images/sport_event_image.png";

  // Dark theme event images
  static const String bookClub_image_dark =
      "assets/images/dark/bookClup_event_image.png";
  static const String birthday_image_dark =
      "assets/images/dark/birthday_image.png";
  static const String eating_image_dark = "assets/images/dark/eating_image.png";
  static const String exhibition_image_dark =
      "assets/images/dark/exhibition_image.png";
  static const String gaming_image_dark = "assets/images/dark/gaming_image.png";
  static const String workShop_image_dark =
      "assets/images/dark/workShop_image.png";
  static const String holiday_image_dark =
      "assets/images/dark/holiday_image.png";
  static const String love_image_dark = "assets/images/dark/love_image.png";
  static const String meeting_image_dark =
      "assets/images/dark/meeting_image.png";
  static const String sport_image_dark =
      "assets/images/dark/sport_event_image.png";

  // Icons
  static const String edit_icon = "assets/images/edit_icon.png";
  static const String calendar_icon = "assets/images/calendar_icon.png";
  static const String clock_icon = "assets/images/clock_icon.png";
  static const String chooseEvent_icon = "assets/images/chooseEvent_icon.png";
  static const String google_icon = "assets/images/google_icon.png";
  static const String calander_button_icon =
      "assets/images/calander_button_icon.png";

  /// Returns the correct event image for the current theme.
  /// Falls back to the light image if dark variant is not found.
  static String getEventImage(BuildContext context, String lightImagePath) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDark) return lightImagePath;

    // Map light path → dark path
    final darkMap = <String, String>{
      bookClub_image: bookClub_image_dark,
      birthday_image: birthday_image_dark,
      eating_image: eating_image_dark,
      exhibition_image: exhibition_image_dark,
      gaming_image: gaming_image_dark,
      workShop_image: workShop_image_dark,
      holiday_image: holiday_image_dark,
      love_image: love_image_dark,
      meeting_image: meeting_image_dark,
      sport_image: sport_image_dark,
    };
    return darkMap[lightImagePath] ?? lightImagePath;
  }
}

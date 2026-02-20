import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/widgets/language_bottom_sheet.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/widgets/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../view_model/providers/Language_Provider/app_language_provider.dart';
import '../../../view_model/providers/Theme_Provider/app_theme_provider.dart';

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // Language Selection
                  Text(
                    "language".tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    readOnly: true,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const LanguageBottomSheet();
                      },
                    ),
                    decoration: _getInputDecoration(
                      hint: languageProvider.appLanguage == 'ar'
                          ? 'Arabic'.tr()
                          : 'English'.tr(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Theme Selection
                  Text(
                    "theme".tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    readOnly: true,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const ThemeBottomSheet();
                      },
                    ),
                    decoration: _getInputDecoration(
                      hint: themeProvider.isDark ? "Dark".tr() : "Light".tr(),
                    ),
                  ),

                  const Spacer(),

                  // Logout Button
                  _buildLogoutButton(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 60.h,
        bottom: 30.h,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.bluePrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        children: [
          // Profile Image / Logo
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage(
                'assets/images/profile.png',
              ), // Add your logo path
            ),
          ),
          SizedBox(width: 16.w),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("John Safwat", style: AppStyles.bold20white),
                Text(
                  "johnsafwat.route@gmail.com",
                  style: AppStyles.medium16white.copyWith(fontSize: 14.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bluePrimaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.bluePrimaryColor),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: AppStyles.medium16blue),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton.icon(
        onPressed: () {
          // Logout Logic
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text("Logout".tr(), style: AppStyles.medium16white),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5252), // Professional red
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  // Helper for consistent TextField Styling
  InputDecoration _getInputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppStyles.medium16blue,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.bluePrimaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: AppColors.bluePrimaryColor, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: AppColors.bluePrimaryColor, width: 2.w),
      ),
    );
  }
}

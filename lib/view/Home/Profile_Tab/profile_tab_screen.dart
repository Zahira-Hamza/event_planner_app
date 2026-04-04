import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/widgets/language_bottom_sheet.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/widgets/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/Firebase-Firestore/firebase_auth_utils.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../view_model/providers/Language_Provider/app_language_provider.dart';
import '../../../view_model/providers/Theme_Provider/app_theme_provider.dart';
import '../../../view_model/providers/user_provider.dart';

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
                  Text(
                    "language".tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    readOnly: true,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder: (_) => const LanguageBottomSheet(),
                    ),
                    decoration: _getInputDecoration(
                      hint: languageProvider.appLanguage == 'ar'
                          ? 'Arabic'.tr()
                          : 'English'.tr(),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "theme".tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    readOnly: true,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder: (_) => const ThemeBottomSheet(),
                    ),
                    decoration: _getInputDecoration(
                      hint: themeProvider.isDark ? "Dark".tr() : "Light".tr(),
                    ),
                  ),
                  const Spacer(),
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
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final photoUrl = userProvider.currentUser?.photoUrl;
        final isUploading = userProvider.isUploadingPhoto;

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
              // Tappable profile avatar
              GestureDetector(
                onTap: isUploading
                    ? null
                    : () => userProvider.pickAndUploadPhoto(),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: UserAvatar(
                        dataUrl: photoUrl,
                        radius: 35.r,
                        showUploadingSpinner: isUploading,
                      ),
                    ),
                    // Camera badge
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 14.r,
                          color: AppColors.bluePrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.currentUser?.name ?? "User",
                      style: AppStyles.bold20white,
                    ),
                    Text(
                      userProvider.currentUser?.email ?? "",
                      style: AppStyles.medium16white.copyWith(fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton.icon(
        onPressed: () async {
          await FirebaseAuthUtils.logout();
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.signInRoute,
              (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text("Logout".tr(), style: AppStyles.medium16white),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5252),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

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

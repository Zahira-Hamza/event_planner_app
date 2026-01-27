import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_elavated button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forget Password".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.bluePrimaryColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Forget Password Illustration
            Image.asset(
              "assets/images/forget_password_image.png", // Update with your asset path
              height: 350.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),

            // Reset Password Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: CustomElevatedButton(
                onPressed: () {
                  // Handle password reset logic
                },
                buttonText: Text(
                  "Reset Password".tr(),
                  style: AppStyles.bold20white.copyWith(fontSize: 20.sp),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

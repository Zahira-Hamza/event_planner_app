import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_elavated button.dart';
import '../../core/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isRePasswordHidden = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.bluePrimaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Image.asset(
                  AppAssets.auth_logo,
                  height: 180.h,
                  width: 180.w,
                ),
                SizedBox(height: 24.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      /// Name Field
                      CustomTextFormField(
                        textEditingController: nameController,
                        hintText: "Name".tr(),
                        prefixIcon:
                            Icon(Icons.person, color: Colors.grey, size: 22.sp),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty)
                            return "Name is required".tr();
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      /// Email Field
                      CustomTextFormField(
                        textEditingController: emailController,
                        hintText: "Email".tr(),
                        prefixIcon:
                            Icon(Icons.email, color: Colors.grey, size: 22.sp),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty)
                            return "Email is required".tr();
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      /// Password Field
                      CustomTextFormField(
                        textEditingController: passwordController,
                        hintText: "Password".tr(),
                        obscureText: _isPasswordHidden,
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.grey, size: 22.sp),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => _isPasswordHidden = !_isPasswordHidden),
                          icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Password is required".tr();
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      /// Re-Password Field
                      CustomTextFormField(
                        textEditingController: rePasswordController,
                        hintText: "Re Password".tr(),
                        obscureText: _isRePasswordHidden,
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.grey, size: 22.sp),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => _isRePasswordHidden = !_isRePasswordHidden),
                          icon: Icon(
                              _isRePasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value != passwordController.text)
                            return "Passwords do not match".tr();
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),

                      /// Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: CustomElevatedButton(
                          onPressed: signUp,
                          buttonText: Text(
                            "Create Account".tr(),
                            style:
                                AppStyles.bold20white.copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// Already Have Account Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account ? ".tr(),
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.signInRoute),
                            child: Text(
                              "Login".tr(),
                              style: AppStyles.medium16blue.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      /// Language Toggle (Simplified Placeholder for the UI at the bottom)
                      Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.bluePrimaryColor),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                                radius: 15.r, child: const Text("🇺🇸")),
                            SizedBox(width: 8.w),
                            CircleAvatar(
                                radius: 15.r, child: const Text("🇪🇬")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState!.validate()) {
      // Handle local sign up logic
      print("Account Created for: ${nameController.text}");
    }
  }
}
